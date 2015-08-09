json.array!(@queries) do |query|
  json.extract! query, :id, :zipcode
  json.url query_url(query, format: :json)
end
