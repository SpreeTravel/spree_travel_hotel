require 'rake'
require 'spec_helper'

describe "Rake Tasks" do

  it "adds fields to the database" do
    Rake::Task['spree_travel_hotel:load'].invoke
    expect(Spree::ProductType.all.count).to be(1)
  end

end

