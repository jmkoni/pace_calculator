require "rubygems"
require "bundler"

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

require "./app/pace"
require "./app/pace_calculator_controller"
require "./app/converter_service"
