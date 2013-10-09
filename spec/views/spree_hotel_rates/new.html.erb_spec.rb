require 'spec_helper'

describe "spree_hotel_rates/new" do
  before(:each) do
    assign(:spree_hotel_rate, stub_model(SpreeHotelRate,
      :room_id => 1,
      :plan_id => 1,
      :adults_one => 1.5,
      :adults_two => 1.5,
      :adultd_three => 1.5,
      :children_one => 1.5,
      :children_two => 1.5,
      :adults_extra => 1.5,
      :exceptions => "MyString"
    ).as_new_record)
  end

  it "renders new spree_hotel_rate form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spree_hotel_rates_path, "post" do
      assert_select "input#spree_hotel_rate_room_id[name=?]", "spree_hotel_rate[room_id]"
      assert_select "input#spree_hotel_rate_plan_id[name=?]", "spree_hotel_rate[plan_id]"
      assert_select "input#spree_hotel_rate_adults_one[name=?]", "spree_hotel_rate[adults_one]"
      assert_select "input#spree_hotel_rate_adults_two[name=?]", "spree_hotel_rate[adults_two]"
      assert_select "input#spree_hotel_rate_adultd_three[name=?]", "spree_hotel_rate[adultd_three]"
      assert_select "input#spree_hotel_rate_children_one[name=?]", "spree_hotel_rate[children_one]"
      assert_select "input#spree_hotel_rate_children_two[name=?]", "spree_hotel_rate[children_two]"
      assert_select "input#spree_hotel_rate_adults_extra[name=?]", "spree_hotel_rate[adults_extra]"
      assert_select "input#spree_hotel_rate_exceptions[name=?]", "spree_hotel_rate[exceptions]"
    end
  end
end
