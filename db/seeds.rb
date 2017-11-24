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
  sleep(5)
  new_cocktail = Cocktail.new(name: cocktail["strDrink"])

  drink_url = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{cocktail["idDrink"]}"

  drink_response = open(drink_url).read

  drink_data = JSON.parse(drink_response)#json hash of array of hash

  drink = drink_data["drinks"][0] #a hash of singular drink detail

    # drink.each do |kvpair|
        # p kvpair
      new_cocktail.photo = drink["strDrinkThumb"] # set the photo url
       i_pattern =  /^strIngredient\d?\d$/  #ingredients pattern
       m_pattern = /^strMeasure\d?\d$/
        p ingredients_array = drink.select {|key, value| key =~ i_pattern}.to_h.values.compact.reject{|x| x.strip==""}
        p measurements_array = drink.select {|key, value| key =~ m_pattern}.to_h.values.compact.reject{|x| x.strip==""}
        ingredients_array.each do |ingredient|
          if Ingredient.where(name: ingredient)
            next
          else
            new_ingredient = Ingredient.new(name: ingredient)
            new_ingredient.save!
            p new_ingredient.errors.full_messages
          end
          Dose.create()

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
