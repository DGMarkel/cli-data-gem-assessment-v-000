class GardenHelper::Vegetable
  attr_accessor :name, :description, :sow_seeds_indoors, :transplant_seedlings, :direct_sow_seeds
  @@vegetables = []

  def initialize(name)
    @name = name
  end


end
