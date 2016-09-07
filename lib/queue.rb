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

  def sort_by_attribute(attribute)
    sort_attribute = attribute.to_sym
    sorted = @queue.sort_by do |record|
      record[sort_attribute]
    end
    print_queue_to_terminal(sorted)
  end

  def print_queue_to_terminal(queue_print=@queue)
    headers = "LAST NAME".ljust(15) + "FIRST NAME".ljust(15) + "EMAIL".ljust(40) + "ZIPCODE".ljust(10) + "CITY".ljust(15) + "STATE".ljust(7) + "ADDRESS".ljust(25) + "PHONE".ljust(15) + "DISTRICT".ljust(10)
    puts headers
    queue_print.each do |record|
      data =  record[:last_name].ljust(15) + record[:first_name].ljust(15) + record[:email].ljust(40) + record[:zipcode].ljust(10) + record[:city].ljust(15) + record[:state].ljust(7) + record[:street].ljust(25) + record[:phone].ljust(15)
      puts data
    end
  end

end
