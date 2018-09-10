class MostDangerousDayController < ApplicationController
  def index
    @start_date = Time.parse(most_dangerous_day_params[:start_date])
    @end_date = Time.parse(most_dangerous_day_params[:end_date])
    @service = NasaService.new(most_dangerous_day_params[:start_date], most_dangerous_day_params[:end_date])
    @most_dangerous_day = @service.most_dangerous_day
    @asteroids = @service.asteroids
  end

  def most_dangerous_day_params
    params.permit(:start_date, :end_date)
  end
end
