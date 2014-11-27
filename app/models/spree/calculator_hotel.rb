module Spree
  class CalculatorHotel

    def self.calculate_price(context, product)
      return [product.price.to_f] if product.rates.empty?
      prices = []
      days = context.end_date.to_date - context.start_date.to_date rescue 1

      product.rates.each do |r|
        next if context.start_date.present? && (context.start_date.to_date < r.start_date.to_date rescue false)
        next if context.end_date.present? && (context.end_date.to_date > r.end_date.to_date rescue false)
        next if context.plan.present? && context.plan.to_i != r.plan.to_i
        adults_array = self.get_adult_list(r, context.adult)
        children_array = self.get_child_list(r, context.child)
        combinations = adults_array.product(children_array)
        combinations.each do |ad, ch|
          prices << self.get_rate_price(r, ad, ch) * days
        end
      end
      prices
    end

    private

    def self.get_adult_list(rate, pt_adults)
      if pt_adults.present?
        [pt_adults]
      else
        [1, 2, 3]
      end
    end

    def self.get_child_list(rate, pt_child)
      if pt_child.present?
        [pt_child]
      else
        [1, 2]
      end
    end

    def self.get_rate_price(rate, adults, children)
      adults = adults.to_i
      children = children.to_i
      adults_hash = {1 => 'simple', 2 => 'double', 3 =>'triple'}
      price = adults * rate.send(adults_hash[adults]).to_f
      price += rate.first_child.to_f if children >= 1
      price += rate.second_child.to_f if children == 2
      price
    end

  end
end
