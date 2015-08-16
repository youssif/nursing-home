class Home < ActiveRecord::Base

  def self.get_raw_nursing_home_data(zipcode, distance)
    require 'net/https'
    require 'json'
    distance = (distance*1609.34).to_s
    long_lat = Home.get_long_lat(zipcode.to_s)
    latitude = long_lat["lat"].to_s
    puts latitude
    longitude = long_lat["lng"].to_s 
    puts longitude
    uri = URI('https://data.medicare.gov/resource/b27b-2uc7.json?$where=within_circle(location, '+latitude+','+longitude+' , '+distance+')')
    puts uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field('X-App-Token', 'J5vS82ZpagkHTJQQwObzLiyhm')

    response = http.request(request)
   
    return JSON.parse(response.body)
    # Example folded in file below:
    # example of one value this returns:
      # {"adjusted_cna_staffing_hours_per_resident_per_day"=>"2.42296", "adjusted_lpn_staffing_hours_per_resident_per_day"=>"0.93942", "adjusted_rn_staffing_hours_per_resident_per_day"=>"0.74139", "adjusted_total_nurse_staffing_hours_per_resident_per_day"=>"4.0721", "automatic_sprinkler_systems_in_all_required_areas"=>"Yes", "continuing_care_retirement_community"=>false, "cycle_1_health_deficiency_score"=>"80", "cycle_1_health_revisit_score"=>"0", "cycle_1_number_of_complaint_health_deficiencies"=>"2", "cycle_1_number_of_health_revisits"=>"1", "cycle_1_number_of_standard_health_deficiencies"=>"12", "cycle_1_standard_survey_health_date"=>"2014-02-28T00:00:00.000", "cycle_1_total_health_score"=>"80", "cycle_1_total_number_of_health_deficiencies"=>"12", "cycle_2_health_deficiency_score"=>"72", "cycle_2_health_revisit_score"=>"0", "cycle_2_number_of_complaint_health_deficiencies"=>"0", "cycle_2_number_of_health_revisits"=>"1", "cycle_2_number_of_standard_health_deficiencies"=>"11", "cycle_2_standard_health_survey_date"=>"2013-02-01T00:00:00.000", "cycle_2_total_health_score"=>"72", "cycle_2_total_number_of_health_deficiencies"=>"11", "cycle_3_health_deficiency_score"=>"116", "cycle_3_health_revisit_score"=>"0", "cycle_3_number_of_complaint_health_deficiencies"=>"0", "cycle_3_number_of_health_revisits"=>"1", "cycle_3_number_of_standard_health_deficiencies"=>"14", "cycle_3_standard_health_survey_date"=>"2011-10-07T00:00:00.000", "cycle_3_total_health_score"=>"116", "cycle_3_total_number_of_health_deficiencies"=>"14", "date_first_approved_to_provide_medicare_and_medicaid_services"=>"1972-09-01T00:00:00.000", "expected_cna_staffing_hours_per_resident_per_day"=>"2.33838", "expected_lpn_staffing_hours_per_resident_per_day"=>"0.57496", "expected_rn_staffing_hours_per_resident_per_day"=>"0.9292", "expected_total_nurse_staffing_hours_per_resident_per_day"=>"3.84254", "federal_provider_number"=>"135021", "health_inspection_rating"=>"2", "legal_business_name"=>"KINDRED NURSING CENTERS WEST LLC", "location"=>{"type"=>"Point", "coordinates"=>[-116.99143, 46.382759]}, "location_address"=>"3315 8TH STREET", "location_city"=>"LEWISTON", "location_state"=>"ID", "location_zip"=>"83501", "number_of_certified_beds"=>"96", "number_of_facility_reported_incidents"=>"0", "number_of_fines"=>"1", "number_of_payment_denials"=>"0", "number_of_residents_in_certified_beds"=>"66", "number_of_substantiated_complaints"=>"2", "overall_rating"=>"4", "ownership_type"=>"For profit - Corporation", "processing_date"=>"2015-07-01T00:00:00.000", "provider_address"=>"3315 8TH STREET", "provider_changed_ownership_in_last_12_months"=>false, "provider_city"=>"LEWISTON", "provider_county_name"=>"Nez Perce", "provider_name"=>"KINDRED TRANSITIONAL CARE & REHAB - LEWISTON", "provider_phone_number"=>"2087439543", "provider_resides_in_hospital"=>false, "provider_ssa_county"=>"340", "provider_state"=>"ID", "provider_type"=>"Medicare and Medicaid", "provider_zip_code"=>"83501", "qm_rating"=>"5", "reported_cna_staffing_hours_per_resident_per_day"=>"2.30909", "reported_licensed_staffing_hours_per_resident_per_day"=>"1.57273", "reported_lpn_staffing_hours_per_resident_per_day"=>"0.65076", "reported_physical_therapist_staffing_hours_per_resident_per_day"=>"0.07576", "reported_rn_staffing_hours_per_resident_per_day"=>"0.92197", "reported_total_nurse_staffing_hours_per_resident_per_day"=>"3.88182", "rn_staffing_rating"=>"5", "special_focus_facility"=>false, "staffing_rating"=>"4", "total_amount_of_fines_in_dollars"=>"7735", "total_number_of_penalties"=>"1", "total_weighted_health_survey_score"=>"83.333", "with_a_resident_and_family_council"=>"Resident"}
  end

  def self.get_long_lat(zipcode)
    require 'net/https'
    uri = URI("http://maps.googleapis.com/maps/api/geocode/json?address="+ zipcode)
    request = Net::HTTP::Get.new(uri.request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(request)
    response = JSON.parse(response.body)
    # puts response
    latitude = response["results"][0]["geometry"]["bounds"]["northeast"]['lat']
    longitude = latitude = response["results"][0]["geometry"]["bounds"]["northeast"]['lng']
    puts latitude.to_s
    puts longitude.to_s

  end

end
