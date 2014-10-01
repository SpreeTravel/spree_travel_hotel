### This is the data
properties = {
  :services => {
    'breakfast' => 'Breakfast',
    'lunch' => 'Lunch & Dinner',
    'taxi' => 'Taxi',
    'laundry' => 'Laundry',
    'massage' => 'Massages',
    'internet' => 'Internet Access',
    'wifi' => 'Wifi',
    'phone' => 'Phone Available'
  },
  :include => {
    'multilingual' => 'Multilingual Staff',
    'satellite' => 'Satellite TV',
    'dvd' => 'DVD Player',
    'air' => 'Air Conditioner',
    'parking' => 'Parking',
    'crib' => 'Crib',
    'minibar' => 'Fridge',
    'hair' => 'Hair Dryer',
    'towel' => 'Pool Towels',
    'safe' => 'Safe',
    'sauna' => 'Sauna',
    '24h' => '24 Hours Service',
    'room_service' => 'Room Service',
    'pool' => 'Pool',
    'elevator' => 'Elevator',
    'handicap' => 'Room for Handicapped',
    'terrace' => 'Terrace',
    'sea_view' => 'Sea View',
    'children' => 'Children are welcome',
    'cooking' => 'Cooking Facility',
    'tv' => 'TV (national channels)',
    'pets' => 'Family has Pets',
    'jacuzzi' => 'Jacuzzi',
    'coffee' => 'Coffee Maker',
  },
  :features => {
    'tours' => 'Guided Tours in the City',
    'hammock' => 'Hammock',
    'rooms' => 'Rooms',
    'room_type' => 'Room Type',
    'privacy' => 'Privacy',
  }
}

### Deleting Properties
Spree::Property.delete_all
Spree::ProductProperty.delete_all

def create_properties
  print_create_header "Properties"
  $properties.keys.each do |type|
    pt = Spree::PropertyType.find_by_name(type)
    hash = $properties[type]
    hash.each do |key, value|
      print_item 'p', :green
      attrs = {
        :name => key,
        :presentation => value,
      }
      if [:include,:services].include?(type)
        relative_path = "/../../vendor/assets/images/icons/"
        file_name = key + ".png"
        attrs[:icon] = File.new(File.dirname(__FILE__) + relative_path + file_name, "r")
        print_item "i", :blue
      end
      attrs[:property_type_id] = pt.id if pt
      pro = Spree::Property.create(attrs)
    end
  end
  print_done
end

###############################################################################
# Primero Borramos los properties
###############################################################################
if $delete_properties
  delete_properties
end

if $delete_product_properties
  delete_product_properties
end

###############################################################################
# El pedazo de codigo para cargar las properties
###############################################################################
if $create_properties
  create_properties
end
