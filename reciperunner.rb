#The purpose of this program is to allow a user to input ingredients
#And then search for recipes containing those ingredients using the NPR API
require 'rest-client'
require 'JSON'
require_relative 'recipe'

#Get user input
puts "NPR Recipe Finder"
puts "by Kat Schroeder"
puts ""
puts "............................................."
puts ""
puts "What ingredients would you like to use?"
user_ingredients = gets.chomp
puts ""

#Convert spaces and commas to the proper query format
user_ingredients.gsub! " ", "%20"
user_ingredients.gsub! ", ", "$2C"

#Make the API call
#Store data in the Recipe Class
#Check if there were no matches for the query
def get_from_npr(user_ingredients)
  raw_response=RestClient.get('http://api.npr.org/query?id=1139&fields=title,teaser,storyDate,byline,text&date&searchTerm=' + user_ingredients + '&dateType=story&output=JSON&apiKey=MDE5MDExNzc1MDE0MzA0MDE1NTViZDViOQ001')
  response = JSON.load(raw_response)

  if response["list"]["story"] == nil
    puts "Your search did not find any recipes..."
  else
    recipes = response["list"]["story"].map  do |recipe|
      Recipe.new(
        title = recipe["title"]["$text"],
        teaser = recipe["teaser"]["$text"],
        link = recipe["link"].first["$text"],
        storyDate = recipe["storyDate"]["$text"]
      )
    end
  end

end

puts get_from_npr(user_ingredients)