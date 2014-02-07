module Spree
  class ContextHotel < ContextAccommodation

    def self.default_room_id
      OptionValue.where(:name => 'room-standard').first.id
    end

    def self.default_plan_id
      OptionValue.where(:name => 'plan-continental-breakfast').first.id
    end

    def self.default_start_date
      Time.now.to_date
    end

    def self.default_end_date
      self.default_start_date + 2
    end

    def self.default_adults
      2
    end

    def self.default_children
      0
    end

    ###########################################################################

    def room_id
      pod(@params[:room_id], ContextHotel.default_room_id)
    end

    def plan_id
      pod(@params[:plan_id], ContextHotel.default_plan_id)
    end

    def start_date
      pod(@params[:start_date], ContextHotel.default_start_date)
    end

    def end_date
      pod(@params[:end_date], ContextHotel.default_end_date)
    end

    def adults
      pod(@params[:adults], ContextHotel.default_adults)
    end

    def children
      pod(@param[:children], Context.default_children)
    end
  end
end
