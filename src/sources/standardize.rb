require_relative '../sources'

module Sources
  class Standardize
    def perform
      Sources.all.each do |source|
        puts "Standardizing #{source}"
        source.new.perform
      end
    end
  end
end
