require 'csv'
require 'date'
require 'open-uri'

module Sources
  class Base
    def perform
      raise NotImplementedError
    end
  end
end
