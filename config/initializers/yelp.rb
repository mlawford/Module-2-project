# Yelp.client.configure do |config|
#   config.consumer_key = "ae8eRxf6Voa5YKiwQGs6Zg"
#   config.consumer_secret = "krpAhVhTiLvjB27X69Svi4aZK4HWwDZDwPQ2Ochx0uBqq3izBWLQAkWuH47apRwM"
#   config.token = "1h2knXebydlDbnxmw5cD0i1cf2w7k4WPYVZRehwwuV6-uCD2TpWJuoVQKbVdqkBP8v0C84ULAWfEIqDIZngfUU8OT2xrIjjFqobNBohaDdLKkJL2PrlapYzI3u3TWXYx"
#   config.token_secret = "74f7db93489f794ea1ce904bbae3fc863eff91d59e9de63a7624c3c14259c9f6d1e41cf30096b7a737ca2954c1162ce72b1d02c875e199206c3678aea89c374f"
# end

require "json"
require "http"
require "optparse"


CLIENT_ID = "ae8eRxf6Voa5YKiwQGs6Zg"
CLIENT_SECRET = "krpAhVhTiLvjB27X69Svi4aZK4HWwDZDwPQ2Ochx0uBqq3izBWLQAkWuH47apRwM"

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
TOKEN_PATH = "/oauth2/token"
GRANT_TYPE = "client_credentials"


DEFAULT_BUSINESS_ID = "yelp-new-york"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York, NY"
SEARCH_LIMIT = 5

def bearer_token
  # Put the url together
  url = "#{API_HOST}#{TOKEN_PATH}"

  raise "Please set your CLIENT_ID" if CLIENT_ID.nil?
  raise "Please set your CLIENT_SECRET" if CLIENT_SECRET.nil?

  # Build our params hash
  params = {
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET,
    grant_type: GRANT_TYPE
  }

  response = HTTP.post(url, params: params)
  parsed = response.parse

  "#{parsed['token_type']} #{parsed['access_token']}"
end

def search(term, location) #Returns a hash "businesses" with an array of hashes "each restaurant" name and cuisines are keys with values
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: term,
    location: location,
    limit: SEARCH_LIMIT
  }

  response = HTTP.auth(bearer_token).get(url, params: params)
  response.parse
end

# Look up a business by a given business id. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business
#
# business_id - a string business id
#
# Examples
#
#   business("yelp-san-francisco")
#   # => {
#          "name": "Yelp",
#          "id": "yelp-san-francisco"
#          ...
#        }
#
# Returns a parsed json object of the request
def business(business_id)
  url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

  response = HTTP.auth(bearer_token).get(url)
  response.parse
end


options = {}
OptionParser.new do |opts|
  opts.banner = "Example usage: ruby sample.rb (search|lookup) [options]"

  opts.on("-tTERM", "--term=TERM", "Search term (for search)") do |term|
    options[:term] = term
  end

  opts.on("-lLOCATION", "--location=LOCATION", "Search location (for search)") do |location|
    options[:location] = location
  end

  opts.on("-bBUSINESS_ID", "--business-id=BUSINESS_ID", "Business id (for lookup)") do |id|
    options[:business_id] = id
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!


command = ARGV


case command.first
when "search"
  term = options.fetch(:term, DEFAULT_TERM)
  location = options.fetch(:location, DEFAULT_LOCATION)

  raise "business_id is not a valid parameter for searching" if options.key?(:business_id)

  response = search(term, location)

  puts "Found #{response["total"]} businesses. Listing #{SEARCH_LIMIT}:"
  response["businesses"].each {|biz| puts biz["name"]}
when "lookup"
  business_id = options.fetch(:business_id, DEFAULT_BUSINESS_ID)


  raise "term is not a valid parameter for lookup" if options.key?(:term)
  raise "location is not a valid parameter for lookup" if options.key?(:lookup)

  response = business(business_id)

  puts "Found business with id #{business_id}:"
  puts JSON.pretty_generate(response)
else
  puts "Please specify a command: search or lookup"
end
