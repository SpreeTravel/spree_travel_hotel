require 'spec_helper'

describe "spree/hotel_combinations/show" do
  before(:each) do
    @spree_hotel_combination = assign(:spree_hotel_combination, stub_model(Spree::HotelCombination,
      :room_id => 1,
      :plan_id => 2,
      :adults => 3,
      :children => 4,
      :price => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/1.5/)
  end
end
