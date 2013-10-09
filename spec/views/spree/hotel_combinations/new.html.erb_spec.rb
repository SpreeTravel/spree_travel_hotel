require 'spec_helper'

describe "spree/hotel_combinations/new" do
  before(:each) do
    assign(:spree_hotel_combination, stub_model(Spree::HotelCombination,
      :room_id => 1,
      :plan_id => 1,
      :adults => 1,
      :children => 1,
      :price => 1.5
    ).as_new_record)
  end

  it "renders new spree_hotel_combination form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spree_hotel_combinations_path, "post" do
      assert_select "input#spree_hotel_combination_room_id[name=?]", "spree_hotel_combination[room_id]"
      assert_select "input#spree_hotel_combination_plan_id[name=?]", "spree_hotel_combination[plan_id]"
      assert_select "input#spree_hotel_combination_adults[name=?]", "spree_hotel_combination[adults]"
      assert_select "input#spree_hotel_combination_children[name=?]", "spree_hotel_combination[children]"
      assert_select "input#spree_hotel_combination_price[name=?]", "spree_hotel_combination[price]"
    end
  end
end
