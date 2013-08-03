Spree::Travel::Accommodation
----------------------------
* Hotel + Habitacion
* relaciones
  - R1 = i_am_a_room_for_this_product
* metodos_similares
  - hotel.children_rooms --> those_products_are_related_to_me(R1)
  - hotel.children --> children_rooms
  - hotel.main_room --> this_product_is_related_to_me(R2, :main => true)
  - room.parent_hotel --> i_am_related_to_this_product(R1)
  - room.parent --> paremt_hotel
* metodos de variante
  - adultos
  - children
  - bebes
  - check in
  - check out
  - meal plan
