# Estimote API  
## Getting Started
To begin using this API you need to authenticate using your **App ID** and **App Token** that you can get from estimote cloud ([link](https://cloud.estimote.com/#/apps)).  
Your **App ID** will function as the username and the **App Token** as password.

~~~ruby
username = 'app key'
password = 'app token'

api = Estimote.new(api_key: username, api_token: password)
~~~  

## Resources

From here you will allways use `api` to make your calls.

### Analytics

#### Unique Visitors for Region

<https://cloud.estimote.com/docs/#api-Analytics-UniqueVisitors> Fetches a histogram of unique visitors detected in a given region.

**Field:** `region` of type `String` represents the ID of a region in an iBeacon compatible format

**Example:** `region = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"`

**Usage:** 

~~~ruby
api.analytics.unique_visitors(region)
~~~

**Returns:**  JSON as shown in estimote API  

--

#### Visits for Region

<https://cloud.estimote.com/docs/#api-Analytics-Visits> Fetches a histogram of visits detected in a given region. Visit is a chain of subsequent events of any type, spread out by no more than 60 minutes.

**Field:** `region` of type `String` represents the ID of a region in an iBeacon compatible format

**Example:** `region = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"`

~~~ruby
api.analytics.visits(region)
~~~

**Returns:**  JSON as shown in estimote API

--

### Beacons

#### Get all beacons that need update 
<https://cloud.estimote.com/docs/#api-Beacons-GetPendingSettings> Returns array of beacons that need update. Every beacon has a pending_settings object.

**Usage:**  

~~~ruby
api.beacons.need_update
~~~

**Returns:**  JSON with all beacons with pending updates as shown in estimote API  

--

#### Get all beacons
<https://cloud.estimote.com/docs/#api-Beacons-GetBeacons> Returns beacons connected to your Estimote Cloud account.

**Usage:**  

~~~ruby
api.beacons.all
~~~

**Returns:**  JSON with all beacon details as shown in estimote API  

--

#### Get one beacon using unique ID
<https://cloud.estimote.com/docs/#api-Beacons-GetBeacons> Returns beacon connected to your Estimot Cloud given a unique ID.

**Field:** `beacon_id` of type `String` represents the unique ID of a beacon

**Example:** `beacon_id = "B9407F30-F5F8-466E-AFF9-25556B57FE6D:major:minor"`

~~~ruby
api.beacons.with_id(beacon_id)
~~~

**Returns:**  JSON with the beacon details as shown in the estimote API

--

#### Store asynchronous setting changes to be set in one beacon

<https://cloud.estimote.com/docs/#api-Beacons-PostPendingSettingsSingleBeacon> Store changes in settings that will be set in one beacon (using the unique ID) by bulk updater in Estimote iOS app or other app based on Estimote SDK.

**Fields:** `beacon_id` of type `String` represents the unique ID of a beacon  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
`settings` of type `Object` representing the new settings of the beacon

**Example:**`beacon_id = "B9407F30-F5F8-466E-AFF9-25556B57FE6D:major:minor"`
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
`settings = { interval: 1000, basic_power_mode: true, ...} `

**Usage:**  

~~~ruby
api.beacons.store_beacon_settings(beacon_id, settings)
~~~

**Returns:**  JSON with status 'ok' if succeeded 

--

#### Get all beacons
#### (CURRENTLY NOT WORKING, WAITING FOR ESTIMOTE FEEDBACK)  
<https://cloud.estimote.com/docs/#api-Beacons-GetBeacons> Store settings changes that will be applied to beacons (one or more) by bulk updater in Estimote iOS app or other app based on Estimote SDK.  

**Fields:** `beacons` of type `String[]` represents the unique ID of all beacons  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
`settings` of type `Object` representing the new settings of the beacon

**Example:**`beacon_id = "B9407F30-F5F8-466E-AFF9-25556B57FE6D:major:minor"`
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
`settings = { interval: 1000, basic_power_mode: true, ...} `

**Usage:**  

~~~ruby
api.beacons.store_beacons_settings(beacons, settings)
~~~

**Returns:**  JSON with status 'ok' if succeeded  

