require 'spec_helper'

describe 'helper' do
  it 'haves a definition for stars' do
    expect(hotel_stars(build(:base_product))).to be_equal(5)
  end
end