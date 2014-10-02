### Some Global Variables
place_taxonomy = Spree::Taxonomy.find_by_name('Place')
place_taxons = Spree::Taxon.where(:taxonomy_id => place_taxonomy.id).to_a
place_taxons.shift
category_taxonomy = Spree::Taxonomy.find_by_name('Category')
category_taxons = Spree::Taxon.where(:taxonomy_id => category_taxonomy.id).to_a
category_taxons.shift
shipping_category = Spree::ShippingCategory.first
properties = Spree::Property.all.to_a
amount_of_fake_products = 20
available_on = Time.now - 1.day

### Deleting Stuff
Spree::Product.delete_all
Spree::Variant.delete_all
Spree::Price.delete_all

### Creating Products
amount_of_fake_products.times do
  the_properties = (1..rand(properties.length)).map { properties.sample }.uniq
  the_taxons = [place_taxons.sample, category_taxons.sample]
  the_name = Faker::Company.name
  the_price = (rand(100) + 20).to_i / 5 * 5
  the_description = Faker::Lorem.paragraphs(rand(5) + 1).join("<br>")
  the_sku = Faker.bothify('???-######').upcase
  product = Spree::Product.create!(
    :name => the_name,
    :price => the_price,
    :description => the_description,
    :sku => the_sku,
    :shipping_category_id => shipping_category.id,
    :available_on => available_on,
  )
  the_properties.each do |property|
    Spree::ProductProperty.create(
      :product_id => product.id,
      :property_id => property.id,
      :value => 'yes'
    )
  end
  product.taxons = the_taxons

end

