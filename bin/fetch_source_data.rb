require_relative '../src/sources/all'
require 'pry' unless ENV['WORKFLOW_ACTION']

Sources::All.new.perform
