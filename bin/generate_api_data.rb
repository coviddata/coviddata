require_relative '../src/generate_api_data'
require 'pry' unless ENV['WORKFLOW_ACTION']

GenerateApiData.new.perform
