class ProducersController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    respond_with Producer.all
  end

  def show
    respond_with Producer.find(params[:id])
  end

  def create
    @producer = Producer.new(producer_params)
    # Add current user as part of production
    if @producer.save
      current_user.add_role :admin, @producer
      respond_with @producer
    end
  end

  def update
    respond_with Producer.update(params[:id], producer_params)
  end

  def destroy
    respond_with Producer.destroy(params[:id])
  end

  private

  def producer_params
    params.require(:producer).permit(:name, :email, :password)
  end
end
