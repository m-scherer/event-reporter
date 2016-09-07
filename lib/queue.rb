require "sunlight/congress"
require_relative "attendees"
require_relative "data_scrub"
require 'open-uri'
require 'json'
require "pry"

Sunlight::Congress.api_key = "7f37e6069038458d9d3cb6001c8d560e"


class Queue
  attr_reader :queue
  include DataScrub

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

  def set_district
    @queue.each do |record|
      record[:district] = get_districts(record[:zipcode])
    end
  end

  def get_districts(zipcode)
    url = "http://congress.api.sunlightfoundation.com/districts/locate?zip=#{zipcode}&apikey=7f37e6069038458d9d3cb6001c8d560e"
    data = JSON.parse(open(url).read)
    data_parsed = data.values[0]
    district_and_state = data_parsed.map do |record|
      "#{record["state"]}: #{record["district"]}"
    end
    data_return = district_and_state.join(" / ")
    return data_return
  end

  def sort_by_attribute(attribute)
    sort_attribute = attribute.to_sym
    sorted = @queue.sort_by do |record|
      record[sort_attribute]
    end
    print_queue_to_terminal(sorted)
  end

  def print_queue_to_terminal(queue_print=@queue)
    headers = "\nLAST NAME".ljust(15) + "FIRST NAME".ljust(15) + "EMAIL".ljust(40) + "ZIPCODE".ljust(10) + "CITY".ljust(15) + "STATE".ljust(7) + "ADDRESS".ljust(25) + "PHONE".ljust(15) + "DISTRICT".ljust(10)
    puts headers
    queue_print.each do |record|
      data =  DataScrub::capitalize_name(record[:last_name]).ljust(15) +
      DataScrub::capitalize_name(record[:first_name]).ljust(15) +
      DataScrub::capitalize_name(record[:email]).ljust(40) +
      DataScrub::capitalize_name(record[:zipcode]).ljust(10) +
      DataScrub::capitalize_name(record[:city]).ljust(15) +
      DataScrub::capitalize_name(record[:state]).ljust(7) +
      DataScrub::capitalize_name(record[:street]).ljust(25) +
      DataScrub::capitalize_name(record[:phone]).ljust(15) +
      DataScrub::capitalize_name(record[:district]).ljust(10)
      puts data
    end
  end

end
