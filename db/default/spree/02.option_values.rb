### These are the option types
room = Spree::OptionType.find_by_name!("room")
plan = Spree::OptionType.find_by_name!("plan")

### This is the data
option_values = [
  {:name => "room-standard", :presentation => "Standard", :option_type => room},
  {:name => "room-suite", :presentation => "Suite", :option_type => room},
  {:name => "room-junior-suite", :presentation => "Junior Suite", :option_type => room},
  {:name => "room-master-suite", :presentation => "Master Suite", :option_type => room},
  {:name => "plan-continental-breakfast", :presentation => "CP", :option_type => plan},
  {:name => "plan-modified-american-plan", :presentation => "MAP", :option_type => plan},
  {:name => "plan-american-plan", :presentation => "AP", :option_type => plan},
  {:name => "plan-all-inclusive", :presentation => "AI", :option_type => plan}
]

### Creating Option Values
option_values.each do |ov|
  Spree::OptionValue.create!(ov)
end
