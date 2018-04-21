class GardenHelper::CLI
  attr_accessor :location

  def call
    welcome
    menu(@location)
    user_input
  end

  def welcome
    puts ""
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month.".green
    puts "To best help you, we need to know what growing zone you live in.".green
    puts ""
    puts "If you don't know your growing zone, you can look it up here:".green
    puts "https://garden.org/nga/zipzone/".green
    puts ""
    puts "When you're ready, enter your growing zone below. (ex: 7b)".green
    real_growing_zone?
    puts ""
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area.".green
    puts ""
  end

  def real_growing_zone?
    @location = gets.strip
    if @location.length == 2
      @location
    else
      puts "That's not a real place.  Please try again."
      real_growing_zone?
    end
  end

  def menu(climate_zone)
    user_generated_index = GardenHelper::Scraper.find_index_by_climate_zone(climate_zone)
    GardenHelper::Vegetable.new_from_index_page(user_generated_index)
    GardenHelper::Vegetable.vegetable_array.each {|vegetable| puts vegetable.name}
    puts "For more growing information, enter any of the vegetables listed above.".green
    puts "You can also exit at any time by typing the magic word (It's exit).".green
  end

  def user_input
    user_input = gets.strip
    if user_input == "exit"
      goodbye
    else
      vegetable = GardenHelper::Vegetable.find_vegetable_and_add_atrributes(user_input)
      puts vegetable.description
      puts ""
      puts vegetable.compatible_with
      puts ""
      puts "Would you like to see more planting info? (y/n)"
      input = gets.strip.downcase
      if input == "y"
        puts ""
        puts "* #{vegetable.sowing.strip}"
        puts ""
        puts "* #{vegetable.spacing}"
        puts ""
        puts "* #{vegetable.harvesting}"
        more_veggies?
      else
        more_veggies?
      end
    end
  end

  def more_veggies?
    puts "Thinking about planting other veggies? Type menu or exit below.".green
    input = gets.strip.downcase
    if input == "menu"
      menu(@location)
    else
      goodbye
    end
  end

  def goodbye
    puts ""
    puts "Hey, good luck with that garden!  Hope to see your green thumbs around here real soon.".green
  end

end
