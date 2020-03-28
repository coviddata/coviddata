module Sources
  module NyTimes
    class Fetch < Sources::Base::Fetch
      def perform
        base_url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/'
        base_file_path = 'data/sources/ny_times/'
        file_names = %w(us-counties.csv us-states.csv)
        file_names.each do |file_name|
          url = "#{base_url}#{file_name}"
          file_path = "#{base_file_path}#{file_name}"
          content = open(url).read
          File.write(file_path, content)
          puts "Fetched data: #{url}"
        end
      end
    end
  end
end
