require 'spec_helper'

describe "spree/hotel_combinations/index" do
  before(:each) do
    assign(:spree_hotel_combinations, [
      stub_model(Spree::HotelCombination,
        :room_id => 1,
        :plan_id => 2,
        :adults => 3,
        :children => 4,
        :price => 1.5
      ),
      stub_model(Spree::HotelCombination,
        :room_id => 1,
        :plan_id => 2,
        :adults => 3,
        :children => 4,
        :price => 1.5
      )
    ])
  end

  it "renders a list of spree/hotel_combinations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
