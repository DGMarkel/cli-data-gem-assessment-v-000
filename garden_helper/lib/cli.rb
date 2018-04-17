require 'date'
require 'pry'

class GardenHelper::CLI
  attr_accessor :location

  def call
    puts ""
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month."
    puts "To best help you, we need to know what growing zone you live in."
    puts ""
    puts "Let's get started!"
    puts "Please enter your city or state below."
    real_location?
    puts ""
    puts "Hiya, #{@location}!  We've got your growing zone down."
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area."
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
      #veg_of_the_month_by_location(location)
      puts ""
      puts "Tomatoes"
      puts "Zucchini"
      puts "Eggplant"
      puts "Peppers"
      puts ""
      puts "For more growing information, enter any of the vegetables listed above."
      puts "You can also exit at any time by typing the magic word (It's exit)."
      user_input
    end

    def user_input
      input = gets.strip
      if input == "exit"
        goodbye
      else
        growing_info_for(input)
        #veg_of_the_month_by_location(location)
        puts "Thinking about planting other veggies? Type menu or exit below."
        input = gets.strip.downcase
        if input == "menu"
          menu#(location)
        end
      end
    end

    def veg_of_the_month_by_location#(location)
    end

    def growing_info_for(vegetable)
      puts ""
      puts "#{vegetable} are purple."
      puts ""
    end

    def goodbye
      puts ""
      puts "Hey, good luck with that garden, #{@location}!  Hope to see your green thumbs around here real soon."
    end

end
