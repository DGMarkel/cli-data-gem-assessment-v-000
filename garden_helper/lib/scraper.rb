require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper

  def self.scrape_index_page(location)
    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=" + "#{location}"))
  end

  binding.pry

end
