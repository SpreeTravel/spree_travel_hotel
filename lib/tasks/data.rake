require 'ffaker'
require 'pathname'

namespace :db do
  desc 'Loads hotels data'
  task :load_hotels_data => :environment do
    SpreeTravelHotel::Engine.load_hotels_data
  end
end
