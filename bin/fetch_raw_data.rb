require_relative '../src/fetch_raw_data'
require 'pry' unless ENV['WORKFLOW_ACTION']

FetchRawData.new.perform
