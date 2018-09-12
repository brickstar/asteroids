class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :id, :neo_reference_id, :user_id, :asteroid

  def asteroid
    thing = JSON.parse(Faraday.get("https://api.nasa.gov/neo/rest/v1/neo/#{object.neo_reference_id}?api_key=#{ENV['NASA_API_KEY']}").body, symbolize_names: true)
    {
      "name": thing[:name],
      "is_potentially_hazardous_asteroid": thing[:is_potentially_hazardous_asteroid]
    }
  end
end
