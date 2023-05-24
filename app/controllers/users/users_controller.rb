class Users::UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[me tickets]

  def index
    respond_with User.all
  end

  def show
    respond_with User.find(params[:id])
  end

  def me
    respond_with current_user
  end

  def tickets
    render json: current_user
      .tickets
      .select('COUNT(*) as purchased_tickets, user_id, event_id')
      .group(:user_id, :event_id)
      .to_json(
        include: [event: { only: %i[title id background_image start_time] }],
        except: %i[user_id event_id id]
      )
  end
end
