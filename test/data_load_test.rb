require "minitest/autorun"
require "minitest/pride"
require "./lib/data_load"
require "pry"

class DataLoadTest < Minitest::Test
  include DataLoad

  def test_if_data_is_loaded
    refute nil, DataLoad::load_file
  end

end