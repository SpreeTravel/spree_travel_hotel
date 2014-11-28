### This is the data
option_types = [
  {:name => "start_date", :presentation => "Start Date", :attr_type => 'date'},
  {:name => "end_date", :presentation => "End Date", :attr_type => 'date'},
  {:name => "room", :presentation => "Room", :attr_type => 'selection'},
  {:name => "plan", :presentation => "Plan", :attr_type => 'selection'},
  {:name => "adult", :presentation => "Adult", :attr_type => 'integer'},
  {:name => "child", :presentation => "Child", :attr_type => 'integer'},
  {:name => "simple", :presentation => "Simple", :attr_type => 'float'},
  {:name => "double", :presentation => "Double", :attr_type => 'float'},
  {:name => "triple", :presentation => "Triple", :attr_type => 'float'},
  {:name => "first_child", :presentation => "first_child", :attr_type => 'float'},
  {:name => "second_child", :presentation => "second_child", :attr_type => 'float'},
  {:name => "destination", :presentation => "Destination", :attr_type => 'destination'},
]

### Creating Option Types
option_types.each do |ot|
  Spree::OptionType.where(:name => ot[:name]).first_or_create(:presentation => ot[:presentation], :attr_type => ot[:attr_type])
end
