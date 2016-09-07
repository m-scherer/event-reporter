require "csv"
require "pry"

module DataLoad
    def self.load_file(file)
      file = file || "event_attendees.csv"
      contents = CSV.open file.to_s, headers: true, header_converters: :symbol
      return contents
    end
end
