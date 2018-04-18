require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper

  def self.scrape_index_page(location)
    a = []
    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=Brooklyn"))
    crops = doc.css("tr")
    crop = crops.css("td[data-th='Crop']")
    crop.each do |vegetable|
      new_vegetable = GardenHelper::Vegetable.new("#{vegetable.text}")
      a << new_vegetable
    end
    crops_at_location.uniq

  end
  binding.pry

end

# doc.css('.panel-body p').text.split(".").first + "."  =
#"On average, your frost-free growing season starts Apr  9 and ends Nov  7, totalling 212 days"
#doc.css("td[data-th='Crop']").text = run on string of crops
