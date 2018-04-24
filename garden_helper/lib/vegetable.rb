class GardenHelper::Vegetable
  attr_accessor :name, :url, :planting_info, :description, :sowing, :spacing, :harvesting, :compatible_with
  @@vegetable_array = []

  def initialize(name)
    @name = name
  end

  def self.find_vegetable(user_input)
    @@vegetable_array.detect {|vegetable| vegetable.name.downcase.include?(user_input)}
  end

  def update(vegetable_hash)
    vegetable_hash.each {|k,v| self.send("#{k}=", v)}
  end


=begin
  def self.find_vegetable_and_add_atrributes(user_input)
    vegetable = find_vegetable(user_input)
    doc = Nokogiri::HTML(open(vegetable.url))

    vegetable.description = "#{doc.css('#details').text}"
    vegetable.compatible_with = "#{doc.css('.companion').text + "."}"
    vegetable.sowing = "#{doc.css('.sowing').text.gsub("\n", "").gsub("\t", "").gsub("(Show °C/cm)", "")}"
    vegetable.spacing = "#{doc.css('.spacing').text.strip}"
    vegetable.harvesting = "#{doc.css('.harvest').text.strip}"

    vegetable
  end
=end
  def self.vegetable_array
    @@vegetable_array
  end

end
