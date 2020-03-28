require_relative './base'

module Sources
  class JhuCsse < Sources::Base
    START_DATE = Date.new(2020, 1, 22)

    def perform
      today = Date.today
      date = START_DATE

      loop do
        fetch_for_date(date)
        date += 1
        break if date > today
      end
    end

    private

    def fetch_for_date(date)
      formatted_date = date.strftime('%m-%d-%Y')

      file_path = "data/sources/jhu_csse/daily_reports/#{formatted_date}.csv"
      file_exists = File.exist?(file_path)
      if file_exists
        puts "Data was already fetched: #{formatted_date}"
        return true
      end

      url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/#{formatted_date}.csv"
      begin
        content = open(url).read
      rescue OpenURI::HTTPError => e
        return false if e.message.include?('404')
        raise e
      end
      File.write(file_path, content)
      puts "Fetched data: #{url}"
      true
    end
  end
end
