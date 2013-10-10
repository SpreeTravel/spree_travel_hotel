require 'spec_helper'

describe "spree/rate_hotels/show" do
  before(:each) do
    @spree_rate_hotel = assign(:spree_rate_hotel, stub_model(Spree::RateHotel,
      :product_id => 1,
      :room_id => 2,
      :plan_id => 3,
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
    rendered.should match(/3/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Exceptions/)
  end
end
