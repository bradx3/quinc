require 'rubygems'
require 'bundler/setup'

require 'quinc'
require 'quinc/sources/basic'
require 'quinc/sources/fast_modified_files'
require 'quinc/processors/file_mod_time'
require 'quinc/processors/filter_in_by_extension'
require 'quinc/destinations/file_system'

RSpec.configure do |config|

end
