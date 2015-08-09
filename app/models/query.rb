class Query < ActiveRecord::Base
  
  def self.check_zipcode(zipcode)
    validates :zipcode, zipcode: { country_code: :us}
  end

end
