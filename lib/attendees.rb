require "pry"
require_relative "data_load"
require_relative "data_scrub"

class Attendees
  attr_reader :data, :attendees
  include DataLoad
  include DataScrub

  def initialize
    @data = DataLoad::load_file
    @attendees = create_attendees
  end

  def create_attendees
    @attendees = []
    @data.each do |row|
      id = row[0]
      last_name = DataScrub::scrub_name(row[:last_name])
      first_name = DataScrub::scrub_name(row[:first_name])
      email = row[:email_address]
      zipcode = DataScrub::scrub_zipcode(row[:zipcode])
      city = row[:city]
      state = row[:state]
      street = row[:street]
      phone = DataScrub::scrub_phone_number(row[:homephone])
      # district
      @attendees << {:id=>id, :last_name=>last_name, :first_name=>first_name, :email=>email, :zipcode=>zipcode, :city=>city, :state=>state, :street=>street, :phone=>phone}
    end
    return @attendees
  end

  def search_attendees(attribute, criteria)
    found = ""
    attribute = attribute.downcase
      case attribute
      when "last_name" then
        found  = @attendees.select { |attendee| DataScrub::scrub_name(attendee[:last_name]) == DataScrub::scrub_name(criteria) }
      when "first_name" then
        found  = @attendees.select { |attendee| DataScrub::scrub_name(attendee[:first_name]) == DataScrub::scrub_name(criteria) }
      when "email" then
        found  = @attendees.select { |attendee| attendee[:email] == criteria }
      when "zipcode" then
        found  = @attendees.select { |attendee| attendee[:zipcode] == criteria }
      when "city" then
        found  = @attendees.select { |attendee| DataScrub::scrub_name(attendee[:city]) == DataScrub::scrub_name(criteria) }
      when "state" then
        found  = @attendees.select { |attendee| attendee[:state] == criteria }
      when "street" then
        found  = @attendees.select { |attendee| attendee[:street] == criteria }
      when "phone" then
        found  = @attendees.select { |attendee| DataScrub::scrub_phone_number(attendee[:phone]) == DataScrub::scrub_phone_number(criteria) }
      end
    return found
  end


end
