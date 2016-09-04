require "pry"
require_relative "data_load"
require_relative "data_scrub"

class Attendees
  attr_reader :data
  include DataLoad
  include DataScrub

  def initialize
    @data = DataLoad::load_file
  end

  def create_attendees
    attendees = []
    data.each do |row|
      id = row[0]
      first_name = row[:first_name]
      last_name = row[:last_name]
      zipcode = DataScrub::scrub_zipcode(row[:zipcode])
      attendees << {:id=>id, :first_name=>first_name, :last_name=>last_name, :zipcode=>zipcode}
    end
    return attendees
  end

end
