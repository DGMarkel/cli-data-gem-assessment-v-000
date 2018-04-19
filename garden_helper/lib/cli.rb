class GardenHelper::CLI
  attr_accessor :location
  @@all = []

  def call
    welcome
  end

  def welcome
    puts ""
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month.".green
    puts "To best help you, we need to know what growing zone you live in.".green
    puts ""
    puts "If you don't know your growing zone, you can look it up here:"
    puts "https://garden.org/nga/zipzone/"
    puts ""
    puts "Garden Helper scrapes through dozens of pages for the information you're looking for, so initial load time could be several minutes."
    puts "When you're ready, enter your growing zone below. (ex: 7b)".green
    real_location?
    puts ""
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area.".green
    menu(@location)
  end

  def real_location?
    @location = gets.strip
    if @location.length == 2
      @location
    else
      puts "That's not a real place.  Please try again."
      real_location?
    end
  end

  def menu(climate_zone)
    index_page_number = GardenHelper::Scraper.find_index_by_climate_zone(climate_zone)
    GardenHelper::Scraper.scrape_crops_list_and_initialize_vegetables(index_page_number)
    GardenHelper::Scraper.crop_array.each {|crop| puts crop.name}
    puts "For more growing information, enter any of the vegetables listed above.".green
    puts "You can also exit at any time by typing the magic word (It's exit).".green
    user_input
  end

  def user_input
    user_input = gets.strip
    if user_input == "exit"
      goodbye
    else
      GardenHelper::Scraper.scrape_and_add_vegetable_atrributes(user_input)
      puts "Thinking about planting other veggies? Type menu or exit below.".green
      input = gets.strip.downcase
      if input == "menu"
        menu#(location)
      else
        goodbye
      end
    end
  end

  def growing_info_for(vegetable)

    puts ""
    puts "#{vegetable} are purple.".green
    puts ""
  end

  def goodbye
    puts ""
    puts "Hey, good luck with that garden!  Hope to see your green thumbs around here real soon.".green
  end

end
