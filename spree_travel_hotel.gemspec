# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_travel_hotel'
  s.version     = '2.0.3'
  s.summary     = 'Hotel into spree'
  s.description = 'Add hotel logic into spree'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Pedro Quintero'
  s.email     = 'pqr@openjaf.com'
  s.homepage  = 'http://github.com/openjaf/spree_travel_hotel'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

<<<<<<< HEAD:spree_travel_hotel.gemspec
  s.add_dependency 'spree_core', '~> 2.1.1'
=======
  s.add_dependency 'spree_core', '~> 2.0.3'
  s.add_dependency 'spree_travel_core'
  s.add_dependency 'spree_travel_accommodation'
>>>>>>> origin/master:spree_travel_hotel.gemspec

  s.add_development_dependency 'capybara', '~> 2.0'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.11'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
