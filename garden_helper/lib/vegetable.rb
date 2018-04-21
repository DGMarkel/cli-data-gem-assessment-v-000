class GardenHelper::Vegetable
  attr_accessor :name, :url, :planting_info, :description, :sowing, :spacing, :harvesting, :compatible_with
  @@vegetable_array = []

  #Instantiaties vegetable objects from scraped climate zone index page
  #Objects have a name and a url to scrape for more data
  #Objects are pushed into vegetable array
  def self.new_from_index_page(user_generated_index)
    vegetables = GardenHelper::Scraper.scrape_vegetables(user_generated_index)
    vegetables.each do |vegetable|
      new_vegetable = GardenHelper::Vegetable.new("#{vegetable.css('td[width="70%"] a[href]').text}")
      new_vegetable.url = "https://www.gardenate.com#{vegetable.css('td[width="70%"] a').first['href']}"
      @@vegetable_array << new_vegetable if !find_vegetable(vegetable)
    end
  end

  def initialize(name)
    @name = name
  end

  def self.find_vegetable(user_input)
    @@vegetable_array.detect {|vegetable| vegetable.name == user_input}
  end

  #Scrapes data for specific vegetable based on user requests
  #Adds new attributes to specific vegetable objects
  #Scraping for individual veg data makes GardenHelper run much faster than loading it with all vegetable data to start.
  def self.find_vegetable_and_add_atrributes(user_input)
    vegetable = find_vegetable(user_input)
    doc = Nokogiri::HTML(open(vegetable.url))
    vegetable.description = "#{doc.css('#details').text}"
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
