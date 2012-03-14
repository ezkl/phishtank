require 'vcr'
require File.expand_path(File.dirname(__FILE__) + '/../lib/phishtank')

API_KEY = "dad4255d1d50896dd9d981d0bde43176ed5020cda62ecd077a4e1652e12e1e3f"

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
