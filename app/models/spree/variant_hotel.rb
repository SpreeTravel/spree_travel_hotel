module Spree
  class VariantHotel < VariantAccommodation

    def self.get_options_to_search
      # TODO: poner un metodo similar en Variant y llamar al super primero
      [
        {:option => 'room', :operator => '='},
        {:option => 'plan', :operator => '='},
        {:option => 'adult', :operator => '='},
        {:option => 'child', :operator => '='},
        {:option => 'start_end', :operator => '>='},
        {:option => 'end_date', :operator => '<='},
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
