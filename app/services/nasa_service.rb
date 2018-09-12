class NasaService
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def most_dangerous_day
    return 'no dangerous asteroids' if find_most_dangerous_day.nil?
    Time.parse(find_most_dangerous_day[0].to_s)
  end

  def asteroids
    return 'no dangerous asteroids' if find_most_dangerous_day.nil?
    find_most_dangerous_day[1].map do |asteroid|
      Asteroid.new(name = asteroid[:name], neo_id = asteroid[:neo_reference_id])
    end
  end

  def raw_asteroids
    JSON.parse(response.body, symbolize_names: true)[:near_earth_objects]
  end
  
  private

  def response
    conn.get("feed?start_date=#{@start_date}&end_date=#{@end_date}&api_key=#{ENV['NASA_API_KEY']}")
  end

  def conn
    Faraday.new("https://api.nasa.gov/neo/rest/v1/") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def find_all_days_with_dangerous_asteroids
    raw_asteroids.map do |key|
      key if key[1][0][:is_potentially_hazardous_asteroid]
    end.compact
  end

  def find_most_dangerous_day
    find_all_days_with_dangerous_asteroids.max_by do |day|
      day.count
    end
  end
end
