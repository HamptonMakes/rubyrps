require 'lib/rsp'
require 'lib/bot'
require 'lib/move'
require 'lib/round'
require 'lib/game'

Dir.entries("bots").select { |a| a =~ /.*rb/ }.each do |file|
  require "bots/#{file[0..-4]}"
end


RSP.run