require "minitest/autorun"
require "minitest/pride"
require "./lib/data_load"
require "pry"

class DataLoadTest < Minitest::Test

  def test_if_data_instance_is_created

    assert_equal DataLoad, DataLoad.new.class
  end

  def test_test_if_file_has_loaded

    refute nil, DataLoad.new.load_file
  end
end
