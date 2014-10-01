### This is the data
place = Spree::Taxonomy.find_by_name!("Place")
things = Spree::Taxonomy.find_by_name!("Things to do")

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

  { :name => "Things to do", :taxonomy => things, :position => 1 },
    { :name => "Hotels", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'hotel' },
    { :name => "Eat Out", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'restaurant' },
    { :name => "Drinks", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'bar' },
    { :name => "Nightlife", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'disco' },
    { :name => "Shopping", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'shopping' },
    { :name => "Beaches", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'beach' },
    { :name => "Transportation", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'bus' },
    { :name => "Interesting Places", :taxonomy => things, :position => 1, :parent => 'Things to do', :icon => 'point' },

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
