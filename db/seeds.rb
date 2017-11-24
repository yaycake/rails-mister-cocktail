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

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

response = open(url).read

data = JSON.parse(response)

ingredients = data["drinks"]

ingredients.each do |ingredient|
  Ingredient.create(name:ingredient["strIngredient1"])
end


# - - - - - - - - - - SEEDING COCKTAILS

# require 'nokogiri'

# cocktails_url = "http://iba-world.com/iba-cocktails/"

# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search('.blog_list_item_lists').each do |element|
#   Cocktail.create(name: element.css('.blog_text')


#   puts element.text.strip
#   puts element.attribute('href').value
# end
