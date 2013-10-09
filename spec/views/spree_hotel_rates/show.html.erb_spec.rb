require 'spec_helper'

describe "spree_hotel_rates/show" do
  before(:each) do
    @spree_hotel_rate = assign(:spree_hotel_rate, stub_model(SpreeHotelRate,
      :room_id => 1,
      :plan_id => 2,
      :adults_one => 1.5,
      :adults_two => 1.5,
      :adultd_three => 1.5,
      :children_one => 1.5,
      :children_two => 1.5,
      :adults_extra => 1.5,
      :exceptions => "Exceptions"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Exceptions/)
  end
end
