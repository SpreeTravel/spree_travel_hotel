module Spree
  class ExceptionHotel < ActiveRecord::Base
    belongs_to :product, :class_name => 'Spree::Product', :foreign_key => :product_id

    def get_option_values
      option_values = []
      option_values << OptionValue.find_or_create(self.start_date.to_s, self.start_date.to_s, 'start_date') if self.start_date
      option_values << OptionValue.find_or_create(self.end_date.to_s, self.end_date.to_s, 'end_date') if self.end_date
      option_values << OptionValue.find(self.room_id) if self.room_id
      option_values << OptionValue.find(self.plan_id) if self.plan_id
      option_values << OptionValue.find_or_create("adult-#{self.adults}", self.adults.to_s, 'adult') if self.adults
      option_values << OptionValue.find_or_create("child-#{self.children}", self.children.to_s, 'child') if self.children
      option_values
    end

  end
end
