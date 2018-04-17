class GardenHelper::CLI

  def call
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month."
    puts "To best help you, we need to know what growing zone you live in."
    puts "Please enter your city or state below."

    location = gets.strip
    if location.to_i == 0
      input.downcase.capitalize
    else
      puts "That's not a real place.  Please try again."
    end

    #for now, location is just Brooklyn
    location
    list_veg_by_location(location)
  end


end
