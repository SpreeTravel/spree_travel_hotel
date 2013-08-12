CONFIG = :snc
###########################################################################
case CONFIG
when :pqr
  GEMS_PATH = 'http://localhost/rubygems/'
  SPREE_TRAVEL_PATH = 'file:///home/pqr/work/jaf/openjaf'
when :snc
  GEMS_PATH = 'file:///home/test/.rvm/gems/ruby-1.9.3-p392/bundler/gems/'
  SPREE_TRAVEL_PATH = 'file:///media/Data/jaf/spree_travel'
when :raul
  GEMS_PATH = 'http://localhost/rubygems/'
  SPREE_TRAVEL_PATH = 'file:///home/raul/RubymineProjects/openjaf'    
else
  GEMS_PATH = 'http://rubygems.org'
  SPREE_TRAVEL_PATH = 'file:///media/Data/jaf/spree'
end
########################################################################

source GEMS_PATH

gem 'spree_travel', :git => "#{SPREE_TRAVEL_PATH}/spree_travel"

gemspec
