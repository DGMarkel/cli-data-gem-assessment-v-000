class GardenHelper::CLI
  attr_accessor :location

  def call
    welcome
    menu
  end

  def welcome
    puts ""
    puts "GardenHelper tells you what you can plant in your garden this month according to your climate zone.".green
    puts "It provides you with detailed growing and harvesting information for each plant based on the your local growing conditions.".green
    puts ""
    puts "If you don't know your climate zone, you can look it up here:".green
    puts "https://garden.org/nga/zipzone/".green
    puts ""
    puts "When you're ready, enter your climate zone below. (ex: 7b)".green
    real_growing_zone?
    puts ""
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area.".green
    puts ""
  end

  def real_growing_zone?
    @location = gets.strip
    if @location.length == 2 && @location[0].to_i > 0 && @location[1].to_i == 0
      @location
    else
      puts "That's not valid climate zone.  Please try again.".red
      real_growing_zone?
    end
  end

  def generate_menu
    user_generated_index = GardenHelper::Scraper.find_index_by_climate_zone(@location)
    GardenHelper::Vegetable.new_from_index_page(user_generated_index)
    binding.pry
  end


  def menu
    if GardenHelper::Vegetable.vegetable_array.empty?
      generate_menu
    end
    GardenHelper::Vegetable.vegetable_array.each {|vegetable| puts "*".yellow + " #{vegetable.name}"}
    puts "For more growing information, enter at least the first three letters of the vegetable you'd like to read up on.".green
    puts "You can also exit at any time by typing the magic word (It's exit).".green
    first_user_interface
  end

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
        puts "Would you like to see more planting info? (y/n)".green
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
    formatting = vegetable.sowing.strip.split(".")
    puts "    * #{formatting[0]}".green
    puts "       -".yellow + "#{formatting[1]}"
    puts "       -".yellow + " #{formatting[2]}" if formatting[2] != "" && formatting[2] != nil
    puts ""
  end

  def formatted_spacing_description(vegetable)
    formatting = vegetable.spacing.split(":")
    puts "    * #{formatting[0]}:".green + "#{formatting[1].gsub("  ", " ")}"
    puts ""
  end

  def formatted_compatibility_description(vegetable)
    formatting = vegetable.compatible_with.split(":")
    compatible_plants_list = formatting[1].split(/[., .]/)

    puts "    * #{formatting[0]}:".green
    if formatting[1].include?("Not applicable")
      puts "      -".yellow + "#{formatting[1].gsub("..", ".")}"
      puts ""
    else
      compatible_plants_list.each do |plant|
        if plant != "" && plant != "Dry-environment" && plant != "herbs" && !plant.include?("aromatic")
          puts "       -".yellow + " #{plant.capitalize.gsub("(", "").gsub(")", "")}"
        end
      end
      puts ""
    end
  end

  def more_info(vegetable)
    puts ""
    formatted_sowing_description(vegetable)
    formatted_spacing_description(vegetable)
    formatted_compatibility_description(vegetable)
    puts "    * #{vegetable.harvesting}".green
    second_user_interface
  end

  def second_user_interface
    puts ""
    puts "Thinking about planting other veggies? Type ".green + "'menu'".yellow + " or ".green + "'exit'".yellow + " at the prompt.".green
    puts "Want to review the vegetables you've already looked at? Type ".green + "'my garden'".yellow + ".".green
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
    puts "Hey, good luck with that garden!  Hope to see your green thumbs around here real soon.".green
  end

end
