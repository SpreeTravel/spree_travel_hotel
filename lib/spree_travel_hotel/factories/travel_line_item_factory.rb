FactoryGirl.define do
  factory :travel_line_item, class: Spree::LineItem do
    quantity 0
    price { BigDecimal.new('10.00') }
    order
    ignore do
      association :product
    end
    variant{ product.master }
  end
end
