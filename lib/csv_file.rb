#!/usr/bin/env ruby
# Sauvegarde au format JSON

# Appel aux différents gems utilisé
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'csv'

# Enregistrer au format CSV
class SaveCsvFile 
  def save_result
  	# Récupération des informations de scrapping
  	result = Scrapper.new.data
  	# Sauvegarde des données au format CSV
  	CSV.open("../db/emails", "wb") {|csv| result.to_a.each {|elem| csv << elem} }
  	puts "Le fichier est bien sauvegarder au format JSON :)"
    puts "Vous pouvez le vérifier dans le répertoire db"
  end
end