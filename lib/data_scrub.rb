require "pry"

module DataScrub

  def self.scrub_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def self.scrub_phone_number(phone_number)
    phone_number.to_s.gsub(/\D/,"").match(/^1?(\d{3})(\d{3})(\d{4})/)
    [$1,$2,$3].join("-")
  end

  def self.scrub_word(name)
    if name == nil
      return nil
    else
      name_strip = name.lstrip.rstrip.downcase
    end
  end

    def self.capitalize_name(name)
      name_split = name.split(" ")
      name_cap = name_split.map do |name|
        name.capitalize
      end
      name_cap.join(" ")
    end

end
