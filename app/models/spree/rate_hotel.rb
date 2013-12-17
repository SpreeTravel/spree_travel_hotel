module Spree
  class RateHotel < ActiveRecord::Base
    belongs_to :product, :class_name => 'Spree::Product', :foreign_key => :product_id
    validate :validate_overlapping
    
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
      # TODO: formato de precios: +10% - 2, para todos los campos usando como base 2 adultos, este ultimo es float
      numbers = {1 => 'one', 2 => 'two', 3 => 'three'}
      method_adult = "adults_#{numbers[adult]}"
      price_adult = self.respond_to?(method_adult) ? self.send(method_adult) : (self.adults_extra || 0)
      method_children = "children_#{numbers[child]}"
      price_child = self.respond_to?(method_children) ? self.send(method_children) : (self.children_extra || 0)
      price = self.eval_price(self.adults_two, price_adult) * adult
      price += self.eval_price(self.adults_two, price_child) * child
      price
    end

    def eval_price(base_price, price)
      #re = '/((-|+)?\d%)?((-|+)?\d)?/'
      price
    end

    def get_option_values(adult, child)
      option_values = []
      option_values << OptionValue.find(self.room_id)
      option_values << OptionValue.find(self.plan_id)
      option_values << OptionValue.find_by_name("adult-#{adult}")
      option_values << OptionValue.find_by_name("child-#{child}")
      option_values << OptionValue.find(:name => self.init_date.to_s).first_or_create(
          :presentation => self.init_date.to_s,
          :option_type_id => Spree::OptionType.find_by_name('start-season').id
      )
      option_values << OptionValue.find(:name => self.end_date.to_s).first_or_create(
          :presentation => self.end_date.to_s,
          :option_type_id => Spree::OptionType.find_by_name('end-season').id
      )
      option_values
    end

    def create_or_update_variant(product, price, option_values)
      sku = ([product.permalink] + option_values.map(&:name)).join('-')
      # TODO: convertir sku en una secuencia
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

    def validate_overlapping
      # TODO: restringir que no se puedan crear dos rates con el mismo room, plan, begin and end
      exist = Spree::RateHotel.where(:room_id => self.room_id, :plan_id => self.plan_id).first
      if !exist.nil?
        errors.add(:base, 'Rate Hotel Overlapping')
      end
    end

  end
end
