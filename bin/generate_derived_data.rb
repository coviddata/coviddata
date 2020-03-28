require_relative '../src/sources'
require_relative '../src/generate_derived_data'
require 'pry' unless ENV['WORKFLOW_ACTION']

Sources::Standardize.new.perform
GenerateDerivedData.new.perform
