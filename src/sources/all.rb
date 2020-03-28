Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require_relative file }

module Sources
  class All
    def perform
      Sources::JhuCsse.new.perform
    end
  end
end
