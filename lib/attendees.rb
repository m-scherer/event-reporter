require "pry"
require_relative "data_load"

class Attendees
  attr_reader :data
  include DataLoad

  def initialize
    @data = DataLoad::load_file
  end

end
