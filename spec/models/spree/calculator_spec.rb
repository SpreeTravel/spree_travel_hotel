require 'spec_helper'

describe Spree::CalculatorHotel do

  before :each do
    DatabaseCleaner.strategy = RSpec.current_example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  it 'displays the right price' do
    prod = create(:travel_product, product_type: Spree::ProductType.first)

    prod.generate_variants
    variant = prod.variants.first

    rate = create(:rate_hotel, variant: variant)
    line_item = create(:line_item, quantity: 0, product: prod, variant: variant)
    context = create(:hotel_context, line_item: line_item, variant: variant)

    calculator_class = ("Spree::CalculatorHotel").constantize

    prices = calculator_class.calculate_price(context, variant).sort
    expect(prices.count).to eq(1)
  end

end