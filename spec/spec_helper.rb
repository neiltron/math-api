$:.push File.expand_path("../lib", __FILE__)

require 'math-api'
require 'fakeweb'

FakeWeb.allow_net_connect = false