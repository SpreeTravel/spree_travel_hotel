require 'spec_helper'

describe Spree::BaseHelper do
  it 'haves a definition for stars' do
    expect(hotel_stars()).to be_equal(5)
  end
end