hotel = Spree::ProductType.find_by_name('hotel')

prototypes = [
    {:name => "Hotel", :option_types => ["room"], :product_type => hotel}
]

prototypes.each do |prototype_attrs|
  prototype = Spree::Prototype.create!(:name => prototype_attrs[:name])
  prototype_attrs[:option_types].each do |ot|
    prototype.option_types << Spree::OptionType.find_by_name!(ot)
  end
end
