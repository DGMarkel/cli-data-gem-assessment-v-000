GardenHelper is a CLI app that tells users what they can plant in their garden this month according to their growing zone.  It scrapes this data from https://garden.org.  Users are prompted to input their city, state, or zip code to access this information.  From there, a menu will list all vegetables by name.  Users are prompted to select a vegetable for more growing and maintenance information.  From there, they can go back to the list of vegetables, or exit the program.

**To be built on top of the basic program**
Users can save a list of vegetables they select to plant in their garden, which they can access at any time while using GardenHelper CLI, by typing 'my garden'.
**----------------------------------------**

1. User is greeting with a welcome message.
2. User is prompted for their location (city, state, or zip code)
3. If the user enters their city or state, greet them again with a cutesy message like "Hey there, Brooklyn!"
4. GardenHelper knows what month it is.
5. GardenHelper puts an unindexed list of vegetables that should be planted this month.
6. "For more growing information, please enter the name of a veggie you'd like to plant."
7. After info, **maybe** ask user if they'd like a list of local retailers selling that plant, if possible.
8. Prompt user to save the veggie to their garden wishlist, go back to the main veggie index, or exit.

GardenHelper files:
garden_helper_cli.rb - CLI for GardenScraper
garden_scraper.rb - scrapes data from https//garden.org, creates new Month and Vegetable class instances
month.rb -- class GardenHelper::Month
vegetable.rb -- class GardenHelper::vegetable
gardener.rb -- saves Vegetable instances to array 'my_garden' and return them in a readable format.

What is a vegetable?
  - has a name
  - has a basic description
  - has growing information:
    - how much it needs to be watered
    - how much sun it needs
    - what kind of soil it likes
    - what plants grow well with it    
  - has a url
    - https://wikipedia.com/#{vegetable.name.downcase.capitalize}
