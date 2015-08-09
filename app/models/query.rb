class Query < ActiveRecord::Base
  validates :zipcode, zipcode: { country_code: :us}
  def self.check_zipcode(zipcode)
    validates :zipcode, zipcode: { country_code: :us}
  end

end
