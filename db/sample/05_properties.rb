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


### Creating Properties
properties.keys.each do |type|
  pt = Spree::PropertyType.find_by_name(type)
  hash = properties[type]
  hash.each do |key, value|
    attrs = { :name => key, :presentation => value }
    prop = Spree::Property.create(attrs)
  end
end

