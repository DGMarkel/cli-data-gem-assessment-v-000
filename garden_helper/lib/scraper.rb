require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper
  attr_accessor :vegetable_array
  @@vegetables = []

  def self.scrape_index_page(location)

    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=" + "#{location}"))
    crops = doc.css("tr")

    crops.each do |crop|
      new_vegetable = GardenHelper::Vegetable.new("#{crop.css("td[data-th='Crop']").text.gsub("\n", "")}")
      new_vegetable.sow_seeds_indoors = "#{crop.css("td[data-th='Sow seeds indoors']").text.gsub("\n", "")}"
      new_vegetable.transplant_seedlings = "#{crop.css("td[data-th='Transplant seedlings into the garden']").text.gsub("\n", "")}"
      new_vegetable.direct_sow_seeds = "#{crop.css("td[data-th='Direct sow seeds']").text.gsub("\n", "")}"
      @@vegetables << new_vegetable if new_vegetable.name != ""
    end

    @@vegetable_instance_array
  end

  def self.vegetables
    @@vegetables
  end

end
