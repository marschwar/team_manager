json.array!(@participations) do |participation|
  json.extract! participation, :id
  json.url participation_url(participation, format: :json)
end
