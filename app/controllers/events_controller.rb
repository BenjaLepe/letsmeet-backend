class EventsController < ApplicationController
  include Orderable
  include ParametersHelper
  include Pagy::Backend

  before_action :require_producer, only: %i[update destroy]
  before_action :authenticate_user!, only: %i[create buy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  has_scope :search
  has_scope :by_producer
  has_scope :by_state
  has_scope :by_author
  has_scope :by_category
  has_scope :by_date
  has_scope :by_date_range
  has_scope :order_by_start_date

  def index
    @events = apply_scopes(Event)
              .includes(:producer)
              .order(ordering_params(params))
              .all
    @pagy, @records = pagy(@events, items: params[:page_size], page: params[:page])
    render json: { data: @records, pagination: @pagy },
           include: [producer: { only: %i[name id] }, ticket_types: { only: %i[title id price quantity] }]
  end

  def show
    render json: Event.find(params[:id]),
           include: [producer: { only: %i[name id] }, ticket_types: { only: %i[title id price quantity] }]
  end

  def buy
    Event.transaction do
      Ticket.transaction do
        @event = Event.find(params[:id])
        if @event.tickets_number.positive?
          @event.tickets_number -= 1
          @event.save
        else
          render json: { error: 'No tickets available' }, status: :unprocessable_entity
          return
        end
        @ticket = Ticket.new(ticket_params)
        @ticket.event = @event
        @ticket.user = current_user
        @ticket.save
      end
    end
    render json: @ticket.to_json(
      include: [event: { only: %i[title id background_image start_time] }],
      except: %i[user_id event_id id]
    )
  end

  def tickets
    @event = Event.find(params[:id])
    @tickets = @event.tickets
    @pagy, @records = pagy(@tickets.all, items: params[:page_size], page: params[:page])
    render json: { data: @records, pagination: @pagy }
  end

  def create
    @event = Event.new(event_params)
    @producer = Producer.find(params[:producer_id])
    if current_user.has_role? :admin, @producer
      @event.author = current_user
      if @event.save
        @event.ticket_types.create(ticket_type_params[:ticket_types])
        render json: @event, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    render json: @event
  end

  def destroy
    respond_with Event.destroy(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :start_time,
      :end_time,
      :background_image,
      :producer_id,
      :author_id,
      :tickets_number
    )
  end

  def ticket_type_params
    params.require(:event).permit(ticket_types: %i[title description price quantity])
  end

  def ticket_params
    serialized_params = params.permit(
      :quantity,
      :type
    )
    return if parametros_presentes?(serialized_params, %i[quantity type])

    raise ActionController::ParameterMissing, 'Missing parameters'
  end

  def require_producer
    @event = Event.find(params[:id])
    return if current_user.has_role? :admin, @event.producer

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
