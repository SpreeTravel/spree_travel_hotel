require 'spec_helper'

describe Spree::BaseHelper do
  it 'haves a definition for stars' do
    expect(Spree::BaseHelper.hotel_stars(build(:base_product))).to eq(5)
  end
end