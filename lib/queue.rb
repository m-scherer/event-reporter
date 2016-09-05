require "sunlight/congress"
require "pry"

Sunlight::Congress.api_key = "7f37e6069038458d9d3cb6001c8d560e"


class Queue

  def get_legislators(zipcode)
    legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
    legislators_listed = legislators.map do |legislator|
      legislator.first_name + (" ") + legislator.last_name
    end
    return legislators_listed
  end

end
