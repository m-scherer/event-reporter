require "./test/test_helper"
require "./lib/help_module"
require "pry"

class HelpModuleTest < Minitest::Test
  include HelpModule

  def test_print_all_possible_commands
    assert_equal [], HelpModule::help
  end

  def test_help_command_returns_description
    assert_equal "Erase any loaded data and parse the specified file. If no filename is given, default to 'event_attendees.csv'.", HelpModule::help("load")
    assert_equal "Outputs a listing of the available individual commands", HelpModule::help("help")
    assert_equal "If there are less than 10 entries in the queue, this command will use the Sunlight API to get Congressional District information for each entry.", HelpModule::help("queue district")
    assert_equal "Please enter a valid command", HelpModule::help("test")
  end

end
