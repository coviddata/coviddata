require_relative '../src/sources'
require 'pry' unless ENV['WORKFLOW_ACTION']

Sources::Fetch.new.perform
