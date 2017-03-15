class ConsumersController < ApplicationController

  include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies
  include ActionController::ImplicitRender

  def index
    @consumers = Consumer.all.order(:created_at)
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @consumers, include: :orders}
    end
  end

  def show
    @consumer = Consumer.find(params[:id])

    respond_to do |format|
    format.html {render :show}
    format.json {render json: @consumer, include: :orders}
    end
  end

  def new
    @consumer = Consumer.new
  end

  def create
    @consumer = Consumer.new(consumer_params)
    respond_to do |format|

      if @consumer.save
          format.html { redirect_to @consumer, notice: "Made a consumer" }
          format.json { render json: @consumer, status: :created, location: @consumer}
      else
        format.html {render :new }
        format.json { render json: @consumer.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @consumer = Consumer.find(params[:id])
  end

  def update
    @consumer = Consumer.find(params[:id])
    @consumer.update(consumer_params)
    redirect_to @consumer
  end

  def destroy
    @consumer = Consumer.find(params[:id])
    @consumer.destroy
    redirect_to consumers_path
  end

  private

  def consumer_params
    params.require(:consumer).permit(:name, :city, :state)
  end
end
