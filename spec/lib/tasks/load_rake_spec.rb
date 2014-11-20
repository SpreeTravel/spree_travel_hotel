require 'spec_helper'
require 'rake'

describe 'load' do
  before { Dummy::Application.load_tasks }

  it { expect { Rake::Task['spree_travel_hotel:load'].invoke }.not_to raise_exception }
end