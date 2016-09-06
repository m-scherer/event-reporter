require "csv"
require "pry"

module FileGenerator
    def self.create_csv(filename, data)
      Dir.mkdir("output") unless Dir.exists? "output"
      CSV.open("output/"+filename, "w") do |csv|
        csv << ["id","last_name","first_name","email","zipcode","city","state","address","phone_number"]
        data.each do |record|
          csv << record.values
        end
      end
      return filename
    end
end
