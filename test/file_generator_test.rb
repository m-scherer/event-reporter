require "minitest/autorun"
require "minitest/pride"
require "./lib/file_generator"
require "./lib/queue"
require "pry"

class FileGeneratorTest < Minitest::Test
  include FileGenerator

  def test_if_data_is_loaded
    queue = Queue.new
    queue.add_to_queue("state","CO")


    assert_equal "test.csv", FileGenerator::create_csv("test.csv", queue.queue)
  end

end
