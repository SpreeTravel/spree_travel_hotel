$taxonomies = [
  { :name => "Place", :position => 1 },
  { :name => "Category", :position => 2 },
]

Spree::Taxonomy.destroy_all
Spree::Taxon.destroy_all

$taxonomies.each do |taxonomy_attrs|
  tx = Spree::Taxonomy.create!(taxonomy_attrs)
end
