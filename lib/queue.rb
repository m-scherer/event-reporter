require "sunlight/congress"
require "./lib/attendees"
require "./lib/data_scrub"
require "terminal-table"
require 'open-uri'
require 'json'
require "pry"

class Queue
  attr_reader :queue

  def initialize
    @queue = []
  end

  def queue_math_subtract(instance,attribute,criteria)
    instance.search_attendees(attribute, criteria).each do |record|
      @queue.delete(record)
    end
    return @queue
  end

  def queue_math_add(instance,attribute,criteria)
    instance.search_attendees(attribute, criteria).each  do |record|
      @queue << record
    end
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

  def sort_by_and_print_call(attribute)
    sort_by_attribute(attribute)
    print_queue_to_terminal
  end

  def sort_by_attribute(attribute)
    sort_attribute = attribute.to_sym
    @queue = @queue.sort_by do |record|
      record[sort_attribute]
    end
    return @queue
  end

  def print_queue_to_terminal(queue_print=@queue)
    headers = ["LAST NAME","FIRST NAME","EMAIL","ZIPCODE","CITY","STATE","ADDRESS","PHONE","DISTRICT"]
    rows = []
    data = []
    queue_print.each do |record|
      data = [DataScrub.capitalize_name(record[:last_name]),
      DataScrub.capitalize_name(record[:first_name]),
      DataScrub.capitalize_name(record[:email]),
      DataScrub.capitalize_name(record[:zipcode]),
      DataScrub.capitalize_name(record[:city]),
      record[:state].upcase,
      DataScrub.capitalize_name(record[:street]),
      record[:phone],
      record[:district]]
      rows << data
    end
    table = Terminal::Table.new :headings=> headers, :rows => rows
    puts table
    return queue_print
  end

end
