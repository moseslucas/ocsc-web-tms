class DiscountsController < ApplicationController
  before_action :get_record, only: [:index]
  before_action :set_params, only: [:create]
  before_action :find_record, only: [:delete, :update]

  def index
    render json: @discounts
  end

  def create
    discount = Discount.create @params
  end

  def destroy
    @discount.status = 0
    if @discount.save
      return json: {status: "OK", record: @discount}
    end
  end

  def update
  end

  private

  def get_record
    @discounts = Discount.all
  end

  def set_params
    @params = params[:discount]
  end

  def find_record
    @discount = Discount.find params[:id]
  end
end
