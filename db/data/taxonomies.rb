taxonomies = [
  { :name => "Categories" },
  { :name => "Destinations" }
]

taxonomies.each do |taxonomy_attrs|
  Spree::Taxonomy.create!(taxonomy_attrs)
end
