module Estimote
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
