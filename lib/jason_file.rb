#!/usr/bin/env ruby
# Sauvegarde au format JSON

# Appel aux différents gems utilisé
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

# emails.json crée dans le repertoire db à une variable
@file_json = "../db/emails.json"

# Enregistrer au format JSON
class SaveJsonFile
  def save_result
  	# Appel à la classe Scrapper et récupération des données
  	result = Scrapper.new.data
 	# ouvrir le fichier json // 
    File.open(@file_json, "w") do |file|
      # sauvegaede dans le la variable contenant notre fichier json
      file << JSON.generate(result)      
    end
    puts "Le fichier est bien sauvegarder au format JSON :)"
    puts "Vous pouvez le vérifier dans le répertoire db"
  end  
end