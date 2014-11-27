FactoryGirl.define do
  factory :rate_hotel, class: Spree::Rate do
    ignore do
      start_date Date.today - (365 / 2)
      end_date Date.today + (365 / 2)
    end
    association :variant, factory: :variant_decorated
    after(:create) { |rate, evaluator|
      rate.set_option_value(:start_date, evaluator.start_date)
      rate.set_option_value(:end_date, evaluator.end_date)
      rate.save
    }
  end
end