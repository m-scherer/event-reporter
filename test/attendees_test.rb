require "minitest/autorun"
require "minitest/pride"
require "./lib/attendees"
require "./lib/data_load"
require "pry"

class AttendeesTest < Minitest::Test
  include DataLoad

  def test_if_attendees_is_created
    assert_equal Attendees, Attendees.new.class
  end

  def test_if_data_is_loaded
    attendees = Attendees.new

    refute nil, attendees.data
  end

end
