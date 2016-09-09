require './lib/data_scrub'

class Attendee
  attr_reader :last_name, :first_name, :email, :zipcode, :city,
              :state, :street, :phone
  attr_accessor :district

  def initialize(row)
    @last_name = DataScrub.scrub_word(row[:last_name])
    @first_name = DataScrub.scrub_word(row[:first_name])
    @email = row[:email_address]
    @zipcode = DataScrub.scrub_zipcode(row[:zipcode])
    @city = DataScrub.scrub_word(row[:city])
    @state = DataScrub.scrub_word(row[:state])
    @street = DataScrub.scrub_word(row[:street])
    @phone = DataScrub.scrub_phone_number(row[:homephone])
    @district = "unknown"
  end
end
