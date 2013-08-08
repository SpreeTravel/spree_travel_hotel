CONFIG = :pqr
###########################################################################
case CONFIG
when :pqr
  GEMS_PATH = 'http://localhost/rubygems/'
  SPREE_TRAVEL_PATH = 'file:///home/pqr/work/jaf/openjaf'
else
  GEMS_PATH = 'http://rubygems.org'
  SPREE_TRAVEL_PATH = 'https://github.com/openjaf'
end
########################################################################

source GEMS_PATH

gem 'spree_travel', :git => "#{SPREE_TRAVEL_PATH}/spree_travel"

gemspec
