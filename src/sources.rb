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
    @all ||= []
    @all
  end

  def self.add(source)
    all << source
  end

  def self.keys
    all.map { |source| source::Standardize.key }
  end
end

require_all(File.dirname(__FILE__) + '/sources/base/*.rb')
require_all(File.dirname(__FILE__) + '/sources/**/*.rb')
