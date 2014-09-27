rates = ['start_date', 'end_date', 'plan', 'simple', 'double', 'triple', 'first_child', 'second_child']
rate_option_types = rates.each.map {|r| Spree::OptionType.find_by_name(r)}

contexts = ['start_date', 'end_date', 'adult', 'child', 'plan']
context_option_types = contexts.each.map {|c| Spree::OptionType.find_by_name(c)}

variants = ['room']
variant_option_types = variants.each.map {|v| Spree::OptionType.find_by_name(v)}

Spree::ProductType.create!(
   :name => 'hotel',
   :presentation => 'Hotel',
   :rate_option_types => rate_option_types,
   :context_option_types => context_option_types,
   :variat_option_types => variant_option_types
)
