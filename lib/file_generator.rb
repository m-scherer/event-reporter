require "csv"
require "pry"
require "erb"

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

    def self.create_html(filename, data)
      template_letter = File.read "form_file.erb"
      erb_template = ERB.new template_letter
      form_letter = erb_template.result(binding)
      create_html_file(filename, form_letter)
      return filename
    end

    def self.create_html_file(filename, form_letter)
      Dir.mkdir("output") unless Dir.exists? "output"
      filename = "output/queue.html"
      File.open(filename, "w") do |file|
        file.puts form_letter
      end
    end
end
