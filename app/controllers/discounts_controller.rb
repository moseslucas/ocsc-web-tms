class DiscountsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper
  before_action :set_params, only: [:create]
  before_action :find_record, only: [:update]

  def index
    discount_scope = Discount.active
    discount_scope = discount_scope.search(params[:filter]) if params[:filter]
    @discount = smart_listing_create(
      :discounts,
      discount_scope,
      partial: "discounts/list",
      default_sort: {name: "asc"}
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
    @discount = Discount.find params[:id]
    @discount.update_attribute :status, 0
  end

  def update
  end

  private

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
