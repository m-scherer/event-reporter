require "pry"


module DataScrub

  def self.scrub_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def self.scrub_phone_number(phone_number)
    phone_number.to_s.gsub(/\D/,"").match(/^1?(\d{3})(\d{3})(\d{4})/)
    [$1,$2,$3].join("-")
  end

end
