require 'spec_helper'

describe "spree/rate_hotels/edit" do
  before(:each) do
    @spree_rate_hotel = assign(:spree_rate_hotel, stub_model(Spree::RateHotel,
      :product_id => 1,
      :room_id => 1,
      :plan_id => 1,
      :adults_one => 1.5,
      :adults_two => 1.5,
      :adultd_three => 1.5,
      :children_one => 1.5,
      :children_two => 1.5,
      :adults_extra => 1.5,
      :exceptions => "MyString"
    ))
  end

  it "renders the edit spree_rate_hotel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spree_rate_hotel_path(@spree_rate_hotel), "post" do
      assert_select "input#spree_rate_hotel_product_id[name=?]", "spree_rate_hotel[product_id]"
      assert_select "input#spree_rate_hotel_room_id[name=?]", "spree_rate_hotel[room_id]"
      assert_select "input#spree_rate_hotel_plan_id[name=?]", "spree_rate_hotel[plan_id]"
      assert_select "input#spree_rate_hotel_adults_one[name=?]", "spree_rate_hotel[adults_one]"
      assert_select "input#spree_rate_hotel_adults_two[name=?]", "spree_rate_hotel[adults_two]"
      assert_select "input#spree_rate_hotel_adultd_three[name=?]", "spree_rate_hotel[adultd_three]"
      assert_select "input#spree_rate_hotel_children_one[name=?]", "spree_rate_hotel[children_one]"
      assert_select "input#spree_rate_hotel_children_two[name=?]", "spree_rate_hotel[children_two]"
      assert_select "input#spree_rate_hotel_adults_extra[name=?]", "spree_rate_hotel[adults_extra]"
      assert_select "input#spree_rate_hotel_exceptions[name=?]", "spree_rate_hotel[exceptions]"
    end
  end
end
