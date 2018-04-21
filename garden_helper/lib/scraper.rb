require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper
@@crop_array = []

  #iterates through Gardenate's drop-down menu of global climate zones to access user's index page
  def self.find_index_by_climate_zone(climate_zone)
    user_generated_index = nil
    doc = Nokogiri::HTML(open("https://www.gardenate.com"))

    climate_zone_menu = doc.css('.steps')
    climate_zone_menu.css('option').detect do |menu_option|
      user_generated_index = menu_option if menu_option.text.include?("USA") && menu_option.text.include?("#{climate_zone}")
    end

    user_generated_index.values[0]
  end

  #instantiates new vegetable objects with name and url properties
  def self.scrape_crops_list_and_initialize_crops(user_generated_index)
    doc = Nokogiri::HTML(open("https://www.gardenate.com/?zone=#{user_generated_index}"))
    crops = doc.css('tr')
  end
=begin
    crops.each do |crop|
      new_crop = GardenHelper::Vegetable.new("#{crop.css('td[width="70%"] a[href]').text}")
      new_crop.url = "https://www.gardenate.com#{crop.css('td[width="70%"] a').first['href']}"
      @@crop_array << new_crop
    end
  end

  #creates new properties for vegetables by following their url
  def self.find_crop_and_add_atrributes(user_input)
    crop = @@crop_array.detect {|crop| crop.name == user_input}
    doc = Nokogiri::HTML(open(crop.url))
    crop.description = "#{doc.css('#details').text.gsub("\n", "").gsub("\t", "")}"
    crop.compatible_with = "#{doc.css('.companion').text + "."}"
    crop.sowing = "#{doc.css('.sowing').text.gsub("\n", "").gsub("\t", "").gsub("(Show °C/cm)", "")}"
    crop.spacing = "#{doc.css('.spacing').text.strip}"
    crop.harvesting = "#{doc.css('.harvest').text.strip}"

    crop
  end

=end

  def self.crop_array
    @@crop_array
  end

end
