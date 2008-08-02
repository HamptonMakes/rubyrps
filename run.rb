#!/usr/bin/env ruby
require 'lib/rsp'
require 'lib/bot'
require 'lib/move'
require 'lib/round'
require 'lib/game'

Dir.glob("bots/*.rb").each do |file|
  require file
end


RSP.run ARGV
