module Spree
  class VariantHotel < VariantAccommodation

    def self.get_options_to_search
      super + [
        {:option => 'room', :operator => '='},
        {:option => 'plan', :operator => '='},
      ]
    end

    def room
      self.get_option_value_from_name('room')
    end

    def plan
      self.get_option_value_from_name('plan')
    end

  end
end
