require 'nokogiri'
require 'open-uri'

<<<<<<< HEAD
class GardenHelper::Scraper

  def self.scrape_index_page(location)
    vegetable_instance_array = []

    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=" + "#{location}"))
    crops = doc.css("tr")

    crops.each do |crop|
      new_vegetable = GardenHelper::Vegetable.new("#{crop.css("td[data-th='Crop']").text.gsub("\n", "")}")
      new_vegetable.sow_seeds_indoors = "#{crop.css("td[data-th='Sow seeds indoors']").text.gsub("\n", "")}"
      new_vegetable.transplant_seedlings = "#{crop.css("td[data-th='Transplant seedlings into the garden']").text.gsub("\n", "")}"
      new_vegetable.direct_sow_seeds = "#{crop.css("td[data-th='Direct sow seeds']").text.gsub("\n", "")}"
      vegetable_instance_array << new_vegetable if new_vegetable.name != ""
    end

    vegetable_instance_array
  end

end
=======
class Scraper

  def self.scrape_index_page(location)
    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/" + "#{location}"))
    binding.pry
    #@@garden_vegetables_array <<

  end

end

Scraper.scrape_index_page("Brooklyn")
>>>>>>> ea99f8032c37ce80da156380c3a4b5580327b7f4
