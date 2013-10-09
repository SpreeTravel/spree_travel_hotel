require 'spec_helper'

describe "spree/hotel_combinations/edit" do
  before(:each) do
    @spree_hotel_combination = assign(:spree_hotel_combination, stub_model(Spree::HotelCombination,
      :room_id => 1,
      :plan_id => 1,
      :adults => 1,
      :children => 1,
      :price => 1.5
    ))
  end

  it "renders the edit spree_hotel_combination form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spree_hotel_combination_path(@spree_hotel_combination), "post" do
      assert_select "input#spree_hotel_combination_room_id[name=?]", "spree_hotel_combination[room_id]"
      assert_select "input#spree_hotel_combination_plan_id[name=?]", "spree_hotel_combination[plan_id]"
      assert_select "input#spree_hotel_combination_adults[name=?]", "spree_hotel_combination[adults]"
      assert_select "input#spree_hotel_combination_children[name=?]", "spree_hotel_combination[children]"
      assert_select "input#spree_hotel_combination_price[name=?]", "spree_hotel_combination[price]"
    end
  end
end
