class TicketTypesController < ApplicationController
  def index
    @ticket_types = Event.find(params[:event_id]).ticket_types
    render json: @ticket_types
  end

  def destroy; end

  def create
    @ticket_types = Event.find(params[:event_id]).ticket_types.create(ticket_type_params[:types])
    render json: @ticket_types
  end

  def update; end

  private

  def ticket_type_params
    params.permit(types: %i[title description price quantity])
  end
end
