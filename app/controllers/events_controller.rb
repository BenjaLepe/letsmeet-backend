class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    events = Event.all
    render json: events
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new({ **event_params, author_id: current_user.id })
    if @event.save
      render json: @event
    else
      render json: { message: @event.errors }, status: :bad_request
    end
  end

  def update
    if is_author && @event.update(event_params)
      render json: @event
    else
      render json: { message: @event.errors }, status: :bad_request
    end
  end

  def destroy
    @event.destroy
    render json: 'Successfuly deleted'
  end

  private
  def is_author
    current_user.id == @event.author_id
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :price)
  end
end
