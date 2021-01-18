class Trip < ApplicationRecord
  has_many :travelers, inverse_of: :trip
  has_many :bridges, inverse_of: :trip

  accepts_nested_attributes_for :travelers, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :bridges, reject_if: :all_blank, allow_destroy: true
  after_save :calculate_travel_time

  def self.build_from_json(input_json=nil)
    test_json = "{\"trip\":{\"travelers\":[100,50,25,15,2.5],\"bridges\":[{\"length\":100,\"travelers\":[150]},{\"length\":50,\"travelers\":[10]}]}}"
    parsed_json = JSON.parse(input_json.present? ? input_json : test_json)
    # Set up trip data
    trip_data = parsed_json['trip']
    trip = Trip.new(name: Trip.get_name())
    trip.save!
    # Set up traveler data
    travelers_array = []
    travelers_data = trip_data['travelers']
    travelers_data.each do |traveler_details|
      new_traveler = Traveler.new(speed: traveler_details, name: Traveler.get_name())
      new_traveler.save!
      travelers_array << new_traveler
    end
    trip.travelers = travelers_array
    #  Set up bridge data
    bridges_array = []
    bridges_data = trip_data['bridges']
    bridges_data.each do |bridge_details|
      bridge_length = bridge_details['length']
      bridge_travelers_data = bridge_details['travelers']
      bridge_travelers_array = []
      bridge = Bridge.new(length: bridge_length)
      bridge.save!
      bridge_travelers_data.each do |bridge_traveler|
        new_bridge_traveler = Traveler.new(speed: bridge_traveler, name: Traveler.get_name())
        new_bridge_traveler.save!
        bridge_travelers_array << new_bridge_traveler
      end
      bridge.travelers = bridge_travelers_array
      bridge.save!
      bridges_array << bridge
    end
    trip.bridges = bridges_array
    trip.save!
  end

  def self.get_name
    names = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina",
             "Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados",
             "Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina",
             "Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia",
             "Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands",
             "Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark",
             "Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea",
             "Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia",
             "French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland",
             "Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras",
             "Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel",
             "Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos",
             "Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau",
             "Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico",
             "Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal",
             "Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria",
             "Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines",
             "Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda",
             "Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia",
             "Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain",
             "Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland",
             "Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo",
             "Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine",
             "United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)",
             "Yemen","Zambia","Zimbabwe"]
    names[rand(names.size)]
  end

  private

  def calculate_travel_time
    begin
      self.update_column(:travel_time, self.time())
    rescue Exception
    end
  end

  def time(persist_new_travelers = false)
    time = 0
    travelers = self.travelers
    self.bridges.each do |bridge|
      if persist_new_travelers
        travelers << bridge.travelers
        bridge_travelers = travelers
      else
        bridge_travelers = travelers + bridge.travelers
      end
      length = bridge.length
      start_array = bridge_travelers.sort! { |a,b| b.speed <=> a.speed}
      end_array = []
      loop do
        break if start_array.length == 0
        start_array.sort! { |a,b| b.speed <=> a.speed}
        in_transit = []
        # Calculate Torch Outbound
        if end_array.length == 0
          #Initial Trip
          if start_array.length == 1
            #Only one traveler just send them across
            speed = start_array[0].speed
            in_transit << start_array.delete_at(0)
            in_transit.sort! { |a,b| b.speed <=> a.speed}
            time += length/speed
            end_array << in_transit
            end_array.sort! { |a,b| b.speed <=> a.speed}
          else
            # TODO First trip always sends 2 fastest? Need to double check this isn't even/odd dependent
            in_transit << start_array.delete_at(0)
            in_transit << start_array.delete_at(0)
            in_transit.sort! { |a,b| b.speed <=> a.speed}
            speed = in_transit[1].speed
            time += length/speed
            end_array << in_transit
            end_array.sort! { |a,b| b.speed <=> a.speed}
          end
        else
          #Subsiquint Trips
          if start_array.length.odd?
            # If odd number on start side, send fastest and slowest
            in_transit << start_array.delete_at(0)
            in_transit << start_array.delete_at(start_array.length - 1 )
            in_transit.sort! { |a,b| b.speed <=> a.speed}
            speed = in_transit[1].speed
            time += length/speed
            end_array.sort! { |a,b| b.speed <=> a.speed}
          else
            # If even number on start side, send two slowest
            in_transit << start_array.delete_at(start_array.length - 1 )
            in_transit << start_array.delete_at(start_array.length - 1 )
            in_transit.sort! { |a,b| b.speed <=> a.speed}
            speed = in_transit[1].speed
            time += length/speed
            end_array.sort! { |a,b| b.speed <=> a.speed}
          end
        end
        break if start_array.length == 0
        # Calculate Torch Inbound always send fastest traveler back
        going_back = end_array.delete_at(0)[0]
        time += length/going_back.speed
        start_array << going_back
        start_array.sort! { |a,b| b.speed <=> a.speed}
      end
    end
    time.to_f.round(2)
  end
end
