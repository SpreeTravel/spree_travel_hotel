module Spree
  module ProductHotelsHelper
      def stars(product)
        product.product_properties.where(:property_id => Spree::Property.find_by_name('stars')).first.value
      end
      
      def get_option_values(option_type)
        list = Spree::OptionValue.joins(:option_type)
        list = list.where('spree_option_types.name = ?', option_type)        
      end

  end
end
