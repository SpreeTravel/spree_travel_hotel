module Spree
  class CalculatorHotel < BaseCalculator

    def adults_range
      (1..3).to_a
    end

    def children_range
      (0..2).to_a
    end

    def calculate_price_old(context, product)
      return [product.price.to_f] if product.rates.empty?
      prices = []
      days = context.end_date.to_date - context.start_date.to_date rescue 1

      product.rates.each do |r|
        next if context.start_date.present? && (context.start_date.to_date < r.start_date.to_date rescue false)
        next if context.end_date.present? && (context.end_date.to_date > r.end_date.to_date rescue false)
        next if context.plan.present? && context.plan.to_i != r.plan.to_i
        next if context.room.present? && context.room.to_i != r.variant_id
        adults_array = get_adult_list(r, context.adult)
        children_array = get_child_list(r, context.child)
        combinations = adults_array.product(children_array)
        combinations.each do |ad, ch|
          prices << get_rate_price(r, ad, ch) * days
        end
      end
      prices
    end

    def calculate_price(context, product)
      return [product.price.to_f] if product.combinations.empty?
      prices = []
      days = context.end_date.to_date - context.start_date.to_date rescue 1
      other = combination_string_for_search(context)

      list = product.combinations
      list = list.where('start_date <= ?', context.start_date) if context.start_date.present?
      list = list.where('end_date >= ?', context.end_date) if context.end_date.present?
      list = list.where(:adults => context.adult) if context.adult.present?
      list = list.where(:children => context.child) if context.child.present?
      list = list.where('other like ?', other) unless other.nil?
      Log.debug(list.explain)
      prices = list.map {|c| (c.price * days).to_i }
      prices
    end

    # TODO: el problma esta en que la variante es distinta para cada producto
    # y en el combo en el buscador salen los ID de los option types
    # y nunca matchea eso
    def combination_string_for_generation(rate)
      plan = rate.plan
      raise Exception.new("SOMETHING WRONG") if rate.variant.option_values.count != 1
      room = rate.variant.option_values.first.id
      "ROOM:#{room},PLAN:#{plan}"
    end

    def combination_string_for_search(context)
      plan = context.plan || context[:plan]
      room = context.room || context[:room]
      if plan.present? && room.present?
        "ROOM:#{room},PLAN:#{plan}"
      elsif plan.present?
        "%PLAN:#{plan}"
      elsif room.present?
        "ROOM:#{room}%"
      else
        nil
      end
    end

    def get_rate_price(rate, adults, children)
      adults = adults.to_i
      children = children.to_i
      adults_hash = {1 => 'simple', 2 => 'double', 3 => 'triple'}
      price = adults * rate.send(adults_hash[adults]).to_f
      price += rate.first_child.to_f if children >= 1
      price += rate.second_child.to_f if children == 2
      price
    end
  end
end
