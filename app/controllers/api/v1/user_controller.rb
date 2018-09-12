class Api::V1::UserController < ApiBaseController
  def show
    render json: current_user
  end
end
