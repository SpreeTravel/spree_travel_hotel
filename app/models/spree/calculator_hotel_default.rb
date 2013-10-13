module Spree
  class CalculatorHotelDefault < TravelCalculator

    # TODO: calcular bien cada dia en que temporada cae
    def self.calculate_price(options = {})
      product = options[:product]
      context = options[:context]
      combinations   = product.combinations
      combinations   = combinations.where(:room_id => context[:room_id]) if context[:room_id]
      combinations   = combinations.where(:plan_id => context[:plan_id]) if context[:plan_id]
      combinations   = combinations.where(:adults => context[:adults]) if context[:adults]
      combinations   = combinations.where(:children => context[:children]) if context[:children]
      if context[:init_date] && context[:end_date]
        combinations = combinations.where('init_date <= ?', context[:init_date]) if context[:init_date]
        combinations = combinations.where('end_date >= ?' context[:init_date]) if context[:init_date]
        duration     = context[:end_date] - context[:init_date] + 1
      else
        duration     = nil
      end
      prices = combinations.pluck(:price).sort
      prices = prices.map {|p| p * duration } if duration
      prices
    end
  end
end

#
#
#require 'spreadsheet'
#I18n.locale = :es
#
## Hotels
##hotels = ['accommodations_melia.xls', 'accommodations_habaguanex.xls', 'accommodations_iberostar.xls', 'accommodations_otros.xls']
##hotels = ['accommodations_melia_052013.xls', 'accommodations_iberostar_052013.xls']
#hotels = ['Plantilla_HABAGUANEX_24072013.xls']
#
## Hash for categories
#category = {
#    'ciudad' => 'city',
#    'playa' => 'beach',
#    'cayos' => 'beach',
#    'rural' => 'rural'
#}
#
## Hash for occupation
#occupation = {
#    'adult-1' => 13,
#    'adult-2' => 14,
#    'adult-3' => 15
#}
#
#exceptions = ['adult-3--child-2']
#
## Hash for meal_plan
#plan = {
#    'cp' => 'meal-plan-continental-breakfast',
#    'map' => 'meal-plan-modified-american-plan',
#    'ap' => 'meal-plan-american-plan',
#    'inc' => 'meal-plan-all-inclusive'
#}
#
## Method to get a product permalink
#def get_permalink(product_name)
#  bad_chars = {'Á' => 'a', 'É' => 'e', 'Í' => 'i', 'Ó' => 'o', 'Ú' => 'u', 'Ü' => 'u', 'Ñ' => 'n', 'á' => 'a', 'é' => 'e', 'í' => 'i', 'ó' => 'o', 'ú' => 'u', 'ü' => 'u', 'ñ' => 'n', ' ' => '-', ',' => '', ')' => '', '(' => '', "'" => ''}
#  name = product_name.gsub(/(.)/) {|s| bad_chars[s] ? bad_chars[s] : s}
#  return name.downcase
#end
#
## Method to set a property
#def set_property(product, property_name, property_data)
#  property = Spree::Property.find_by_name(property_name)
#  if  property
#    puts "    property feature: #{property.presentation} - #{property_data} "
#    product_property = Spree::ProductProperty.create(
#        :product_id => product.id,
#        :property_id => property.id,
#        :value => property_data
#    )
#    product_property.save
#  end
#end
#
#def get_value(number)
#  return number.value rescue number
#end
#
## Option Types
#season = Spree::OptionType.find_by_name('season')
#meal_plan = Spree::OptionType.find_by_name('meal-plan')
#adult = Spree::OptionType.find_by_name('adult')
#child = Spree::OptionType.find_by_name('child')
#option_types = [season, meal_plan, adult, child]
#
## Products
#
#hotels.each do |h|
#  # Reading excel
#  book = Spreadsheet.open "#{Rails.root}/db/load_accommodations/#{h}"
#  #book.worksheets
#  data = book.worksheet 0
#
#  i = 5
#  while(!data.row(i)[0].nil?)
#
#    if data.row(i)[1]
#      j = i + 1
#      puts "product: #{data.row(i)[1]}"
#      puts "    permalink: #{get_permalink(data.row(i)[1])}"
#
#      hotel_name = data.row(i)[1].to_s.start_with?("Hotel") ? data.row(i)[1].to_s : "Hotel #{data.row(i)[1].to_s}"
#      product = Spree::Product.where(:name => hotel_name).first
#      if product.nil?
#        puts "El hotel no existe:  ummmmmmmmmm"
#        product = Spree::Product.new()
#        product.name = hotel_name
#        product.available_on = Time.now
#        product.count_on_hand = 0
#        product.price = 0
#        product.small_description = data.row(j)[1].to_s
#        product.description = data.row(j)[1].to_s
#        product.permalink = get_permalink(data.row(i)[1])
#        product.latitude = data.row(i)[43] != 0 ? data.row(i)[43] : nil
#        product.longitude = data.row(i)[44] != 0 ? data.row(i)[44] : nil
#        product.save
#      end
#
#      # Product Taxons
#      taxon_category = Spree::Taxon.find_by_permalink("categories/accommodation/#{category[data.row(j)[7].to_s.downcase]}")
#      if taxon_category and (!product.taxons.nil? and !product.taxons.include?(taxon_category) or product.taxons.nil?)
#        puts "    taxon-category: #{taxon_category.name}"
#        product.taxons << taxon_category
#      end
#      taxonomy_id = Spree::Taxon.find_by_permalink("destinations").taxonomy_id
#      taxon_destination = Spree::Taxon.where(:name => data.row(i)[0], :taxonomy_id => taxonomy_id).first
#      if taxon_destination and (!product.taxons.nil? and !product.taxons.include?(taxon_destination) or product.taxons.nil?)
#        puts "    taxon-destination: #{taxon_destination.name}"
#        product.taxons << taxon_destination
#      end
#      product.save
#
#      # Properties Include
#      property_type_id = Spree::PropertyType.find_by_name("General Services").id
#      for m in 50..100
#        if data.row(i)[m]
#          property = Spree::Property.where(:presentation => data.row(i)[m].to_s, :property_type_id => property_type_id).first
#          if property
#            exist_product_property = Spree::ProductProperty.where(:product_id => product.id, :property_id => property.id).first
#            if exist_product_property.nil?
#              puts "    property include: #{property.presentation} "
#              product_property = Spree::ProductProperty.create(
#                  :product_id => product.id,
#                  :property_id => property.id
#              )
#              product_property.save
#            end
#          end
#        else
#          break
#        end
#      end
#
#      # Properties Feature
#      #set_property(product, 'stars', data.row(i)[46])
#      #set_property(product, 'address', data.row(i)[37])
#
#      # Rooms
#      master_room = true
#      while(data.row(j)[0].nil?)
#        if data.row(j)[2]
#          puts "    room: #{data.row(j)[2]}"
#          room_name = data.row(j)[2].to_s + ' | ' + product.name
#          master = false
#          room = Spree::Product.where(:name => room_name).first
#          if room.nil?
#            puts "La habitacion no existe:  ummmmmmmmmm"
#            room = Spree::Product.create(
#                :name => room_name,
#                :available_on => Time.now,
#                :count_on_hand => 0,
#                :price => 0,
#                :description => '',
#                :permalink => product.permalink + '-' + get_permalink(data.row(j)[2])
#            )
#            room.save
#
#            # Customization type
#            room.product_customization_types << Spree::ProductCustomizationType.find_by_name('checkinout')
#
#            # Relations
#            relation_name = master_room ? 'is-main-part-of-hotel' : 'is-part-of-hotel'
#            relation_type = Spree::RelationType.find_by_name(relation_name)
#            puts "        relation: #{relation_name}"
#            relation = Spree::Relation.new()
#            relation.relation_type = relation_type
#            relation.related_to = product
#            relation.relatable = room
#            relation.related_to_type = 'Spree::Product'
#            relation.relatable_type = 'Spree::Product'
#            relation.save
#            master_room = false
#
#            # Product Option Types
#            room.option_types = option_types
#            room.save
#            master = true
#          end
#
#          # Variants
#          for n in j+1..j+4
#
#            # Variables de precio
#            start_season = data.row(n)[11]
#            end_season = data.row(n)[12]
#            single = get_value(data.row(n)[13])
#            doble = get_value(data.row(n)[14])
#            triple = get_value(data.row(n)[15])
#            plan_cp = get_value(data.row(n)[16])
#            plan_map = get_value(data.row(n)[17])
#            plan_ap = get_value(data.row(n)[19])
#            add_adult = data.row(n)[20]
#            one_child = get_value(data.row(n)[21])
#            two_child = get_value(data.row(n)[22])
#            max_adult = data.row(n)[26]
#            max_child = data.row(n)[27]
#
#            if start_season and end_season
#
#              year = start_season.year
#              if start_season.month > end_season.month
#                year = start_season.year - 1
#              end
#
#              season_name = "from-#{year}/#{start_season.month}/#{start_season.day}-to-#{end_season.year}/#{end_season.month}/#{end_season.day}"
#              season_value = Spree::OptionValue.find_by_name(season_name)
#              if season_value.nil?
#                season_value = Spree::OptionValue.create(
#                    :name => season_name,
#                    :presentation => season_name.gsub("-", " ").capitalize,
#                    :option_type_id => Spree::OptionType.find_by_name('season').id
#                )
#              end
#
#              if ['NO SE ACEPTA', 'NO'].include?(max_child)
#                pax_variants = (1..max_adult).map {|x| "adult-#{x}"}
#              elsif ['NO SE ACEPTA'].include?(single)
#                pax_variants = (2..max_adult).to_a.product((0..max_child).to_a).collect {|x, y| y != 0 ? "adult-#{x}--child-#{y}" : "adult-#{x}"}
#              else
#                pax_variants = (1..max_adult).to_a.product((0..max_child).to_a).collect {|x, y| y != 0 ? "adult-#{x}--child-#{y}" : "adult-#{x}"}
#              end
#              pax_variants = pax_variants - exceptions
#              pax_variants.each do |px|
#
#                plans = [16, 17, 19]
#                all_inclusive = false
#                if plan_cp.to_s == 'Incluido' and plan_map.to_s == 'Incluido' and plan_ap.to_s == 'Incluido'
#                  plans = [16]
#                  all_inclusive = true
#                end
#
#                plans.each do |mp|
#                  if data.row(n)[mp]
#
#                    price = 0
#                    pax_values = px.split('--')
#                    cant_adult = pax_values[0].split('-')[1].to_i
#
#                    # Adult
#                    if cant_adult <= 3 and data.row(n)[occupation[pax_values[0]]]
#                      price += data.row(n)[occupation[pax_values[0]]].value * cant_adult
#                    end
#
#                    if cant_adult > 3
#                      addition = add_adult > 1 ? add_adult : (doble + (doble * add_adult))
#                      price += addition * (cant_adult - 3)
#                    end
#
#                    if data.row(n)[mp].to_s != 'Incluido'
#                      price += data.row(n)[mp] * pax_values[0].split('-')[1].to_i
#                    end
#
#                    # Child
#                    if pax_values.count > 1
#
#                      cant_child = pax_values[1].split('-')[1].to_i
#
#                      if one_child.to_s != 'FREE'
#                        reduction = one_child > 1 ? one_child : (doble - (doble * one_child))
#                        price += reduction
#                      end
#
#                      if cant_child > 1 and two_child != 'FREE'
#                        reduction = two_child > 1 ? two_child : (doble - (doble * two_child))
#                        price += reduction * (cant_child - 1)
#                      end
#
#                      if data.row(n)[mp].to_s != 'Incluido'
#                        if data.row(3)[mp].to_s.downcase == 'map'
#                          price += data.row(n)[mp+1] * cant_child
#                        else
#                          price += data.row(n)[mp] * cant_child
#                        end
#                      end
#
#                    end
#
#                    name_plan = all_inclusive ? plan['inc'] : plan[data.row(3)[mp].to_s.downcase]
#
#                    if price > 0
#
#                      # TODO: check if the variant exist
#                      ov_to_check = []
#                      ov_to_check << season_value if season_value
#                      adult_value = Spree::OptionValue.find_by_name(pax_values[0])
#                      ov_to_check << adult_value if adult_value
#                      if pax_values.count > 1
#                        child_value = Spree::OptionValue.find_by_name(pax_values[1])
#                        ov_to_check << child_value if child_value
#                      end
#                      mp_value = Spree::OptionValue.find_by_name(name_plan)
#                      ov_to_check << mp_value if mp_value
#
#                      exist_variant = nil
#                      room.variants_including_master.each do |v|
#                        if v.option_values.order(:position) == ov_to_check.order(:position)
#                          exist_variant = v
#                        end
#                      end
#
#                      if exist_variant.nil?
#                        puts "        variant: sku-#{room.permalink}-#{season_name}-#{px}-#{name_plan} .. price: #{price}"
#                        if master
#                          variant = Spree::Variant.where(:product_id => room.id).first
#                          variant.sku = "sku-#{room.permalink}-#{season_name}-#{px}-#{name_plan}-master"
#                          variant.price = price
#                          variant.save
#                        else
#                          variant = Spree::Variant.create(
#                              :product_id => room.id,
#                              :sku => "sku-#{room.permalink}-#{season_name}-#{px}-#{name_plan}",
#                              :price => price
#                          )
#                          variant.save
#                        end
#                        master = false
#
#                        # Variant Option Values
#                        variant.option_values = ov_to_check unless variant.option_values
#                        variant.save
#                      else
#                        puts "    Update variant: sku-#{room.permalink}-#{season_name}-#{px}-#{name_plan} .. #{price}"
#                        exist_variant.price = price
#                        exist_variant.save
#                      end
#                    end
#
#                  end
#
#                end
#
#              end
#
#            else
#              break
#            end
#
#
#          end
#
#          # Properties Feature
#          #set_property(room, 'tipo-de-propiedad', data.row(j)[3])
#          #set_property(room, 'confort', data.row(j)[4])
#          #set_property(room, 'nivel-de-servicio', data.row(j)[6])
#          #set_property(room, 'vista', data.row(j)[8])
#
#        else
#          if j > data.last_row_index
#            break
#          end
#        end
#        j += 1
#      end
#
#      i = j
#
#    end
#
#  end
#
#
#
#end
#
