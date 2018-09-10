class NasaService
  def initialize(start_date, end_date)
    @start_date = Date.parse(start_date).strftime('%Y-%m-%d')
    @end_date = Date.parse(end_date).strftime('%Y-%m-%d')
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

  private

  def raw_asteroids
    JSON.parse(Faraday.get("https://api.nasa.gov/neo/rest/v1/feed?start_date=#{@start_date}&end_date=#{@end_date}&api_key=ya69uKDgbWyLDEnkMc8AIHVznubkXl1YI2IvYhXF").body, symbolize_names: true)[:near_earth_objects]
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
