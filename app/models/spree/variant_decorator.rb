Spree::Variant.class_eval do

  searchable :auto_index => true, :auto_remove => true do
    string :room do
      self.get_option_value_from_name('room')
    end
    string :plan do
      self.get_option_value_from_name('plan')
    end
    integer :adults do
      self.get_option_value_from_name('adult').to_i
    end
    integer :children do
      self.get_option_value_from_name('child').to_i
    end
    date :start_date do
      self.get_option_value_from_type('start_season').to_d
    end
    date :end_date do
      self.get_option_value_from_type('end_season').to_d
    end
    float :price
  end

  def get_option_value_from_name(option)
    option_values.map(&:name).select{|ov| ov.starts_with?(option)}.first
  end

  def get_option_value_from_type(type)
    option_values.select{|ov| ov.option_type.name == type}.first.name
  end

end
