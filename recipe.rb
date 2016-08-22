#Recipe class
require 'rest-client'
require 'json'

class Recipe
  attr_accessor :title, :teaser, :link, :storyDate

  def initialize(title, teaser, link, storyDate)
    @title = title
    @teaser = teaser
    @link = link
    @storyDate = storyDate
  end

  def to_s
    "Recipe: #{title} \nTeaser: #{teaser} \nDate: #{storyDate} \nLink: #{link} \n \n"
  end

end