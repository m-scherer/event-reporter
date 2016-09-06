require "./lib/data_load"

require "pry"

module HelpModule
#output possible commands
#outpt (single) command usage
  def self.help(input=nil)
    if input == "load"
      return "Erase any loaded data and parse the specified file. "\
      "If no filename is given, default to 'event_attendees.csv'."
    elsif input == "help"
      return "Outputs a listing of the available individual commands"
    elsif input == "help <command>"
      return "Output a description of how to use the specific command. "\
      "For example: 'help queue clear' or 'help find'"
    elsif input == "queue count"
      return "Outputs how many records are in the current queue"
    elsif input == "queue clear"
      return "Empties the queue"
    elsif input == "queue district"
      return "If there are less than 10 entries in the queue, "\
      "this command will use the Sunlight API to get Congressional District information for each entry."
    elsif input == "queue print"
      return "Print out a tab-delimited data table with a header row following this format:/n
        LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE  DISTRICT"
    elsif input == "queue print by"
      return "Prints a description of a given command"
    elsif input == "help <command>"
      return "Prints a description of a given command"
    elsif input.nil?
      HelpModule.instance_methods(false)
    else
      return "Please enter a valid command"
    end
  end

end
