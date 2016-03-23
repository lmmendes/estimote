module Estimote
  class Analytics
    attr_accessor :last_response

    def unique_visitors region
      uri       = API_URL + "analytics/#{region}/unique_visitors"
      @last_response  = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(@last_response)
    end

    def visits region
      uri       = API_URL + "analytics/#{region}/visits"
      @last_response  = RestClient.get uri, { Authorization:  "Basic #{Estimote.client.auth}", Accept: 'application/json' }

      JSON.parse(@last_response)
    end
  end
end
