room = Spree::OptionType.find_by_name!("room")
plan = Spree::OptionType.find_by_name!("plan")
adult = Spree::OptionType.find_by_name!("adult")
child = Spree::OptionType.find_by_name!("child")

Spree::OptionValue.create!([
  {    
    :name => "room-standard",
    :presentation => "Standard",
    :option_type => room
  },
  {
    :name => "room-suite",
    :presentation => "Suite",
    :option_type => room
  },
  {
    :name => "room-junior-suite",
    :presentation => "Junior Suite",
    :option_type => room
  },
  {
    :name => "room-master-suite",
    :presentation => "Master Suite",
    :option_type => room
  },
  {
    :name => "plan-continental-breakfast",
    :presentation => "CP",
    :option_type => plan
  },
  {
    :name => "plan-modified-american-plan",
    :presentation => "MAP",
    :option_type => plan
  },
  {
    :name => "plan-american-plan",
    :presentation => "AP",
    :option_type => plan
  },
  {
    :name => "plan-all-inclusive",
    :presentation => "AI",
    :option_type => plan
  },
  {
    :name => "adult-1",
    :presentation => "1",
    :option_type => adult
  },
  {
    :name => "adult-2",
    :presentation => "2",
    :option_type => adult
  },
  {
    :name => "adult-3",
    :presentation => "3",
    :option_type => adult
  },
  {
    :name => "adult-4",
    :presentation => "4",
    :option_type => adult
  },
  {
    :name => "child-0",
    :presentation => "0",
    :option_type => child
  },
  {
    :name => "child-1",
    :presentation => "1",
    :option_type => child
  },
  {
    :name => "child-2",
    :presentation => "2",
    :option_type => child
  },
  {
    :name => "child-3",
    :presentation => "3",
    :option_type => child
  }
])


