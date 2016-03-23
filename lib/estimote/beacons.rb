module Estimote
  class Beacons
    attr_accessor :last_response
    
    def all
      uri           = API_URL + "beacons"
      @last_response = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }
      
      JSON.parse(@last_response)
    end

    def with_id beacon_id
      json_response     = all
      device_properties = {}
      
      json_response.each do |device|
        device_properties = device if device['id'] == beacon_id
      end

      device_properties
    end

    def need_update
      uri      = API_URL + "beacons/pending_settings"
      @last_response = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(@last_response)
    end

    def store_beacon_settings(beacon_id, new_settings)
      uri      = API_URL + "beacons/#{beacon_id}/pending_settings"
      @last_response = RestClient.post uri, new_settings , { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(@last_response)
    end

    def store_beacons_settings(devices_id, new_settings)
      uri              = API_URL + "beacons/pending_settings"
      devices_settings = {
        beacons: devices_id,
        settings: new_settings
      }
      @last_response    = RestClient.post uri, devices_settings , { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }
      
      JSON.parse(@last_response)
    end
  end
end
