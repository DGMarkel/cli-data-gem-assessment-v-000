require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper

  def self.scrape_index_page(location)
    crops_at_location = []
    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=" + "#{location}"))
    vegetables = doc.css("a[target='_plant']")
    vegetables.each do |plant|
      new_vegetable = GardenHelper::Vegetable.new("#{plant.text}")
      crops_at_location << new_vegetable
    end
    crops_at_location
  end

  binding.pry

end

# doc.css('.panel-body p').text.split(".").first + "."  =
#"On average, your frost-free growing season starts Apr  9 and ends Nov  7, totalling 212 days"
#doc.css("td[data-th='Crop']").text = run on string of crops
