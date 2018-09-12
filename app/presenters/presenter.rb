class Presenter
  attr_reader :start_date, :end_date
  def initialize(dates)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    @service = NasaService.new(@start_date, @end_date)
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

  def find_all_days_with_dangerous_asteroids
    @service.raw_asteroids.map do |key|
      key if key[1][0][:is_potentially_hazardous_asteroid]
    end.compact
  end

  def find_most_dangerous_day
    find_all_days_with_dangerous_asteroids.max_by do |day|
      day.count
    end
  end
end
