require_relative '../src/generate_derived_data'
require 'pry' unless ENV['WORKFLOW_ACTION']

GenerateDerivedData.new.perform
