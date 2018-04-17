class GardenHelper::Vegetable
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
  end


end
