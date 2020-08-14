#!/usr/bin/env ruby
# Gems
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'csv'
require 'googleauth'

class Application
	def initialize
		puts "Tapez 1 pour sauvegarder en fichier JSON, 2 pour CSV, 3 pour Sheet Google drive:"
		@input = gets.chomp.to_i
	end

	def perform
		if @input == 1 
			SaveJsonFile.new.save_result
		elsif @input == '2'			
			SaveCsvFile.new.save_result
		elsif @input == '3'
			SaveSheetFile.new.save_result
		else 
			puts "ERROR, resaisiser"
			Application.new.perform
		end
	end
end