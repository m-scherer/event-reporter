require "sunlight/congress"
require_relative "attendees"
require "pry"

Sunlight::Congress.api_key = "7f37e6069038458d9d3cb6001c8d560e"


class Queue
  attr_reader :queue
  def initialize
    @queue = []
  end

  def add_to_queue(instance,attribute, criteria)
    clear_queue
    instance.search_attendees(attribute, criteria).each  do |record|
      @queue << record
    end
  end

  def clear_queue
    @queue = []
  end

  def count_queue
    @queue.length
  end

  def get_legislators(zipcode)
    legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
    legislators_listed = legislators.map do |legislator|
      legislator.first_name + (" ") + legislator.last_name
    end
    return legislators_listed
  end

end
