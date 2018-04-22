class DiscountsController < ApplicationController
  before_action :get_record, only: [:index]
  before_action :set_params, only: [:create]
  before_action :find_record, only: [:delete, :update]

  def index
  end

  def create
     Discount.create @params
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
    @params = params[:discount]
  end

  def find_record
    @discount = Discount.find params[:id]
  end
end
