class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  # GET users/
  def index
    render json: User.all
  end

  # GET users/:id
  def show
    render json: User.find_by_id(params[:id])
  end

  # PATCH users/:id
  def update
    @user = User.find(params[:id])
    return render json: 'Unauthorized', status: 401 if current_user != @user

    if @user.update(user_params)
      render json: 'The user info was successfully updated'
    else
      render json: @user.errors, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone, :date_of_birth, :last_name, :first_name, :dni)
  end
end
