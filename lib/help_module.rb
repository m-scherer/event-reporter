require "pry"

module HelpModule
#output possible commands
#outpt (single) command usage
  def self.help
    p "Avaiable commands:"\
      "\n   load"\
      "\n   queue count"\
      "\n   queue clear"\
      "\n   queue district"\
      "\n   queue print"\
      "\n   queue print by <attribute>"\
      "\n   queue save to <filename.csv>"\
      "\n   queue export html <filename.html>"\
      "\n   find <attribute> <criteria>"
  end

  def self.help_load
    p "Erase any loaded data and parse the specified file. "\
    "If no filename is given, default to 'event_attendees.csv'."
  end

  def self.help_queue_count
    p "Outputs how many records are in the current queue"
  end

  def self.help_queue_clear
    p "Empties the queue"
  end

  def self.help_queue_district
    p "If there are less than 10 entries in the queue, "\
    "this command will use the Sunlight API to get Congressional District information for each entry."
  end

  def self.help_queue_print
    p "Print out a tab-delimited data table with a header row following this format:/n
      LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE  DISTRICT"
  end

  def self.help_queue_print_by
    p "Prints the queue sorted by the specified attribute like zipcode"
  end

  def self.help_save_to
    p "Exports the current queue to the specified filename as a CSV. "\
    "The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number."
  end

  def self.help_export_html
    p "Export the current queue to the specified filename as a valid HTML file."\
    "The file should use tables and include the data for all of the expected information."
  end

  def self.help_find
    p "Load the queue with all records matching the criteria for the given attribute."
  end

end
