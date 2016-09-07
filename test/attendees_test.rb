require "./test/test_helper"
require "./lib/attendees"
require "./lib/data_load"
require "pry"

class AttendeesTest < Minitest::Test
  include DataLoad

  def test_if_class_is_created
    assert_equal Attendees, Attendees.new("event_attendees.csv").class
  end

  def test_if_data_is_loaded
    attendees = Attendees.new("event_attendees.csv")

    refute nil, attendees.data
  end

  def test_if_attendees_exist
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 5175, attendees.attendees.length
  end

  def test_can_it_find_attendees_by_last_name
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 3, attendees.search_attendees("last_name","SAUNDERS ").length
    assert_equal 3, attendees.search_attendees("last_name"," nguyen").length
    assert_equal 1, attendees.search_attendees("last_name","Kufner").length
    assert_equal 0, attendees.search_attendees("last_name","Dirt").length
  end

  def test_can_it_find_attendees_by_first_name
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 4, attendees.search_attendees("first_name","Greg ").length
    assert_equal 16, attendees.search_attendees("first_name"," allison").length
    assert_equal 56, attendees.search_attendees("first_name","Emily").length
    assert_equal 63, attendees.search_attendees("first_name","John").length
    assert_equal 0, attendees.search_attendees("first_name","Dirt").length
  end

  def test_can_it_find_attendees_by_zipcode
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 37, attendees.search_attendees("zipcode","20008").length
    assert_equal 5, attendees.search_attendees("zipcode","20010").length
    assert_equal 8, attendees.search_attendees("zipcode","18015").length
    assert_equal 0, attendees.search_attendees("zipcode","8").length
  end

  def test_can_it_find_attendees_by_city
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 3, attendees.search_attendees("city","Denver").length
    assert_equal 22, attendees.search_attendees("city","New York").length
    assert_equal 7, attendees.search_attendees("CITY",nil).length
  end

  def test_can_it_find_attendees_by_state
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 103, attendees.search_attendees("state","NJ").length
    assert_equal 29, attendees.search_attendees("state","CO").length
  end

  def test_can_it_find_attendees_by_street
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 1, attendees.search_attendees("street","5 Buswell st. Apt. 6").length
  end

  def test_can_it_find_attendees_by_phone
    attendees = Attendees.new("event_attendees.csv")

    assert_equal 1, attendees.search_attendees("phone","571.232.8000").length
  end

end
