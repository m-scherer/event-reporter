require "sunlight/congress"

class Sun

  def initialize
    @client = Sunlight::Congress::Client.new(7f37e6069038458d9d3cb6001c8d560e)
  end

  def return_district(zipcode)
    @client.districts_locate(zipcode).to_hash["results"][0]["district"].to_s
  end
end

Sun.new.return_district('80218')
