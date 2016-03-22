module Estimote
  API_URL = "https://cloud.estimote.com/v1/"

  class Client   
    attr_accessor :auth 

    def initialize(credentials)
      username = credentials[:api_key]
      password = credentials[:api_token]
      @auth    = Base64.encode64("#{username}:#{password}").chomp
    end

    def beacons
      @beacons ||= Beacons.new
    end

    def analytics
      @analytics ||= Analytics.new
    end
  end

  class Beacons
    def all
      uri       = API_URL + "beacons"
      response  = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }
      
      JSON.parse(response)
    end

    def with_id (beacon_id)
      response_json     = all
      device_properties = {}
      
      response_json.each do |device|
        device_properties = device if device['id'] == beacon_id
      end

      device_properties
    end

    def need_update
      uri      = API_URL + "beacons/pending_settings"
      response = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(response)
    end

    def store_beacon_settings (beacon_id, new_settings)
      uri      = API_URL + "beacons/#{beacon_id}/pending_settings"
      response = RestClient.post uri, new_settings , { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(response)
    end

    def store_beacons_settings (devices_id, new_settings)
      uri              = API_URL + "beacons/pending_settings"
      devices_settings = {
        beacons: devices_id,
        settings: new_settings
      }
      response         = RestClient.post uri, devices_settings , { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }
      
      JSON.parse(response)
    end
  end

  class Analytics
    def unique_visitors (region)
      uri       = API_URL + "analytics/#{region}/unique_visitors"
      response  = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(response)
    end

    def visits (region)
      uri       = API_URL + "analytics/#{region}/visits"
      response  = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(response)
    end
  end

end
