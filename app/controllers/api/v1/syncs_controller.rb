class Api::V1::SyncsController < ApplicationController
  def index
    render json: Company.all
  end

  def create
    company = Company.create name: params[:name]
    render json: company
  end
end
