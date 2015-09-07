module Spree
  class CalculatorHotel < BaseCalculator

    def adults_range
      (1..3).to_a
    end

    def children_range
      (0..2).to_a
    end

    def calculate_price(context, variant, options)
      # TODO hacerlo generico para que se apte cuando hay cambios en los context por el usuario
      return [variant.price.to_f] if variant.rates.empty?
      # days = context.end_date(options).to_date - context.start_date(options).to_date rescue 1
      # rooms = context.rooms(options).to_i rescue 1
      adults_hash = {1 => 'simple', 2 => 'double', 3 => 'triple'}

      list = variant.rates
      array = []
      list.each do |r|
        if r.start_date <= context.start_date(options).to_s && r.end_date >= context.end_date(options).to_s
          price = context.adult.to_i * r.send(adults_hash[context.adult.to_i]).to_f
          price += r.first_child.to_f if context.child.to_i >= 1
          price += r.second_child.to_f if context.child.to_i == 2
          # price = price * days * rooms # TODO "x días por cuarto"
          array << {price: price, rate: r.id}
        end
      end
      array

      # # list = list.where('start_date <= ?', context.start_date(options)) if context.start_date(options).present?
      # # list = list.where('end_date >= ?', context.end_date(options)) if context.end_date(options).present?
      # list = list.where(:adults => context.adult(options)) if context.adult(options).present?
      # list = list.where(:children => context.child(options)) if context.child(options).present?
      # list = list.where(:room => context.room(options)) if context.room(options).present?
      # list = list.where(:plan => context.plan(options)) if context.plan(options).present?
      # list = list.order('price ASC')
      # Log.debug(list.explain)
      # list
    end

    # TODO: el problma esta en que la variante es distinta para cada producto
    # y en el combo en el buscador salen los ID de los option types
    # y nunca matchea eso
    # def combination_string_for_generation(rate)
    #   plan = rate.plan
    #   raise Exception.new("SOMETHING WRONG") if rate.variant.option_values.count != 1
    #   room = rate.variant.option_values.first.id
    #   "ROOM:#{room},PLAN:#{plan}"
    # end
    
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
