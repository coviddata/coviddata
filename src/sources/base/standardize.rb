module Sources
  module Base
    class Standardize
      CSV_HEADERS = %w(
        date
        country
        region
        place
        cases
        deaths
        recoveries
      )

      def self.key
        @key
      end

      def self.key=(key)
        @key = key
      end

      def self.config
        @config
      end

      def self.config=(config)
        @config = config
      end

      def self.parent
        Object.const_get(name.split('::')[0..-2].join('::'))
      end

      def initialize
        @output_rows = []
      end

      def perform
        standardize_data
        write_data
      end
    end
  end
end
