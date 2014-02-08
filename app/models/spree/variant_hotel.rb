module Spree
  class VariantHotel < VariantAccommodation

    def self.get_options_to_search
      # TODO: poner un metodo similar en Variant y llamar al super primero
      # TODO: la fecha tiene que ser mayor que la fecha de inicio y menor que
      # la fecha fin
      [
        {:option => 'room', :operator => '='},
        {:option => 'plan', :operator => '='},
        {:option => 'adult', :operator => '='},
        {:option => 'child', :operator => '='},
        {:option => 'start_date', :operator => '<='},
        {:option => 'end_date', :operator => '>='},
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
