class GardenHelper::Vegetable
<<<<<<< HEAD
  attr_accessor :name, :sow_seeds_indoors, :transplant_seedlings, :direct_sow_seeds
  @@vegetables = []

  def initialize(name)
    @name = name
=======
  attr_accessor :name, :scientific_name, :description, :popular_varieties, :growing_conditions, :url
  @@vegetables = []

  def self.month
    #I should return a bunch of instances of vegetables for this month
    tomato = self.new
    tomato.name = "Tomatoes"
    tomato.scientific_name = "Tomatus Tomaticum"
    tomato.description = "Tomatoes come in many colors, and all of them are equally delicious"
    tomato.popular_varieties = "Bling, blong, and blue."
    tomato.growing_conditions = "Sandy Soil, Ample Sunshine"
    tomato.url = "http://www.wikipedia.com/#{tomato.name}"
    tomato
    puts "#{tomato.name}"
>>>>>>> ea99f8032c37ce80da156380c3a4b5580327b7f4
  end


end
