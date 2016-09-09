require "./test/test_helper"
require "./lib/data_scrub"
require "pry"

class DataScrubTest < Minitest::Test

  def test_zipcode_is_string
    assert_equal String, DataScrub.scrub_zipcode(12345).class
  end

  def test_zipcode_is_5_characters
    assert_equal "01234", DataScrub.scrub_zipcode(1234)
    assert_equal "12345", DataScrub.scrub_zipcode(12345)
    assert_equal "12345", DataScrub.scrub_zipcode(123456)
    assert_equal "00000", DataScrub.scrub_zipcode("")
  end

  def test_phone_number_is_string
    assert_equal String, DataScrub.scrub_phone_number(1234567891).class
  end

  def test_phone_numbers_consistent
    assert_equal "123-456-7891", DataScrub.scrub_phone_number(1234567891)
    assert_equal "123-456-7891", DataScrub.scrub_phone_number("123 456 7891")
    assert_equal "123-456-7891", DataScrub.scrub_phone_number("(123)456-7891")
  end

  def test_names_use_capitalize_method
    assert_equal "Test", DataScrub.capitalize_name("TEST")
    assert_equal "Test", DataScrub.capitalize_name("test")
    assert_equal "Test", DataScrub.capitalize_name("Test")
    assert_equal "Test", DataScrub.capitalize_name("tESt")
  end

  def test_names_strips_leading_and_trailing_spaces
    assert_equal "John", DataScrub.capitalize_name(DataScrub.scrub_word(" john"))
    assert_equal "John", DataScrub.capitalize_name(DataScrub.scrub_word("john "))
    assert_equal "John Paul", DataScrub.capitalize_name(DataScrub.scrub_word("john paul"))
    assert_equal "John", DataScrub.capitalize_name(DataScrub.scrub_word(" john "))
    assert_equal "John Paul", DataScrub.capitalize_name(DataScrub.scrub_word(" john paul "))
  end


end
