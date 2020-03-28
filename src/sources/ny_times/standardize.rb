module Sources
  module NyTimes
    class Standardize < Sources::Base::Standardize
      Sources.add(self)
      self.key = 'ny_times'
      self.config = {
        calculate_sum_of_location_rows: false
      }

      INPUT_DIRECTORY = "data/sources/#{self.key}/"
      OUTPUT_DIRECTORY = "data/sources/#{self.key}/standardized/"

      private

      def standardize_data
        file_names = %w(us-counties.csv us-states.csv)
        file_names.each do |file_name|
          file_path = "#{INPUT_DIRECTORY}#{file_name}"

          content = File.read(file_path)
          rows = CSV.parse(content, headers: true)
          puts "CSV Headers: #{rows.first.to_h.keys.join(', ')}"
          rows.each do |row|
            add_output_row(row)
          end
        end
      end

      def add_output_row(row)
        country, region, place = row_to_location_names(row)
        date = row['date']
        @output_rows << [
          date,
          country,
          region,
          place,
          row['cases'].to_i,
          row['deaths'].to_i,
          nil
        ]
      end

      def row_to_location_names(row)
        country = 'United States'
        region = row['state']
        raise 'Missing region' if region.nil?
        place = row['county']
        [country, region, place]
      end

      def write_data
        rows = [Sources::Base::Standardize::CSV_HEADERS] + @output_rows
        output_data = CSV.generate do |csv|
          rows.each do |row|
            csv << row
          end
        end
        File.write("#{OUTPUT_DIRECTORY}standardized.csv", output_data)
      end
    end
  end
end
