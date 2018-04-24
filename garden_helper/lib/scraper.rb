class GardenHelper::Scraper

  #iterates through Gardenate's drop-down menu of global climate zones to access user's index page
  def self.find_index_by_climate_zone(climate_zone)
    user_generated_index = nil
    doc = Nokogiri::HTML(open("https://www.gardenate.com"))

    climate_zone_menu = doc.css('.steps')
    climate_zone_menu.css('option').detect do |menu_option|
      user_generated_index = menu_option if menu_option.text.include?("USA") && menu_option.text.include?("#{climate_zone}")
    end

    user_generated_index.values.last
  end

  #Scrapes all vegetables from user's climate zone page
  def self.scrape_vegetables(user_generated_index)
    doc = Nokogiri::HTML(open("https://www.gardenate.com/?zone=#{user_generated_index}"))
    vegetables = doc.css('tr td[width="70%"]')

    vegetables.each do |vegetable|
      new_vegetable = GardenHelper::Vegetable.new("#{vegetable.css('a[href]').text}")
      new_vegetable.url = "https://www.gardenate.com#{vegetable.css('a').first['href']}"
      if !GardenHelper::Vegetable.find_vegetable(new_vegetable.name.downcase)
        GardenHelper::Vegetable.vegetable_array << new_vegetable
      end
    end
  end

  def self.add_vegetable_attributes(user_input)
    vegetable = GardenHelper::Vegetable.find_vegetable(user_input)
    doc = Nokogiri::HTML(open(vegetable.url))
    vegetable_hash = {
      :description => "#{doc.css('#details').text}",
      :compatible_with => "#{doc.css('.companion').text + "."}",
      :sowing => "#{doc.css('.sowing').text.gsub("\n", "").gsub("\t", "").gsub("(Show °C/cm)", "")}",
      :spacing => "#{doc.css('.spacing').text.strip}",
      :harvesting => "#{doc.css('.harvest').text.strip}"
    }
    vegetable.update(vegetable_hash)
  end
  
end
