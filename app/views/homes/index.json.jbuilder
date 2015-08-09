json.array!(@homes) do |home|
  json.extract! home, :id, :zipcode
  json.url home_url(home, format: :json)
end
