require "minitest/autorun"
require "minitest/pride"
require "./lib/queue"
require "pry"

class QueueTest < Minitest::Test

  def test_if_queue_is_created
    assert_equal Queue, Queue.new.class
  end

  def test_case_name

  end

end
