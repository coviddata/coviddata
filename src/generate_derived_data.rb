class GenerateDerivedData
  SOURCES_DIRECTORY = 'data/sources/'
  API_DIRECTORY = 'docs/v1/'
  NORMALIZED_COUNTRY_NAMES = YAML.load_file('src/config/normalized_location_names.yaml')
  COUNT_KEYS = %i(cases deaths recoveries)
  LOCATION_TYPES_CONFIGS = {
    country: { plural_name: 'countries' },
    region: { plural_name: 'regions' },
    place: { plural_name: 'places' }
  }
  LOCATION_TYPES = LOCATION_TYPES_CONFIGS.keys
  FIRST_DATE = Date.new(2020, 1, 22)
  COUNTRY_KEYS_SOURCE_KEYS = {
    'united-states' => 'ny_times'
  }
  COUNTRY_KEYS_LATEST_REGION_SOURCE_KEYS = {
    'united-states' => 'jhu_csse'
  }

  def initialize
    @location_types_location_keys_dates_data = {}
    @location_types_location_keys_locations = {}
    @today = Date.today

    LOCATION_TYPES.each do |location_type|
      @location_types_location_keys_dates_data[location_type] = {}
      @location_types_location_keys_locations[location_type] = {}
    end
  end

  def perform
    aggregate_data
    sort_data
    write_json
    write_csvs
  end

  private

  def aggregate_data
    Sources.all.each do |source|
      source_key = source.key
      file_path = "#{SOURCES_DIRECTORY}#{source_key}/standardized/standardized.csv"
      puts "Aggregating data from #{file_path}"
      content = File.read(file_path)
      rows = CSV.parse(content, headers: true)
      rows.each do |row|
        LOCATION_TYPES.each do |location_type|
          add_location_data(source, location_type, row)
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

  def add_location_data(source, location_type, row)
    location_names = row_to_location_names(row)
    return if location_names[location_type].nil?
    location = generate_location(location_type, location_names[:country], location_names[:region], location_names[:place])
    date = Date.parse(row['date'])
    return unless is_valid_location?(location)
    return unless is_valid_source?(source, location_type, location, date) && is_relevant_row?(source, location_type, location_names)

    location_key = location[:key]
    @location_types_location_keys_dates_data[location_type][location_key] ||= {}

    cumulative_data = {
      cases: row['cases'].to_i,
      deaths: row['deaths'].to_i,
      recoveries: row['recoveries'].to_i
    }

    if source.config[:calculate_sum_of_location_rows]
      existing_date_data = @location_types_location_keys_dates_data[location_type][location_key][date]
      if existing_date_data
        existing_cumulative_data = existing_date_data[:cumulative]
        COUNT_KEYS.each do |count_key|
          cumulative_data[count_key] += existing_cumulative_data[count_key] || 0
        end
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

  def is_relevant_row?(source, location_type, location_names)
    return true if source.config[:calculate_sum_of_location_rows]
    case location_type
    when :country
      location_names[:region].nil? && location_names[:place].nil?
    when :region
      location_names[:place].nil?
    else
      true
    end
  end

  def is_valid_location?(location)
    # The JHU dataset includes some country names in the region column, so we should remove those as regions.
    return false if location[:location_type] == :region && location[:name] == location[:country][:name]
    true
  end

  def is_valid_source?(source, location_type, location, date)
    return true if location_type == :country
    country_key = location[:country]&.dig(:key) || location[:key]
    custom_country_source_key = COUNTRY_KEYS_SOURCE_KEYS[country_key]
    if custom_country_source_key
      return true if custom_country_source_key == source.key
      # The NY Times data doesn't have the latest date's data, so we'll use JHU data in this case. If NY Times data does exist, it will
      # overwrite the JHU data.
      return true if COUNTRY_KEYS_LATEST_REGION_SOURCE_KEYS[country_key] == source.key && location_type == :region && date >= @today - 1
      return false
    end
    true
  end

  def row_to_location_names(row)
    country_name = row['country']
    raise 'Missing country' if country_name.nil?
    region_name = row['region']
    place_name = row['place']
    {
      country: country_name,
      region: region_name,
      place: place_name
    }
  end

  def find_previous_cumulative_location_data(location_type, location_key, date)
    previous_date = date - 1
    loop do
      return if previous_date < FIRST_DATE
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
        location.delete(:location_type)
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
          last_value = nil
          row += dates.map do |date|
            value = dates_data[date]&.dig(:cumulative)&.dig(count_key)
            # If we're missing data from the last day, use the previous day's data
            if value.nil? && date >= @today - 1
              value = last_value
            end
            value ||= 0
            last_value = value
            value
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
        location_type: location_type,
        key: parameterize(country_name),
        name: country_name
      }
      @location_types_location_keys_locations[:country][country[:key]] = country
      country
    when :region
      country = generate_location(:country, country_name)
      full_name = [region_name, country[:name]].join(', ')
      region = {
        location_type: location_type,
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
        location_type: location_type,
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
