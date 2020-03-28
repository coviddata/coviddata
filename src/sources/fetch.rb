require_relative '../sources'

module Sources
  class Fetch
    SOURCES = [
      Sources::JhuCsse,
      Sources::NyTimes
    ]

    def perform
      SOURCES.each do |source_class|
        puts "Fetching #{source_class}"
        source_class::Fetch.new.perform
      end
    end
  end
end
