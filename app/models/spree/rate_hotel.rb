module Spree
  class RateHotel < ActiveRecord::Base
    belongs_to :product, :class_name => 'Spree::Product', :foreign_key => :product_id

    # TODO: restringir que no se puedan crear dos rates con el mismo room, plan, begin and end
    
    def generate_variants
      # TODO: falta evaluar excepciones
      max_adults = self.max_adults || 0
      max_children = self.max_children || 0
      (1..max_adults).each do |adult|
	      (0..max_children).each do |child|
          price = self.get_price(adult, child)
          option_values = self.get_option_values(adult, child)
          self.create_or_update_variant(self.product, price, option_values)
	      end
	    end
    end

    def get_price(adult, child)
      # TODO: es probable que el valor que exista en los campos de ninnos no sea precisamente
      # un valor a sumar, si no mas bien un porciento en funcion del precio de dos adultos.
      # Revisar este caso, porque pudiera variar el calculo de precio de las variantes e incluso
      # la definicion del campo.
      numbers = {1 => 'one', 2 => 'two', 3 => 'three'}
      method_adult = "adults_#{numbers[adult]}"
      price_adult = self.respond_to?(method_adult) ? self.send(method_adult) : (self.adults_extra || 0)
      method_children = "children_#{numbers[child]}"
      price_child = self.respond_to?(method_children) ? self.send(method_children) : (self.children_extra || 0)
      price = price_adult * adult + price_child * child
      price
    end

    def get_option_values(adult, child)
      option_values = []
      option_values << OptionValue.find(self.room_id)
      option_values << OptionValue.find(self.plan_id)
      option_values << OptionValue.find_by_name("adult-#{adult}")
      option_values << OptionValue.find_by_name("child-#{child}")

      method = 'find_or_create_by_name_and_presentation_and_option_type_id'
      option_values << OptionValue.send(method, self.init_date.to_s, self.init_date.to_s, Spree::OptionType.find_by_name('start-season').id)
      option_values << OptionValue.send(method, self.end_date.to_s, self.end_date.to_s, Spree::OptionType.find_by_name('end-season').id)
      option_values
    end

    def create_or_update_variant(product, price, option_values)
      sku = ([product.permalink] + option_values.map(&:name)).join('-')
      variant = Spree::Variant.where(:product_id => product_id, :sku => sku).first
      if variant.nil?
        variant = Spree::Variant.create(
            :product_id => product_id,
            :sku => sku,
            :price => price
        )
        variant.option_values = option_values
        variant.save
      else
        variant.price = price
        variant.save
      end
    end

  end
end
