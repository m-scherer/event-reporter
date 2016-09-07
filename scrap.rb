require 'open-uri'
require 'json'

zipcode = '80218'
url = "http://congress.api.sunlightfoundation.com/districts/locate?zip=#{zipcode}&apikey=7f37e6069038458d9d3cb6001c8d560e"
data = JSON.parse(open(url).read)
puts data
