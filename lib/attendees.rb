require "./lib/data_load"
require "./lib/data_scrub"
require "./lib/attendee"
require "pry"

class Attendees
  attr_reader :data, :attendees

  def initialize(file)
    data = DataLoad.load_file(file)
    @attendees = data.map do |row|
      Attendee.new(row)
    end
  end

  def search_attendees(attribute, criteria)
    found = []
    attribute = attribute.downcase
    found = @attendees.select do |attendee|
      attendee if attendee.send(attribute) == DataScrub.scrub_word(criteria)
    end
    return found
  end

end
