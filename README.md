Spree Travel Hotel
=========
Spree Travel Hotel is intended to be a part of [Spree Travel](https://github.com/openjaf/spree_travel/), providing it with the functionalities to model the sales of hotel vacancies. This means that this spree extension will add new models, behaviors, views, etc… to spree travel, and will modify some of the definition it holds.

###Important Note
The Spree Travel project is a work in progress, and will suffer major changes. Please use it and keep a live feedback with the team by opening a [GitHub issue](https://github.com/openjaf/spree_travel_hotel/issues/new).

Requirements
------------
### Rails and Spree
Spree Travel Hotel now requires Rails version **>= 4.0** and a Spree version **>=2.3**.

### Spree Travel Core
Spree Travel Hotel now requires **Spree Travel Core** version **>= 2.3**.

Installation
------------

Spree Travel Hotel is not yet distributed as a gem, so it should be used in your app with a git reference or you can download the source and build the gem on your own.

1. Add the following to your Gemfile

  ```ruby
    gem 'spree_travel_hotel’, :git => 'https://github.com/openjaf/spree_travel_hotel.git', :branch => '2-3-stable'
  ```

2. Run `bundle install`

3. To copy and apply migrations run:

  ```
  rails g spree_travel_hotel:install
  ```

4. Run `rake db:hotel_seed`, to add the option_types needed to define the hotels

Features
------------

- Adds the hotel product type to spree_travel, adding the common functionalities for managing hotels reservations.
- Decorates hotel product type variants with option_types and values to define rates for the hotel prices.
- Adds a calculator_hotel class to update prices according to the product rate provided by spreee_travel_core.


Contributing
------------

If you'd like to contribute a feature or bugfix: Thanks! To make sure your
fix/feature has a high chance of being included, please read the following
guidelines:

1. Post a [pull request](https://github.com/openjaf/spree_travel_hotel/compare/).
2. Or open a [GitHub issue](https://github.com/openjaf/spree_travel_hotel/issues/new).

License
-------

Spree Travel Hotel is Copyright © 2014 openjaf. It is free software, and may be
redistributed under the terms specified in the MIT-LICENSE file.