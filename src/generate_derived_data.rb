require 'csv'
require 'date'
require 'json'

class GenerateDerivedData
  INPUT_DIRECTORY = 'data/sources/jhu_csse/daily_reports/'
  API_DIRECTORY = 'docs/v1/'
  NORMALIZED_COUNTRY_NAMES = {
    'Iran (Islamic Republic of)' => 'Iran',
    'Korea, South' => 'South Korea',
    'Mainland China' => 'China',
    'Republic of Korea' => 'South Korea',
    'Taiwan*' => 'Taiwan',
    'US' => 'United States'
  }
  COUNT_KEYS = %i(cases deaths recoveries)
  LOCATION_TYPES_CONFIGS = {
    country: { plural_name: 'countries' },
    region: { plural_name: 'regions' },
    place: { plural_name: 'places' }
  }
  LOCATION_TYPES = LOCATION_TYPES_CONFIGS.keys

  def initialize
    @location_types_location_keys_dates_data = {}
    @location_types_location_keys_locations = {}

    LOCATION_TYPES.each do |location_type|
      @location_types_location_keys_dates_data[location_type] = {}
      @location_types_location_keys_locations[location_type] = {}
    end

    @first_date = nil
  end

  def perform
    aggregate_data
    sort_data
    write_json
    write_csvs
  end

  private

  def aggregate_data
    Dir.glob("#{INPUT_DIRECTORY}/*.csv").sort.each do |file_path|
      month, day, year = File.basename(file_path).split('.')[0].split('-')
      date = Date.new(year.to_i, month.to_i, day.to_i)
      @first_date ||= date

      content = File.read(file_path)
      content = content.gsub(65279.chr(Encoding::UTF_8), '')
      rows = CSV.parse(content, headers: true)
      puts "CSV Headers: #{rows.first.to_h.keys.join(', ')}"
      rows.each do |row|
        LOCATION_TYPES.each do |location_type|
          update_location_data(location_type, row, date)
        end
      end
    end
  end

  def sort_data
    LOCATION_TYPES.each do |location_type|
      location_keys_sort_values = {}
      # Sort dates
      @location_types_location_keys_dates_data[location_type] = @location_types_location_keys_dates_data[location_type].map do |location_key, dates_data|
        dates_data = dates_data.sort_by(&:first)
        location_keys_sort_values[location_key] = [dates_data.last.last[:cumulative][:cases] * -1, location_key]
        [location_key, Hash[dates_data]]
      end
      # Sort locations
      @location_types_location_keys_dates_data[location_type] = @location_types_location_keys_dates_data[location_type].sort_by do |location_key, dates_data|
        location_keys_sort_values[location_key]
      end
      @location_types_location_keys_dates_data[location_type] = Hash[@location_types_location_keys_dates_data[location_type]]
    end
  end

  def update_location_data(location_type, row, date)
    location_names = row_to_location_names(row)
    return if location_names[location_type].nil?
    location = generate_location(location_type, location_names[:country], location_names[:region], location_names[:place])
    location_key = location[:key]
    @location_types_location_keys_dates_data[location_type][location_key] ||= {}

    cumulative_data = {
      cases: row['Confirmed'].to_i,
      deaths: row['Deaths'].to_i,
      recoveries: row['Recovered'].to_i
    }

    existing_data = @location_types_location_keys_dates_data[location_type][location_key][date]
    if existing_data
      existing_cumulative_data = existing_data[:cumulative]
      COUNT_KEYS.each do |count_key|
        cumulative_data[count_key] += existing_cumulative_data[count_key] || 0
      end
    end

    previous_cumulative_data = find_previous_cumulative_location_data(location_type, location_key, date) || Hash.new(0)
    new_data = COUNT_KEYS.map do |count_key|
      [count_key, [cumulative_data[count_key] - previous_cumulative_data[count_key], 0].max]
    end
    data = {
      new: Hash[new_data],
      cumulative: cumulative_data
    }
    @location_types_location_keys_dates_data[location_type][location_key][date] = data
  end

  def row_to_location_names(row)
    country_name = row['Country/Region'] || row['Country_Region']
    raise 'Missing country' if country_name.nil?
    region_name = row['Province/State'] || row['Province_State']
    place_name = row['Admin2']
    {
      country: country_name,
      region: region_name,
      place: place_name
    }
  end

  def find_previous_cumulative_location_data(location_type, location_key, date)
    previous_date = date - 1
    loop do
      return if previous_date < @first_date
      previous_data = @location_types_location_keys_dates_data[location_type][location_key][previous_date]
      return previous_data[:cumulative] if previous_data
      previous_date = previous_date - 1
    end
    nil
  end

  def write_json
    LOCATION_TYPES.each do |location_type|
      plural_name = LOCATION_TYPES_CONFIGS[location_type][:plural_name]
      output_data = @location_types_location_keys_dates_data[location_type].map do |location_key, dates_data|
        location = @location_types_location_keys_locations[location_type][location_key]
        {
          location_type => location,
          dates: dates_data
        }
      end
      File.write("#{API_DIRECTORY}#{plural_name}/stats_pretty.json", JSON.pretty_generate(output_data))
      File.write("#{API_DIRECTORY}#{plural_name}/stats.json", JSON.dump(output_data))
    end
  end

  def write_csvs
    LOCATION_TYPES.each do |location_type|
      COUNT_KEYS.each do |count_key|
        plural_name = LOCATION_TYPES_CONFIGS[location_type][:plural_name]
        location_keys_dates_data = @location_types_location_keys_dates_data[location_type]
        dates = location_keys_dates_data.values.map(&:keys).flatten.uniq.sort
        rows = location_keys_dates_data.map do |location_key, dates_data|
          location = @location_types_location_keys_locations[location_type][location_key]
          case location_type
          when :country
            row = [location[:name]]
          when :region
            row = [location[:name], location[:country][:name]]
          when :place
            row = [location[:name], location[:region][:name], location[:country][:name]]
          end
          row += dates.map do |date|
            dates_data[date]&.dig(:cumulative)&.dig(count_key) || 0
          end
          row
        end
        headers = case location_type
        when :country then ['Country']
        when :region then ['Region', 'Country']
        when :place then ['Place', 'Region', 'Country']
        end
        headers += dates.map { |date| date.to_s }

        rows = [headers] + rows
        output_data = CSV.generate do |csv|
          rows.each do |row|
            csv << row
          end
        end
        File.write("#{API_DIRECTORY}#{plural_name}/#{count_key}.csv", output_data)
      end
    end
  end

  def generate_location(location_type, country_name, region_name=nil, place_name=nil)
    case location_type
    when :country
      country_name = NORMALIZED_COUNTRY_NAMES[country_name] || country_name
      country = {
        key: parameterize(country_name),
        name: country_name
      }
      @location_types_location_keys_locations[:country][country[:key]] = country
      country
    when :region
      country = generate_location(:country, country_name)
      full_name = [region_name, country[:name]].join(', ')
      region = {
        key: parameterize(full_name),
        name: region_name,
        full_name: full_name,
        country: country
      }
      @location_types_location_keys_locations[:region][region[:key]] = region
      region
    when :place
      country = generate_location(:country, country_name)
      region = generate_location(:region, country_name, region_name)
      full_name = [place_name, region[:name], country[:name]].join(', ')
      place = {
        key: parameterize(full_name),
        name: place_name,
        full_name: full_name,
        country: country,
        region: region
      }
      @location_types_location_keys_locations[:place][place[:key]] = place
      place
    end
  end

  def parameterize(string)
    string.strip.gsub(/[^\w]+/, ' ').strip.gsub(/\s+/, '-').downcase
  end
end
