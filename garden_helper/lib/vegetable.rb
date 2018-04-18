class GardenHelper::Vegetable
  attr_accessor :name, :url, :planting_info, :description, :sowing, :spacing, :harvesting, :compatible_with
  @@vegetables = []

  def initialize(name)
    @name = name
  end


end
