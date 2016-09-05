require "minitest/autorun"
require "minitest/pride"
require "./lib/queue"
require "pry"

class QueueTest < Minitest::Test

  def test_if_queue_is_created
    assert_equal Queue, Queue.new.class
  end

  def test_can_it_pull_all_legislators
    attendees = Queue.new

    assert_equal ["Cory Booker", "Leonard Lance", "Robert Menéndez"], attendees.get_legislators("07922")
    assert_equal ["Cory Booker", "Albio Sires", "Robert Menéndez"], attendees.get_legislators("07030")
    assert_equal ["Charles Schumer", "Charles Rangel", "Jerrold Nadler", "Kirsten Gillibrand"], attendees.get_legislators("10024")
    assert_equal ["Cory Gardner", "Diana DeGette", "Michael Bennet"], attendees.get_legislators("80218")
  end

end
