require "./test/test_helper"
require "./lib/queue"
require "./lib/attendees"
require "pry"

class QueueTest < Minitest::Test

  def test_if_queue_is_created
    assert_equal Queue, Queue.new.class
  end

  def test_if_queue_has_a_stack
    assert_equal Array, Queue.new.queue.class
  end

  def test_if_queue_can_be_counted
    queue = Queue.new
    attendees = Attendees.new("event_attendees.csv")
    queue.add_to_queue(attendees, "first_name","John")
    queue.add_to_queue(attendees, "first_name","Greg")

    assert_equal 4, queue.count_queue
  end

  def test_if_queue_can_add_to_the_stack
    queue = Queue.new
    attendees = Attendees.new("event_attendees.csv")
    queue.add_to_queue(attendees,"first_name","John")
    queue.add_to_queue(attendees,"first_name","Greg")
    queue.add_to_queue(attendees,"state","CO")

    assert_equal 29, queue.queue.length
    assert_equal "co", queue.queue.last.state
  end

  def test_if_queue_math_adds_to_the_queue
    queue = Queue.new
    attendees = Attendees.new("event_attendees.csv")
    queue.queue_math_add(attendees,"first_name","John")
    queue.queue_math_add(attendees,"first_name","Greg")
    queue.queue_math_add(attendees,"state","CO")

    assert_equal 96, queue.queue.length
    assert_equal "co", queue.queue.last.state
  end

  def test_if_queue_math_adds_and_subtracts
    queue = Queue.new
    attendees = Attendees.new("event_attendees.csv")
    queue.queue_math_add(attendees,"first_name","John")
    queue.queue_math_add(attendees,"first_name","Greg")
    queue.queue_math_subtract(attendees,"first_name","John")

    assert_equal 4, queue.queue.length
    assert_equal "dc", queue.queue.last.state
  end

  def test_if_the_queue_can_be_cleared
    queue = Queue.new
    attendees = Attendees.new("event_attendees.csv")
    queue.add_to_queue(attendees,"state","CO")
    queue.clear_queue

    assert_equal 0, queue.count_queue
  end

  def test_can_it_sort_by_attribute
    queue = Queue.new
    attendees = Attendees.new("event_attendees.csv")
    queue.add_to_queue(attendees,"first_name","John")

    assert_equal "abdulkarim", queue.sort_by_attribute("last_name").first.last_name
    assert_equal "00000", queue.sort_by_attribute("zipcode").first.zipcode
    assert_equal "ames", queue.sort_by_attribute("city").first.city
    assert_equal "ca", queue.sort_by_attribute("state").first.state
  end

  def test_it_can_pull_district
    queue = Queue.new

    assert_equal "CO: 1", queue.get_districts("80218")
    assert_equal "NJ: 7", queue.get_districts("07922")
    assert_equal "NY: 10 / NY: 13", queue.get_districts("10024")
    assert_equal "", queue.get_districts("")
  end

end
