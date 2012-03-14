require 'vcr'
require File.expand_path(File.dirname(__FILE__) + '/../lib/phishtank')

begin
  API_KEY = File.read(File.dirname(__FILE__) + '/../api_key')
rescue
  puts "To work on the library, you must create an 'api_key' file at the root of the directory and enter your PhishTank API key"
end

def fixture_path
  File.expand_path(File.dirname(__FILE__) + '/fixtures')
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :typhoeus
  c.filter_sensitive_data('<API_KEY>') { API_KEY }
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
