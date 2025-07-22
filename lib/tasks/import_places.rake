namespace :places do
  desc "Import places from OpenStreetMap for specified city (CITY=city_name)"
  task import_osm: :environment do
    city = ENV["CITY"]

    if city.nil? || city.strip.empty?
      puts "ERROR: City name is required!"
      puts "Usage: rake places:import_osm CITY=\"city_name\""
      puts "       rails places:import_osm CITY=\"city_name\""
      exit(1)
    end

    puts "Importing places for city: #{city}"

    response = HTTParty.get("https://maps.mail.ru/osm/tools/overpass/api/interpreter", {
      body: build_overpass_query(city),
      headers: { "Content-Type" => "application/x-www-form-urlencoded" }
    })

    data = JSON.parse(response.body)
    count = import_osm_places(data["elements"])
    puts "Total imported places: #{count}"
  end

  private

  AMENITY_TYPES = %w[
    restaurant cafe bar pub fast_food ice_cream
    cinema theatre nightclub casino
    museum library gallery arts_centre planetarium
    shopping_mall marketplace
  ].freeze

  LEISURE_TYPES = %w[
    park playground garden nature_reserve
    swimming_pool water_park beach_resort
    fitness_centre sports_centre stadium pitch
    golf_course miniature_golf bowling_alley
    amusement_arcade escape_game trampoline_park
    indoor_play dance disc_golf horse_riding
    ice_rink marina fishing picnic_table
    barbecue sauna
  ].freeze

  def build_overpass_query(city_name)
    amenities = AMENITY_TYPES.join("|")
    leisure = LEISURE_TYPES.join("|")

    <<~QUERY
      [out:json][timeout:25];
      area["name"="#{city_name}"]["place"="city"]->.searchArea;
      (
        node["amenity"~"^(#{amenities})$"](area.searchArea);
        way["amenity"~"^(#{amenities})$"](area.searchArea);

        node["leisure"~"^(#{leisure})$"](area.searchArea);
        way["leisure"~"^(#{leisure})$"](area.searchArea);
      );
      out center meta;
    QUERY
  end

  def import_osm_places(elements)
    import_places_count = 0

    elements.each do |element|
      next unless element["tags"] && element["tags"]["name"]

      long = element["lon"] || element.dig("center", "lon")
      lat = element["lat"] || element.dig("center", "lat")

      next unless lat && long

      Place.create!(
        name: element["tags"]["name"],
        description: build_description(element["tags"]),
        location: Geo.point(long.to_f, lat.to_f)
      )

      puts "Place imported: #{element["tags"]["name"]}"
      import_places_count += 1
    end

    import_places_count
  end

  def build_description(tags)
    parts = []
    parts << "Тип: #{tags["amenity"]}" if tags["amenity"]
    parts << "Адрес: #{tags["addr:street"]} #{tags["addr:housenumber"]}" if tags["addr:street"]
    parts << "Телефон: #{tags["phone"]}" if tags["phone"]
    parts.join("\n")
  end
end
