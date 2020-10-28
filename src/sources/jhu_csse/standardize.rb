module Sources
  module JhuCsse
    class Standardize < Sources::Base::Standardize
      Sources.add(self)
      self.key = 'jhu_csse'
      self.config = {
        calculate_sum_of_location_rows: true,
        priority: 2
      }

      INPUT_DIRECTORY = "data/sources/#{self.key}/daily_reports/"
      OUTPUT_DIRECTORY = "data/sources/#{self.key}/standardized/"

      private

      def standardize_data
        Dir.glob("#{INPUT_DIRECTORY}/*.csv").sort.each do |file_path|
          month, day, year = File.basename(file_path).split('.')[0].split('-')
          date = Date.new(year.to_i, month.to_i, day.to_i)

          content = File.read(file_path)
          content = content.gsub(65279.chr(Encoding::UTF_8), '')
          content = content.gsub("\r", '')
          rows = CSV.parse(content, headers: true)
          puts "CSV Headers: #{rows.first.to_h.keys.join(', ')}"
          rows.each do |row|
            add_output_row(row, date)
          end
        end
      end

      def add_output_row(row, date)
        country, region, place = row_to_location_names(row)
        @output_rows << [
          date,
          country,
          region,
          place,
          row['Confirmed'].to_i,
          row['Deaths'].to_i,
          row['Recovered'].to_i
        ]
      end

      def row_to_location_names(row)
        country = row['Country/Region'] || row['Country_Region']
        raise 'Missing country' if country.nil?
        region = row['Province/State'] || row['Province_State']
        place = row['Admin2']
        [country, region, place]
      end

      def write_data
        rows = [Sources::Base::Standardize::CSV_HEADERS] + @output_rows
        output_data = CSV.generate do |csv|
          rows.each do |row|
            csv << row
          end
        end
        File.write("#{OUTPUT_DIRECTORY}/standardized.csv", output_data)
      end
    end
  end
end
