# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# - - - - - - - - - - SEEDING INGREDIENTS

require 'open-uri'
require 'json'

# url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

# response = open(url).read

# data = JSON.parse(response)

# ingredients = data["drinks"]

# ingredients.each do |ingredient|
#   Ingredient.create(name:ingredient["strIngredient1"])
# end


# - - - - - - - - - - SEEDING COCKTAILS

# seed from "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
# (provides cocktail name as strDrink), (cocktail image URL as strDrinkThumb)
# and provies idDrink as idDrink
# ===> nest iteration for URL = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{idDrink}"
#     (provides instructions as strInstructions), (ingredients as strIngredient 1-15)
#     (measurements (dose descrip) as strMeasure(corresponding  ingredients)


c_url = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"

c_response = open(c_url).read

c_data = JSON.parse(c_response)

cocktails = c_data["drinks"]

cocktails.each do |cocktail|
  sleep(1)
  new_cocktail = Cocktail.new(name: cocktail["strDrink"])
  drink_url = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{cocktail["idDrink"]}"
  drink_response = open(drink_url).read
  drink_data = JSON.parse(drink_response)#json hash of array of hash
  drink = drink_data["drinks"][0] #a hash of singular drink detail
  puts("\n\n\nPHOTO\n#{drink["strDrinkThumb"]}\n\n\n")
  new_cocktail.remote_photo_url = drink["strDrinkThumb"] # set the photo url
  next unless new_cocktail.save



    # drink.each do |kvpair|
        # p kvpair

       i_pattern =  /^strIngredient\d?\d$/  #ingredients pattern
       m_pattern = /^strMeasure\d?\d$/
        ingredients_array = drink.select {|key, value| key =~ i_pattern}.to_h.values.compact.reject{|x| x.strip==""}
        measurements_array = drink.select {|key, value| key =~ m_pattern}.to_h.values.compact.reject{|x| x.strip==""}
        ingredients_array.each_with_index do |ingredient, index|
          ingredient = Ingredient.where(name: ingredient).first_or_create
          puts("\n\n#{measurements_array[index]}\n\n")
          new_dose = ingredient.doses.create(description: measurements_array[index], cocktail_id: new_cocktail.id)
          new_dose.save
          p new_dose.errors.full_messages


        end
      # end
      # create a new dose with the the same indexes of both arrays:

        ###OR: create an ingredients array if value is not ""
        #####look for ingredient id, add to new_cocktail
        # create a new dose: look for description
        ###OR: create new description array


    end








# require 'nokogiri'

# cocktails_url = "http://iba-world.com/iba-cocktails/"

# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search('.blog_list_item_lists').each do |element|

#   new_cocktail = Cocktail.new(name: element.css('.blog_text'))
#     html_doc.search('li').each do |ingredient|
#       new_dose = Dose.new()
#     end
#   end

#   puts element.text.strip
#   puts element.attribute('href').value
# end
