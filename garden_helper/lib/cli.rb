require 'date'

class GardenHelper::CLI

  def call
    puts "Garden Helper helps you determine which vegetables you should be planting in your garden this month."
    puts "To best help you, we need to know what growing zone you live in."
    puts ""
    puts "Let's get started!"
    puts "Please enter your city or state below."

    location = gets.strip
    if location.to_i == 0
      location.downcase.capitalize
    else
      puts "That's not a real place.  Please try again."
    end

    puts "Hiya, #{location}!  We've got your growing zone down."
    puts "For the month of #{Date::MONTHNAMES[Date.today.month]}, we're recommending that you plant the following vegetables in your area."
    list_veg_by_location(location)
  end

    def list_veg_by_location(location)
      #veg_of_the_month_by_location(location)
      puts "Tomatoes"
      puts "Zucchini"
      puts "Eggplant"
      puts "Peppers"
      puts "For more growing information, enter any of the vegetables listed above."
      puts "You can also exit at any time by typing the magic word (It's exit)."
      user_input
    end

    def user_input
      input = gets.strip
      until input == "exit"
        growing_info_for(input)
        #veg_of_the_month_by_location(location)
        puts "Thinking about planting other veggies? Enter another one below or exit."
        input = gets.strip
      end
    end


    def veg_of_the_month_by_location(location)
    end

    def growing_info_for(vegetable)
      puts "#{vegetable} are purple."
    end

end
