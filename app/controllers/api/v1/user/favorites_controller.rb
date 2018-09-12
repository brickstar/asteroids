class Api::V1::User::FavoritesController < ApiBaseController
  def index
    render json: current_user.favorites
  end

  def create
    current_user.favorites.create(favorite_params)
    render json: current_user.favorites.last
  end

  private
  def favorite_params
    params.permit(:neo_reference_id)
  end
end
