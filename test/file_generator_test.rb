require "./test/test_helper"
require "./lib/file_generator"
require "./lib/attendees"
require "./lib/queue"
require "pry"

class FileGeneratorTest < Minitest::Test
  include FileGenerator

  def test_if_data_is_passed_to_csv
    queue = Queue.new
    attendees = Attendees.new
    queue.add_to_queue(attendees,"state","CO")
    assert_equal "test.csv", FileGenerator::create_csv("test.csv", queue.queue)
  end

  def test_if_data_is_passed_to_html
    queue = Queue.new
    attendees = Attendees.new
    queue.add_to_queue(attendees,"first_name","John")
    assert_equal "test.html", FileGenerator::create_html("test.html", queue.queue)
  end

end
