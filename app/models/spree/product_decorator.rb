# Clase para probar un punto, no debe quedarse, si el cambio hace falta en el core dustet 30/12/2014
module Spree
  Product.class_eval do
    after_save :absorb_option_types_new

    def absorb_option_types_new
      self.option_types = self.product_type.variant_option_types
    rescue
    end

    def hotel?
      self.product_type == Spree::ProductType.find_by_name('hotel')
    end

  end
end
