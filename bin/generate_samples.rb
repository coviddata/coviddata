require 'fileutils'
require 'json'

resources = %w(countries places regions)
stat_types = %w(cases deaths recoveries)

output_directory = 'data/samples/v1/'

resources.each do |resource|
  resource_directory = "#{output_directory}#{resource}"
  FileUtils.mkdir_p(resource_directory)

  stat_types.each do |stat_type|
    data = File.read("docs/v1/#{resource}/#{stat_type}.csv")
    lines = data.split("\n")
    output = lines.first(4).join("\n")
    File.write("#{resource_directory}/#{stat_type}.csv", output)
  end

  places = JSON.parse(File.read("docs/v1/#{resource}/stats_pretty.json"))
  place = places[0]
  place['dates'] = Hash[place['dates'].to_a.last(2)]
  File.write("#{resource_directory}/stats_pretty.json", JSON.pretty_generate([place]))
end
