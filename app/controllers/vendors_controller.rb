class VendorsController < ApplicationController

  include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies
  include ActionController::ImplicitRender

  def index
    @vendors = Vendor.all.order(:created_at)
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @vendors, include: :products}
    end
  end

  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
    format.html {render :show}
    format.json {render json: @vendor, include: :products}
    end
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    respond_to do |format|

      if @vendor.save
          format.html { redirect_to @vendor, notice: "Made the Vendor" }
          format.json { render json: @vendor, status: :created, location: @vendor}
      else
        format.html {render :new }
        format.json { render json: @vendor.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update(vendor_params)

    respond_to do |format|

      if @vendor.update
          format.html { redirect_to @vendor, notice: "Edited the Vendor" }
          format.json { render json: @vendor}
      else
        format.html {render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity}
      end

    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    respond_to do |format|
      if @vendor.destroy!
        format.html { redirect_to vendors_path }
        format.json { render json: {}, status: :no_content}
      else
        format.html { redirect_to :back }
        format.json { @vendor.errors }
      end
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :city, :state, :website, :image)
  end
end
