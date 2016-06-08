# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Chicago seeds run on Lincoln Park (41.9214, -87.6513), Old Town (41.9077, -87.6374), Gold Coast (41.9058, -87.6273), River North (41.8924, -87.6341), Streeterville (41.8946364, -87.6305035), Chicago Loop(41.8837, -87.6289), West Loop (41.8835758, -87.6607597), South Loop (41.8614215, -87.6450106)

# New York City seeds run on Financial (40.7075, -74.0113) Tribeca (40.7163, -74.0086), Lower East Side (40.7150, -73.9843), East Village (40.7265, -73.9815), West Village (40.7358, -74.0036), Midtown (40.756859, -73.9854577), Upper East Side (40.7731282, -73.9752436), Upper West Side (40.7872892, -73.994804), Harlem(40.8156962, -73.9655982)

# Boston seeds run on North End (42.3647, -71.0542), Beacon Hill (42.3588, -71.0707), Financial District (42.3559, -71.0550), Theatre District (42.3508079, -71.0696377), Back Bay (42.3503, -71.0810)

# San Francisco seeds run on Mission (37.7599, -122.4148), Marina (37.8037, -122.4368), Russian Hill (37.8011, -122.4196), Mission Bay (37.7731, -122.3929), Pacific Heights (37.7925, -122.4382), Noe Valley (37.7502, -122.4337), Sunset(37.7467, -122.4863), The Castro (37.7609, -122.4350), Financial District (37.7946, -122.3999)

api_key = ENV["my_key"]

position = 0
num_results = 100

lat = 37.7946
lng = -122.3999

while position < num_results
  if num_results - position >= 20
    api_count = 20
    zomato_response = HTTParty.post(
    "https://developers.zomato.com/api/v2.1/search?start=#{position}&count=#{api_count}&lat=#{lat.to_s}&lon=#{lng.to_s}&radius=1000",
    headers: {"user-key" => api_key}
    )

    count = 0
    while count < api_count
      zomato_trial = zomato_response["restaurants"][count]["restaurant"]
      r = Restaurant.new
      r.city = zomato_trial["location"]["city"]
      r.url = zomato_trial["url"]
      r.name = zomato_trial["name"]
      r.cuisine = zomato_trial["cuisines"]
      r.cost = zomato_trial["average_cost_for_two"]
      r.rating = zomato_trial["user_rating"]["aggregate_rating"]
      r.votes = zomato_trial["user_rating"]["votes"]
      r.save
      count+=1
    end
  else
      api_count = num_results - position
      zomato_response = HTTParty.post(
      "https://developers.zomato.com/api/v2.1/search?start=#{position}&count=#{api_count}&lat=#{lat.to_s}&lon=#{lng.to_s}&radius=1000",
      headers: {"user-key" => api_key}
      )

      count = 0
      while count < api_count
        zomato_trial = zomato_response["restaurants"][count]["restaurant"]
        r = Restaurant.new
        r.name = zomato_trial["name"]
        r.cuisine = zomato_trial["cuisines"]
        r.cost = zomato_trial["average_cost_for_two"]
        r.rating = zomato_trial["user_rating"]["aggregate_rating"]
        r.save
        count+=1
      end
  end
  position+= 20
end
