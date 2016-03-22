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

end
