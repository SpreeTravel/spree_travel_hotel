require 'spec_helper'

describe "spree_hotel_rates/index" do
  before(:each) do
    assign(:spree_hotel_rates, [
      stub_model(SpreeHotelRate,
        :room_id => 1,
        :plan_id => 2,
        :adults_one => 1.5,
        :adults_two => 1.5,
        :adultd_three => 1.5,
        :children_one => 1.5,
        :children_two => 1.5,
        :adults_extra => 1.5,
        :exceptions => "Exceptions"
      ),
      stub_model(SpreeHotelRate,
        :room_id => 1,
        :plan_id => 2,
        :adults_one => 1.5,
        :adults_two => 1.5,
        :adultd_three => 1.5,
        :children_one => 1.5,
        :children_two => 1.5,
        :adults_extra => 1.5,
        :exceptions => "Exceptions"
      )
    ])
  end

  it "renders a list of spree_hotel_rates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Exceptions".to_s, :count => 2
  end
end
