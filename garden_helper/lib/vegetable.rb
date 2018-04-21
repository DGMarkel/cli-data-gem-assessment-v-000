class GardenHelper::Vegetable
  attr_accessor :name, :url, :planting_info, :description, :sowing, :spacing, :harvesting, :compatible_with
  @@vegetable_array = []

  def self.new_from_index_page(user_generated_index)
    vegetables = GardenHelper::Scraper.make_vegetables(user_generated_index)
    vegetables.each do |vegetable|
      new_vegetable = GardenHelper::Vegetable.new("#{vegetable.css('td[width="70%"] a[href]').text}")
      new_vegetable.url = "https://www.gardenate.com#{vegetable.css('td[width="70%"] a').first['href']}"
      @@vegetable_array << new_vegetable
    end
  end

  def initialize(name)
    @name = name
  end

  def self.find_vegetable(user_input)
    @@vegetable_array.detect {|vegetable| vegetable.name == user_input}
  end


  def self.find_vegetable_and_add_atrributes(user_input)
    vegetable = find_vegetable(user_input)
    doc = Nokogiri::HTML(open(vegetable.url))
    vegetable.description = "#{doc.css('#details').text.gsub("\n", "").gsub("\t", "")}"
    vegetable.compatible_with = "#{doc.css('.companion').text + "."}"
    vegetable.sowing = "#{doc.css('.sowing').text.gsub("\n", "").gsub("\t", "").gsub("(Show °C/cm)", "")}"
    vegetable.spacing = "#{doc.css('.spacing').text.strip}"
    vegetable.harvesting = "#{doc.css('.harvest').text.strip}"

    vegetable
  end

  def self.vegetable_array
    @@vegetable_array
  end

end
