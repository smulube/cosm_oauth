$:.push File.expand_path("../lib", __FILE__)
require 'cosm_oauth'

require 'webmock/rspec'

WebMock.disable_net_connect!
