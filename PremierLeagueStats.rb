require_relative 'PremierLeagueApiManager'
require 'rubygems'
require 'rest_client'
require 'json'

premierLeagueApiManager = PremierLeagueApiManager.new()

premierLeagueApiManager.putsPremierLeagueTable()