require "minitest/autorun"
require 'bundler'
require 'rest_client'
require 'awesome_print'
require 'base64'
require 'json'
require 'pry'
require './lib/estimote.rb'
require './lib/estimote/client.rb'
require './lib/estimote/beacons.rb'
require './lib/estimote/analytics.rb'

class TestAPI < Minitest::Test
  APP_KEY         = 'crm-13k'
  APP_TOKEN       = 'e94154369d85b14b3c7be85eb402c795'
  VALID_BEACON_ID = 'B9407F30-F5F8-466E-AFF9-25556B57FE6D:64529:26670'
  VALID_SETTINGS  = {
    interval: 1000 # change with desired settings
  }
  VALID_REGION    = 'B9407F30-F5F8-466E-AFF9-25556B57FE6D'
  # VALID_BEACON_ID = 'REPLACE_WITH_VALID_BEACON_ID'
  # APP_KEY   = 'REPLACE_WITH_YOUR_KEY'
  # APP_TOKEN = 'REPLACE_WITH_YOUR_TOKEN'

  # let(:client) { Estimote.new(api_key: APP_KEY, api_token: APP_TOKEN) }

  def setup
    @client = Estimote.new(api_key: APP_KEY, api_token: APP_TOKEN)
  end

  def test_valid_authorization
    begin
      @client.beacons.all
      code = @client.beacons.last_response.code
      rescue => e # Rest-client raises "forbidden" exception in case of unauthorized access
       code = e.response .code
    end
    assert code == 200, message: "Should have gotten a 200 OK"
  end

  def test_invalid_authorization
    client = Estimote.new(api_key: APP_KEY, api_token: "xxx")
    begin
      client.beacons.all
      code = client.beacons.last_response.code
      rescue => e # Rest-client raises "forbidden" exception in case of unauthorized access
       code = e.response.code
    end
    assert code == 403, message: "Should have gotten a 403 Forbidden"
  end

  def test_get_beacon_with_valid_ID
    response = @client.beacons.with_id(VALID_BEACON_ID)
    refute_empty response, message: "Should have received beacon properties"
  end

  def test_get_beacon_with_invalid_ID
    invalid_beacon_id = "123456789"
    response = @client.beacons.with_id(invalid_beacon_id)
    assert_empty response, message: "Should have received empty response"
  end

  def test_get_all_beacons
    response = @client.beacons.all
    refute_empty response, message: "Should have received all beacons from cloud"    
  end

  def test_beacons_need_uptade
    begin
      @client.beacons.need_update
      code = @client.beacons.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 200, message: "Should have gotten success, got server error"
  end

  def test_store_valid_settings_with_valid_beacon
    begin
      @client.beacons.store_beacon_settings VALID_BEACON_ID, VALID_SETTINGS
      code = @client.beacons.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 200, message: "Should have gotten success storing settings to beacon"
  end

  # If inputs are incorrect, no error is being raised
  def test_store_invalid_settings_beacon
    invalid_settings = {
      not_a_field: "not_a_value"
    }
    begin
      @client.beacons.store_beacon_settings VALID_BEACON_ID, invalid_settings
      code = @client.beacons.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 400, message: "Should have gotten bad request due to invalid settings"
  end

  # If inputs are incorrect, no error is being raised
  def test_store_settings_invalid_beacon
    invalid_beacon_id = "123456789"
    begin
      @client.beacons.store_beacon_settings invalid_beacon_id, invalid_settings
      code = @client.beacons.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 404, message: "Should have gotten Not Found error when passing invalid beacon ID"
  end

  def test_unique_visits_with_valid_region
    begin
      @client.analytics.unique_visitors VALID_REGION
      code = @client.analytics.last_response.code
    rescue
      code = e.response.code
    end
    assert code == 404, message: "Should have gotten OK 200 response"
  end

  def test_unique_visits_with_invalid_region
    begin
      @client.analytics.unique_visitors "not_a_region"
      code = @client.analytics.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 200, message: "Should have gotten invalid region error"
  end

  def test_visits_with_valid_region
    begin
      @client.analytics.visits VALID_REGION
      code = @client.analytics.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 200, message: "Should have gotten OK 200 response"
  end

  def test_visits_with_invalid_region
    begin
      @client.analytics.visits "not_a_region"
      code = @client.analytics.last_response.code
    rescue => e
      code = e.response.code
    end
    assert code == 200, message: "Should have gotten invalid region error"
  end
end 



