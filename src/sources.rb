require 'csv'
require 'date'
require 'json'
require 'open-uri'
require 'yaml'

def require_all(pattern)
  Dir[pattern].each { |path| require path }
end

module Sources
  def self.all
    unsorted.sort_by { |source| source.config[:priority] }.reverse
  end

  def self.unsorted
    @unsorted ||= []
    @unsorted
  end

  def self.add(source)
    unsorted << source
  end

  def self.keys
    all.map { |source| source::Standardize.key }
  end
end

require_all(File.dirname(__FILE__) + '/sources/base/*.rb')
require_all(File.dirname(__FILE__) + '/sources/**/*.rb')
