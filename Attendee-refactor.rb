class Attendee
  include DataScrub

  def initialize(row)
    @last_name = DataScrub::scrub_name(row[:last_name])
    @first_name = DataScrub::scrub_name(row[:first_name])
    @email = row[:email_address]
    @zipcode = DataScrub::scrub_zipcode(row[:zipcode])
    @city = row[:city]
    @state = row[:state]
    @street = row[:street]
    @phone = DataScrub::scrub_phone_number(row[:homephone])
  end
end
