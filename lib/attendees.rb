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
      # Attendee.new(row)
      id = row[0]
      last_name = DataScrub::scrub_name(row[:last_name])
      first_name = DataScrub::scrub_name(row[:first_name])
      email = row[:email_address]
      zipcode = DataScrub::scrub_zipcode(row[:zipcode])
      city = DataScrub::scrub_name(row[:city])
      state = row[:state]
      street = row[:street]
      phone = DataScrub::scrub_phone_number(row[:homephone])
      district = "unknown"
      @attendees << {:id=>id, :last_name=>last_name, :first_name=>first_name, :email=>email, :zipcode=>zipcode, :city=>city, :state=>state, :street=>street, :phone=>phone, :district=>district}
    end
    return @attendees
  end

  def search_attendees(attribute, criteria)
    found = []
    attribute = attribute.downcase
      case attribute
      when "last_name" then
        found  = @attendees.select { |attendee| attendee[:last_name] == DataScrub::scrub_name(criteria) }
      when "first_name" then
        found  = @attendees.select { |attendee| attendee[:first_name] == DataScrub::scrub_name(criteria) }
      when "email" then
        found  = @attendees.select { |attendee| attendee[:email] == criteria }
      when "zipcode" then
        found  = @attendees.select { |attendee| attendee[:zipcode] == criteria }
      when "city" then
        found  = @attendees.select { |attendee| attendee[:city] == DataScrub::scrub_name(criteria) }
      when "state" then
        found  = @attendees.select { |attendee| attendee[:state] == criteria.upcase }
      when "street" then
        found  = @attendees.select { |attendee| attendee[:street] == criteria }
      when "phone" then
        found  = @attendees.select { |attendee| attendee[:phone] == DataScrub::scrub_phone_number(criteria) }
      end
    return found
  end


end
