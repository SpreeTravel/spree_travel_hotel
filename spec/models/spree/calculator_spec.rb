require 'spec_helper'

describe Spree::CalculatorHotel do

  before :each do
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  it 'displays the right price' do

  end

end