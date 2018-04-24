class GardenHelper::CLI
  attr_accessor :location

  def call
    welcome
    menu
  end

  def welcome
    puts ""
    puts "Welcome to GardenHelper".yellow
    puts "GardenHelper provides detailed planting, growing and harvesting information for crops based"
    puts "on the current month and your local growing conditions."
    puts ""
    puts "If you don't know your climate zone, you can look it up here:"
    puts "https://garden.org/nga/zipzone/".yellow
    puts ""
    puts "When you're ready, enter your climate zone below." + " (ex: 7b)".yellow
    real_growing_zone?
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area.".yellow
    puts ""
  end

  #checks to see if user input is valid
  def real_growing_zone?
    @location = gets.strip
    if @location.length == 2 && @location[0].to_i > 0 && @location[1].to_i == 0
      @location
    else
      puts "That's not valid climate zone.  Please try again.".red
      real_growing_zone?
    end
  end

  #populates vegetable_array with scraped vegetable objects
  #allows me to scrape major data only ONCE in a session
  #scrapes minimal info necessary to make GardenHelper work
  def generate_menu
    user_generated_index = GardenHelper::Scraper.find_index_by_climate_zone(@location)
    GardenHelper::Scraper.scrape_vegetables(user_generated_index)
  end

  #displays vegetable_array as a list
  def menu
    if GardenHelper::Vegetable.vegetable_array.empty?
      generate_menu
    end
    GardenHelper::Vegetable.vegetable_array.each {|vegetable| puts "*".yellow + " #{vegetable.name}"}
    puts ""
    puts "For more growing information:".yellow
    puts "Enter " + "three or more letters ".yellow + "of the vegetable you'd like to read up on."
    puts "Exit ".yellow + "at any time."
    first_user_interface
  end

  #adds attributes to single vegetable objects as the user requests information for them
  #checks validity of search queries
  #allows users to request additional information for a vegetable or exit
  def first_user_interface
    user_input = gets.strip.downcase
    if user_input == "exit"
      goodbye
    else
      if GardenHelper::Vegetable.find_vegetable(user_input)
        vegetable = GardenHelper::Vegetable.find_vegetable_and_add_atrributes(user_input)
        puts "***#{vegetable.name}***".yellow
        formatted_description(vegetable)
        puts ""
        puts ""
        puts "Would you like to see more planting info? (y/n)".yellow
        input = gets.strip.downcase
        if input == "y"
          more_info(vegetable)
        else
          second_user_interface
        end
      else
        puts "Invalid entry.  Please try again."
        first_user_interface
      end
    end
  end

  #presents detailed veggie info on request
  def more_info(vegetable)
    puts ""
    formatted_sowing_description(vegetable)
    formatted_spacing_description(vegetable)
    formatted_compatibility_description(vegetable)
    puts "    *" + " #{vegetable.harvesting}".gsub(" .", "").gsub("..", ".").green
    second_user_interface
  end

  #enables users to return to menu, exit, or see a list of their past searches
  def second_user_interface
    puts ""
    puts "Thinking about planting other veggies? Type " + "'menu'".yellow + " or " + "'exit'".yellow + " at the prompt."
    puts "Want to review the vegetables you've already looked at? Type " + "'my garden'".yellow + "."
    input = gets.strip.downcase
    if input == "menu"
      menu
    elsif input.downcase == "my garden"
      puts ""
      GardenHelper::Vegetable.vegetable_array.each do |vegetable|
        puts "*".yellow + " #{vegetable.name}" if vegetable.description != nil
      end
      second_user_interface
    elsif input == "exit"
      goodbye
    else
      puts "Sorry, I didn't quite get that."
      second_user_interface
    end
  end

  def goodbye
    puts ""
    puts "Hey, good luck with that garden!  Hope to see your green thumbs around here real soon."
  end

  #FORMATTING METHODS

  #Long description of vegetable in paragraph form
  def formatted_description(vegetable)
    vegetable.description.scan(/\b.*\b/).each do |sentence|
      print sentence + ". " if sentence.length > 15
      if sentence.length < 15 && sentence != ""
        puts ""
        puts "**#{sentence}**"
      end
    end
  end

  #Planting details
  def formatted_sowing_description(vegetable)
    formatting = vegetable.sowing.strip.split(".")
    puts "    *" + " #{formatting[0]}".green
    puts "       -".yellow + "#{formatting[1]}" if formatting[1] != "" && formatting[2] != nil
    puts "       -".yellow + " #{formatting[2]}" if formatting[2] != "" && formatting[2] != nil
    puts ""
  end

  #Seed/Seedling spacing info
  def formatted_spacing_description(vegetable)
    formatting = vegetable.spacing.split(":")
    puts "    *" + " #{formatting[0]}:".green + "#{formatting[1].gsub("  ", " ")}"
    puts ""
  end

  #Lists companion crops
  def formatted_compatibility_description(vegetable)
    formatting = vegetable.compatible_with.split(":")
    compatible_plants_list = formatting[1].split(/[., .]/)

    puts "    *" + " #{formatting[0]}:".green
    if formatting[1].include?("Not applicable") || formatting[1].include?("Better") || formatting[1].include?("Best")
      puts "      -".yellow + "#{formatting[1].gsub("..", ".")}"
      puts ""
    else
      compatible_plants_list.each do |plant|
        if plant != "" && plant != "Dry-environment" && plant != "herbs" && !plant.include?("aromatic") && !plant.include?("sp") && !plant.include?("Etc")
          puts "       -".yellow + " #{plant.capitalize.gsub("(", "").gsub(")", "")}"
        end
      end
      puts ""
    end
  end

end
