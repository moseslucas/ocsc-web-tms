class DiscountsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper
  before_action :get_record, only: [:index]
  before_action :set_params, only: [:create]
  before_action :find_record, only: [:delete, :update]

  def index
    smart_listing_create(
      :discounts,
      @discounts,
      partial: "discounts/list"
    )
  end

  def create
    @discount = Discount.new @params
    respond_to do |format|
      if @discount.save 
        format.html { redirect_to discounts_path, notice: "Discount was successfully created" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def new
    @discount = Discount.new
  end

  def destroy
  end

  def update
  end

  private

  def get_record
    @discounts = Discount.all
  end

  def set_params
    @params = params[:discount].permit(
      :name,
      :description,
      :amount,
      :discount_type
    )
  end

  def find_record
    @discount = Discount.find params[:id]
  end
end
