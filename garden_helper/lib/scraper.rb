require 'nokogiri'
require 'open-uri'

class GardenHelper::Scraper
@@crop_array = []

  def self.find_index_by_climate_zone(climate_zone) #finds correct web address for user's climate zone
    page_scraper = nil
    doc = Nokogiri::HTML(open("https://www.gardenate.com"))
    climate_zone_list = doc.css('.steps')

    climate_zone_list.css('option').detect do |o|
      page_scraper = o if o.text.include?("USA") && o.text.include?("#{climate_zone}")
    end

    index_page_number = page_scraper.values[0]
    index_page_number
  end

  def self.scrape_crops_list_and_initialize_vegetables(index_page_number) #instantiates new vegetable objects with a name property
    doc = Nokogiri::HTML(open("https://www.gardenate.com/?zone=#{index_page_number}"))
    crops = doc.css('tr')

    crops.each do |crop|
      new_crop = GardenHelper::Vegetable.new("#{crop.css('td[width="70%"] a[href]').text}")
      new_crop.url = "https://www.gardenate.com#{crop.css('td[width="70%"] a').first['href']}"
      new_crop.planting_info = "#{crop.css('td').last.text.gsub('\t', '')}"
      @@crop_array << new_crop
    end
  end

  def self.scrape_and_add_vegetable_atrributes #creates new properties for vegetables by following their url
    @@crop_array.each do |crop|
      doc = Nokogiri::HTML(open(crop.url))
      crop.description = "#{doc.css('#details').text.gsub("\n", "").gsub("\t", "")}"
      crop.compatible_with = "#{doc.css('.companion').text + "."}"
      crop.sowing = "#{doc.css('.sowing').text.gsub("\n", "").gsub("\t", "").gsub("(Show °C/cm)", "")}"
      crop.spacing = "#{doc.css('.spacing').text.strip}"
      crop.harvesting = "#{doc.css('.harvest').text.strip}"
    end
    @@crop_array
  end

  def self.crop_array
    @@crop_array
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
