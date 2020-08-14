#!/usr/bin/env ruby
# Projet : Enregistrer les données scrapper en format JSON, Spreadsheet, et CSV
# Gems
require 'rubygems'
require 'nokogiri'
require 'rest-client'
# require 'open-uri'
require 'pry'
require 'json'
require 'googleauth'
require 'csv'

# URL de val d'oise : http://annuaire-des-mairies.com/val-d-oise.html // On décompose
  @base_url = 'http://annuaire-des-mairies.com'
  @id_1 = '/val-d-oise.html' # Page 1 contenant les noms des villes
  # emails.json crée dans le repertoire db à une variable
  @file_json = "./db/emails.json"

# class Scrapper
	# Former le lien + Lire et récupérer la page
	  def create_url(id)
	    url = "#{@base_url}"<<"#{id}"
	    html = RestClient.get(url)
	    return doc = Nokogiri::HTML.parse(html)
	  end

	# Sélectionner les balises contenant les noms des villes
	  def acc_page1
	 	doc = create_url(@id_1)
	    return page = doc.css('a.lientxt')
	  end

	# Récupérer les noms des villes (tableau)
	  def name_city
	  	page = acc_page1
	    puts "first etape"
	    return city = page.map{ |x| x.text }
	  end
	 
	# Récupérer tous les id des pages contenant l'adresse mail des vil d'oise
	  def get_id_mail
	  	page = acc_page1
	    return id_mail = page.map{ |x| x.attribute('href').value.slice(1..-1) } #suppresion du '.' au début
	  end

	# Récupérer l'adresse mail dans une page
	  def get_mail(id)
	  	doc = create_url(id)
	    page =  doc.css('tbody tr.txt-primary td') # Selection les nom des villes et stocker dans le tableau name_city
	    return id_mail = page[7].text
	  end

	# Récupérer tous les mails de la ville et stocker dans un tableau
	  def mail_city
	  	id_mail = get_id_mail
	  	mail = []
	    i = 0
	    puts "second etape"
	    while i < 185      #nombres des éléments trouvé
	      mail << get_mail(id_mail[i])
	      i += 1
	    end
	    return mail
	  end

	# Résultat dans un tableau de hash
	  def data
	  	city = name_city
	  	mail = mail_city
	  	result = Hash.new
	    i = 0
	    puts "third etape"
	    while i < 185
	      result[city[i]] = mail[i]
	      i += 1
	    end
	    return result
	  end 

# Enregistrer au format JSON
  def save_result_json
  	# Appel à la classe Scrapper et récupération des données
  	result = data
 	# ouvrir le fichier json // 
    File.open(@file_json, "w") do |file|
      # sauvegaede dans le la variable contenant notre fichier json
      file << JSON.generate(result)      
    end
    puts "Le fichier est bien sauvegarder au format JSON :)"
    puts "Vous pouvez le vérifier dans le répertoire db"
  end  

# Enregistrer au format CSV
  def save_result_csv
  	# Récupération des informations de scrapping
  	result = data
  	# Sauvegarde des données au format CSV
  	CSV.open("./db/emails", "wb") {|csv| result.to_a.each {|elem| csv << elem} }
  	puts "Le fichier est bien sauvegarder au format JSON :)"
    puts "Vous pouvez le vérifier dans le répertoire db"
  end

# sauvegarde dans spreadsheet
  def save_result_sheet
#  redentials = Google::Auth::UserRefreshCredentials.new(
#   client_id: "YOUR CLIENT ID",
#   client_secret: "YOUR CLIENT SECRET",
#   scope: [
#     "https://www.googleapis.com/auth/drive",
#     "https://spreadsheets.google.com/feeds/",
#   ],
#   redirect_uri: "http://example.com/redirect")
# auth_url = credentials.authorization_uri
  end
# end

# Lancement application 
# class Application 
	def saisie
		puts "Tapez 1 pour sauvegarder en fichier JSON, 2 pour CSV :"
		return @input = gets.chomp.to_i
	end

	def perform
		saisie
		if @input == 1 
			save_result_json
		elsif @input == 2			
			save_result_csv
		else 
			puts "ERROR, resaisiser"
			perform
		end
	end
# end