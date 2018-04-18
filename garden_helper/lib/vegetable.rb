class GardenHelper::Vegetable
  attr_accessor :name, :url, :planting_info
  @@vegetables = []

  def initialize(name)
    @name = name
  end


end
