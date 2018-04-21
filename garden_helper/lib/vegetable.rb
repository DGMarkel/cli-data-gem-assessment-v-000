class GardenHelper::Vegetable
  attr_accessor :name, :url, :planting_info, :description, :sowing, :spacing, :harvesting, :compatible_with
  @@crop_array = []

  def self.new_from_index_page(user_generated_index)
    crops = GardenHelper::Scraper.scrape_crops_list_and_initialize_crops(user_generated_index)
    crops.each do |crop|
      new_crop = GardenHelper::Vegetable.new("#{crop.css('td[width="70%"] a[href]').text}")
      new_crop.url = "https://www.gardenate.com#{crop.css('td[width="70%"] a').first['href']}"
      @@crop_array << new_crop
    end
  end

  def initialize(name)
    @name = name
  end

  def self.find_crop(user_input)
    crop = @@crop_array.detect {|crop| crop.name == user_input}
  end


  def self.find_crop_and_add_atrributes(user_input)
    crop = @@crop_array.detect {|crop| crop.name == user_input}
    doc = Nokogiri::HTML(open(crop.url))
    crop.description = "#{doc.css('#details').text.gsub("\n", "").gsub("\t", "")}"
    crop.compatible_with = "#{doc.css('.companion').text + "."}"
    crop.sowing = "#{doc.css('.sowing').text.gsub("\n", "").gsub("\t", "").gsub("(Show °C/cm)", "")}"
    crop.spacing = "#{doc.css('.spacing').text.strip}"
    crop.harvesting = "#{doc.css('.harvest').text.strip}"

    crop
  end

  def self.crop_array
    @@crop_array
  end

end
