require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper
attr_accessor :page_to_scrape

  def self.find_index_by_climate_zone(climate_zone) #finds correct web address for user's climate zone
    binding.pry
    page_scraper = nil
    doc = Nokogiri::HTML(open("https://www.gardenate.com"))
    climate_zone_list = doc.css('.steps')

    climate_zone_list.css('option').detect do |o|
      page_scraper = o if o.text.include?("USA") && o.text.include?("7b")
    end

    @growing_zone_index = page_scraper.values[0]
    @growing_zone_index
  end

  def self.scrape_index_page #instantiates new vegetable objects with a name property
    crop_array = []
    doc = Nokogiri::HTML(open("https://www.gardenate.com/?zone=#{@growing_zone_index}"))
    crops = doc.css('td[width="70%"]')

    crops.each do |crop|
      new_crop = GardenHelper::Vegetable.new("#{crop.css('a[href]').text}")
      crop_array << new_crop
    end

  def self.scrape_vegetable_info_page

  end
=begin
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
=end

end
