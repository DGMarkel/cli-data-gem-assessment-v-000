require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper

  def self.scrape_index_page(location)
    vegetable_instance_array = []
    binding.pry

    doc = Nokogiri::HTML(open("https://garden.org/apps/calendar/?q=#{location}"))
    crops = doc.css("tr")

    crops.each do |crop|
      new_vegetable = GardenHelper::Vegetable.new("#{crop.css("td[data-th='Crop']").text.gsub("\n", "")}")
      new_vegetable.sow_seeds_indoors = "#{crop.css("td[data-th='Sow seeds indoors']").text.gsub("\n", "")}"
      new_vegetable.transplant_seedlings = "#{crop.css("td[data-th='Transplant seedlings into the garden']").text.gsub("\n", "")}"
      new_vegetable.direct_sow_seeds = "#{crop.css("td[data-th='Direct sow seeds']").text.gsub("\n", "")}"

      d = crop.css("td[data-th='Crop']")
      veg_doc = Nokogiri::HTML(open("https://garden.org" + "#{d.css('a[href]').first['href']}"))
      new_vegetable.description = veg_doc.css('.panel-body p').first.text.gsub("About #{new_vegetable.name}", "")

      vegetable_instance_array << new_vegetable if new_vegetable.name != ""
    end

    vegetable_instance_array
  end

end
