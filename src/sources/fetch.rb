require_relative '../sources'

module Sources
  class Fetch
    def perform
      Sources.all.map(&:parent).each do |source|
        puts "Fetching #{source}"
        source::Fetch.new.perform
      end
    end
  end
end
