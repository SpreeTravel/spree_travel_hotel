module Spree
  module ProductHelper

      def stars(product)
        product.product_properties.where(:property_id => Spree::Property.find_by_name('stars')).first.value
      end

  end
end
