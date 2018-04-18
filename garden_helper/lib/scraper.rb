require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper

  def self.scrape_index_page(location)
    a = []

    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=" + "#{location}"))
    crops = doc.css("tr")

    crops.each do |crop|
      new_vegetable = GardenHelper::Vegetable.new("#{crop.css("td[data-th='Crop']").text.gsub("\n", "")}")
      new_vegetable.sow_seeds_indoors = "#{crop.css("td[data-th='Sow seeds indoors']").text.gsub("\n", "")}"
      new_vegetable.transplant_seedlings = "#{crop.css("td[data-th='Transplant seedlings into the garden']").text.gsub("\n", "")}"
      new_vegetable.direct_sow_seeds = "#{crop.css("td[data-th='Direct sow seeds']").text.gsub("\n", "")}"
      a << new_vegetable if new_vegetable.name != ""
    end
    a
  end

  binding.pry

end

# doc.css('.panel-body p').text.split(".").first + "."  =
#"On average, your frost-free growing season starts Apr  9 and ends Nov  7, totalling 212 days"
#doc.css("td[data-th='Crop']").text = run on string of crops
