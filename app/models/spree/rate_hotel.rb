module Spree
  class RateHotel < ActiveRecord::Base
    belongs_to :product, :class_name => 'Spree::Product', :foreign_key => :product_id
    #validate :validate_overlapping

    def generate_variants
      max_adults = self.max_adults || 0
      max_children = self.max_children || 0
      (1..max_adults).each do |adult|
        (0..max_children).each do |child|
          price = self.get_price(adult, child)
          option_values = self.get_option_values(adult, child)
          if !self.is_an_exception(option_values)
            self.create_or_update_variant(self.product, price, option_values)
          end
	end
      end
    end

    def get_price(adult, child)
      numbers = {1 => 'one', 2 => 'two', 3 => 'three'}
      method_adult = "adults_#{numbers[adult]}"
      price_adult = self.respond_to?(method_adult) ? (self.send(method_adult) || 0) : (self.adults_extra || 0)
      method_children = "children_#{numbers[child]}"
      price_child = self.respond_to?(method_children) ? (self.send(method_children) || 0) : (self.children_extra || 0)
      price = self.eval_price(self.adults_two, price_adult) * adult
      price += self.eval_price(self.adults_two, price_child) * child
      price
    end

    def eval_price(base_price, price)
      # INFO: formato de precios: +10% - 2, para todos los campos usando como base 2 adultos, este ultimo es float
      #re = '/((\-|\+)?\s*\d+\s*%)?\s*((\-|\+)?\s*\d+)?/'
      price
    end

    def get_option_values(adult, child)
      option_values = []
      option_values << OptionValue.find_or_create(self.start_date.to_s, self.start_date.to_s, 'start_date')
      option_values << OptionValue.find_or_create(self.end_date.to_s, self.end_date.to_s, 'end_date')
      option_values << OptionValue.find(self.room_id)
      option_values << OptionValue.find(self.plan_id)
      option_values << OptionValue.find_or_create("adult-#{adult}", adult.to_s, 'adult')
      option_values << OptionValue.find_or_create("child-#{child}", child.to_s, 'child')
      option_values
    end

    def is_an_exception(option_values)
      # TODO: hacer algo para que el get_option_values_in_exception
      # se llame una sola vez en un generate_variants
      self.product.get_option_values_in_exception.each do |ove|
        return true if (option_values & ove) == ove
      end
      return false
    end

    def create_or_update_variant(product, price, option_values)
      lsku = (option_values.map(&:name)).join('-')
      variant = Spree::VariantHotel.where(:product_id => product.id).select{|v| v.long_sku == lsku}.first
      if variant.nil?
        variant = Spree::VariantHotel.create(
             # TODO: generar una secuencia para el sku
            :product_id => product.id,
            :price => price,
            :option_values => option_values
        )
      else
        variant.price = price
        variant.save
      end
    end

    def validate_overlapping
      # TODO: agregar start_date y end_date
      exist = Spree::RateHotel.where("id != ? and room_id = ? and plan_id = ?", [self.id, self.room_id, self.plan_id]).first
      if !exist.nil?
        errors.add(:base, 'Rate Hotel Overlapping')
      end
    end

  end
end
