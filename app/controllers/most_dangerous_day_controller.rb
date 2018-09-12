class MostDangerousDayController < ApplicationController
  def index
    @start_date = Time.parse(most_dangerous_day_params[:start_date])
    @end_date = Time.parse(most_dangerous_day_params[:end_date])
    @presenter = Presenter.new(most_dangerous_day_params)
  end

  private

  def most_dangerous_day_params
    params.permit(:start_date, :end_date)
  end
end
