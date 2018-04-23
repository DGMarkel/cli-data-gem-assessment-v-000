require 'nokogiri'
require 'open-uri'

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
    doc.css('tr')
  end

end
