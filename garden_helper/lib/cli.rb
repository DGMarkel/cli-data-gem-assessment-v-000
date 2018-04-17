class GardenHelper::CLI
  attr_accessor :location

  def call
    puts ""
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month.".green
    puts "To best help you, we need to know what growing zone you live in.".green
    puts ""
    puts "Let's get started!".green
    puts "Please enter your city or state below.".green
    real_location?
    puts ""
    puts "Hiya, #{@location}!  We've got your growing zone down.".green #add growing zone from scraper here?
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area.".green
    menu#(location)
  end

  def real_location?
    @location = gets.strip
    if @location.to_i < 1
      @location.downcase.capitalize
    else
      puts "That's not a real place.  Please try again."
      real_location?
    end
  end

    def menu#(location)
      GardenHelper::Vegetable.month
=begin
      puts ""
      puts "Tomatoes"
      puts "Zucchini"
      puts "Eggplant"
      puts "Peppers"
      puts ""
=end
      puts "For more growing information, enter any of the vegetables listed above.".green
      puts "You can also exit at any time by typing the magic word (It's exit).".green
      user_input
    end

    def user_input
      input = gets.strip
      if input == "exit"
        goodbye
      else
        growing_info_for(input)
        #veg_of_the_month_by_location(location)
        puts "Thinking about planting other veggies? Type menu or exit below.".green
        input = gets.strip.downcase
        if input == "menu"
          menu#(location)
        else
          goodbye
        end
      end
    end

    def veg_of_the_month_by_location#(location)
    end

    def growing_info_for(vegetable)
      puts ""
      puts "#{vegetable} are purple.".green
      puts ""
    end

    def goodbye
      puts ""
      puts "Hey, good luck with that garden, #{@location}!  Hope to see your green thumbs around here real soon.".green
    end

end
