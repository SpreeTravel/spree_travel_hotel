module Spree
  class ContextHotel < ContextAccommodation

    def self.default_plan_id
      raise "NOT IMPLEMENTED"
    end

    def self.default_init_date
      Time.now.to_date
    end

    def self.default_end_date
      self.default_init_date + 2
    end

    def self.default_adults
      2
    end

    def self.default_children
      0
    end

    ###########################################################################

    def plan_id
      pod(@params[:plan_id], ContextHotel.default_plan_id)
    end

    def init_date
      pod(@params[:init_date], ContextHotel.default_init_date)
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
