# GardenHelper

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/garden_helper`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'garden_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install garden_helper

## Usage

GardenHelper is a CLI app that tells users what they can plant in their garden this month according to their climate zone.
It provides detailed growing and harvesting information for each plant based on the user's local growing conditions.

GardenHelper scrapes this data from https://gardenate.com.  Users are prompted to input their climate zone number to access this information.  From there, a menu lists all vegetables by name.  Users are prompted to select a vegetable by the first three letters of its name.  Doing so yields an in-depth description of the species.  

A subsequent prompt asks users if they'd like detailed growing instructions for the plant.  This includes:
  - Sowing instructions (for seeds and seedlings)
  - Spacing details (how far apart seeds/seedlings should be placed)
  - Harvesting dates (Amount of time from planting to harvest)
  - Compatability (lists vegetables that make good companion crops)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'DGMarkel'/garden_helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GardenHelper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'DGMarkel'/garden_helper/blob/master/CODE_OF_CONDUCT.md).
