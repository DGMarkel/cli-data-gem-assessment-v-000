class GardenHelper::CLI
  attr_accessor :location

  def call
    welcome
    menu(@location)
  end

  def welcome
    puts ""
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month.".green
    puts "To best help you, we need to know what growing zone you live in.".green
    puts ""
    puts "If you don't know your growing zone, you can look it up here:".green
    puts "https://garden.org/nga/zipzone/".green
    puts ""
    puts "Garden Helper scrapes through dozens of pages for the information you're looking for, so initial load time could be several minutes."
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
    user_input
  end

  def user_input
    user_input = gets.strip
    if user_input == "exit"
      goodbye
    else
      vegetable = GardenHelper::Vegetable.find_vegetable_and_add_atrributes(user_input)
      formatted_description(vegetable)
      puts "Would you like to see more planting info? (y/n)"
      input = gets.strip.downcase
      if input == "y"
        more_info(vegetable)
      else
        more_veggies?
      end
    end
  end

  def formatted_description(vegetable)
    vegetable.description.scan(/\b.*\b/).each do |sentence|
      print sentence + ". " if sentence.length > 15
      if sentence.length < 15 && sentence != ""
        puts ""
        puts "**#{sentence}**".green
      end
    end
  end

  def formatted_sowing_description(vegetable)
    formatting = vegetable.sowing.strip.split(". ")
    puts "* #{formatting[0]}".green
    puts "#{formatting[1]}"
    puts "#{formatting[2]}"
  end

  def formatted_spacing_description(vegetable)
    formatting = vegetable.spacing.split(":")
    puts "#{formatting[0].green}: {formatting[1]}"
  end

  def formatted_compatibility_description(vegetable)
    formatting = vegetable.compatible_with.split(":")
    puts "#{formatting[0].green}: {formatting[1]}"
  end

  def more_info(vegetable)
    puts ""
    formatted_sowing_description(vegetable)
    formatted_spacing_description(vegetable, spacing)
    formatted_compatibility_description(vegetable)
    puts "* #{vegetable.harvesting}".green
    more_veggies?
  end

  def more_veggies?
    puts ""
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
