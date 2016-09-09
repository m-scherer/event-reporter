require "./test/test_helper"
require "./lib/data_load"
require "pry"

class DataLoadTest < Minitest::Test

  def test_if_data_is_loaded
    refute nil, DataLoad.load_file("event_attendees.csv")
  end

end
