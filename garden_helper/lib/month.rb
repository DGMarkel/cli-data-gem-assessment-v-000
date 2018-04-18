class GardenHelper::month

  def initialize(month)
    vegetable_array = GardenHelper::Scraper.scrape_index_page(location)
      vegetable_array.each.with_index do |vegetable, i|
        if vegetable.sow_seeds_indoors.include?("#{Date::MONTHNAMES[Date.today.month]}"[0..2])||
          vegetable.transplant_seedlings.include?("#{Date::MONTHNAMES[Date.today.month]}"[0..2])||
          vegetable.direct_sow_seeds.include?("#{Date::MONTHNAMES[Date.today.month]}"[0..2])
          puts "#{i + 1}. #{vegetable.name}"
        end
      end
  end

end
