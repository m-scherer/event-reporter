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
    attendees = Attendees.new
    queue.add_to_queue(attendees, "first_name","John")
    queue.add_to_queue(attendees, "first_name","Greg")

    assert_equal 4, queue.count_queue
  end

  def test_if_queue_can_add_to_the_stack
    queue = Queue.new
    attendees = Attendees.new
    queue.add_to_queue(attendees,"first_name","John")
    queue.add_to_queue(attendees,"first_name","Greg")
    queue.add_to_queue(attendees,"state","CO")

    assert_equal 29, queue.queue.length
    assert_equal "CO", queue.queue.last[:state]
  end

  def test_if_the_queue_can_be_cleared
    queue = Queue.new
    attendees = Attendees.new
    queue.add_to_queue(attendees,"state","CO")
    queue.clear_queue

    assert_equal 0, queue.count_queue
  end

  def test_can_it_sort_by_attribute
    queue = Queue.new
    attendees = Attendees.new
    queue.add_to_queue(attendees,"first_name","Greg")

    assert_equal "Ali", queue.sort_by_attribute("last_name").first[:last_name]
  end

  def test_can_it_pull_all_legislators
    legislators = Queue.new

    assert_equal ["Cory Booker", "Leonard Lance", "Robert Menéndez"], legislators.get_legislators("07922")
    assert_equal ["Cory Booker", "Albio Sires", "Robert Menéndez"], legislators.get_legislators("07030")
    assert_equal ["Charles Schumer", "Charles Rangel", "Jerrold Nadler", "Kirsten Gillibrand"], legislators.get_legislators("10024")
    assert_equal ["Cory Gardner", "Diana DeGette", "Michael Bennet"], legislators.get_legislators("80218")
  end


end
