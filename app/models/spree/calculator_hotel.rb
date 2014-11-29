module Spree
  class CalculatorHotel

    MAX_ADULTS = 3
    MAX_CHILDREN = 2

    def self.calculate_price(context, product)
      return [product.price.to_f] if product.rates.empty?
      prices = []
      days = context.end_date.to_date - context.start_date.to_date rescue 1

      product.rates.each do |r|
        next if context.start_date.present? && (context.start_date.to_date < r.start_date.to_date rescue false)
        next if context.end_date.present? && (context.end_date.to_date > r.end_date.to_date rescue false)
        next if context.plan.present? && context.plan.to_i != r.plan.to_i
        next if context.room.present? && context.room.to_i != r.variant_id
        adults_array = self.get_adult_list(r, context.adult)
        children_array = self.get_child_list(r, context.child)
        combinations = adults_array.product(children_array)
        combinations.each do |ad, ch|
          prices << self.get_rate_price(r, ad, ch) * days
        end
      end
      prices
    end

    def self.generate_combination(product, rate)
      old_combinations  = product.combinations.pluck(:id)
      keep_combinations = []
      new_combinations  = []
      for adults in 1..MAX_ADULTS
        for children in 1..MAX_CHILDREN
          room = rate.variant_id
          plan = rate.plan
          price = get_rate_price(rate, adults, children)
          combination = Spree::Combinations.where(:product_id => product.id)
          combination = combination.where(:start_date => rate.start_date.to_date)
          combination = combination.where(:end_date => rate.end_date.to_date)
          combination = combination.where(:adults => adults)
          combination = combination.where(:children => children)
          combination = combination.where(:other => combination_string(room, plan))
          the_combination = combination.first
          if the_combination
            keep_combinations << the_combination.id
          else
            the_combination = combination.first_or_create!(:price => price)
            new_combinations << the_combination.id
          end
        end
      end
      deleted_combinations = old_combinations - keep_combinations
      Spree::Combinations.where(:id => deleted_combinations).delete_all

      {
        :original => old_combinations,
        :created => new_combinations,
        :deleted => deleted_combinations,
        :kept => keep_combinations,
      }
    end

    def self.generate_combinations(product)
      product.rates.each do |r|
        result = self.generate_combination(product, rate)
      end
    end

    private

    def self.combination_string(room, plan)
      "ROOM:#{room},PLAN:#{plan}"
    end

    def self.get_adult_list(rate, pt_adults)
      if pt_adults.present?
        [pt_adults]
      else
        (1..MAX_ADULTS).to_a
      end
    end

    def self.get_child_list(rate, pt_child)
      if pt_child.present?
        [pt_child]
      else
        (1..MAX_CHILDREN).to_a
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
