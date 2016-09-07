require_relative "data_load"
require_relative "data_scrub"
require "pry"

class Attendees
  attr_reader :data, :attendees
  include DataLoad
  include DataScrub

  def initialize(file)
    @data = DataLoad::load_file(file)
    @attendees = create_attendees
  end

  def create_attendees
    @attendees = []
    @data.each do |row|
      id = row[0]
      last_name = DataScrub::scrub_word(row[:last_name])
      first_name = DataScrub::scrub_word(row[:first_name])
      email = row[:email_address]
      zipcode = DataScrub::scrub_zipcode(row[:zipcode])
      city = DataScrub::scrub_word(row[:city])
      state = DataScrub::scrub_word(row[:state])
      street = DataScrub::scrub_word(row[:street])
      phone = DataScrub::scrub_phone_number(row[:homephone])
      district = "unknown"
      @attendees << {:id=>id, :last_name=>last_name, :first_name=>first_name, :email=>email, :zipcode=>zipcode, :city=>city, :state=>state, :street=>street, :phone=>phone, :district=>district}
    end
    return @attendees
  end

  def search_attendees(attribute, criteria)
    found = []
    attribute = attribute.downcase
    found  = @attendees.select do |attendee|
      attendee[attribute.to_sym] == DataScrub::scrub_word(criteria)
    end
    return found
  end


end
