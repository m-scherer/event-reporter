require "csv"
require "pry"

class DataLoad

  def load_file(file)
    contents = CSV.open file.to_s, headers: true, header_converters: :symbol
  end

end
