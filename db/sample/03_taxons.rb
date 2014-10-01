### This is the data
place = Spree::Taxonomy.find_by_name!("Place")
category = Spree::Taxonomy.find_by_name!("Category")

taxons = [
  { :name => "Place", :taxonomy => place, :position => 1 },
    { :name => "Pinar del Rio", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Artemisa", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "La Habana", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Mayabeque", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Isla de la Juventud", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Matanzas", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Villa Clara", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Cienfuegos", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Sancti Spiritus", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Ciego de Avila", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Jardines del Rey", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Camaguey", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Las Tunas", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Holguin", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Granma", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Santiago de Cuba", :taxonomy => place, :position => 1, :parent => 'Place' },
    { :name => "Guantanamo", :taxonomy => place, :position => 1, :parent => 'Place' },

  { :name => "Category", :taxonomy => category, :position => 1 },
    { :name => "Hotels", :taxonomy => category, :position => 1, :parent => 'Category'},
    { :name => "Flights", :taxonomy => category, :position => 1, :parent => 'Category'},
    { :name => "Car Rental", :taxonomy => category, :position => 1, :parent => 'Category'},
    { :name => "Transfers", :taxonomy => category, :position => 1, :parent => 'Category'},
    { :name => "Tours", :taxonomy => category, :position => 1, :parent => 'Category'},
    { :name => "Package", :taxonomy => category, :position => 1, :parent => 'Category'},
    { :name => "Interesting Places", :taxonomy => category, :position => 1, :parent => 'Category'},

]

### Creating Taxons
position = 0
$taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    name = taxon_attrs[:name]
    parent_taxon = Spree::Taxon.find_by_name!(taxon_attrs[:parent])
    taxon_attrs[:parent] = parent_taxon
    taxon_attrs[:position] = (position += 1)
    tx = Spree::Taxon.create!(taxon_attrs)
  end
end
