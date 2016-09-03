require "csv"
require "pry"

class DataLoad

  def load_file
    contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
    binding.pry
  end

end
