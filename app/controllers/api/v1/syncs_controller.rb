class Api::V1::SyncsController < ApplicationController
  before_action :set_params, only: [:create]

  def index
    render json: {}
  end

  def get_model
    render json: params[:model_name].constantize.all
  end

  def create
    @params[:sync_in].each do |s|
      s[:records].each do |record|
        if new_record?(record)
          model_param = {}
          record.keys.each do |key|
            model_param[key] = record["#{key}"] unless key === "id"
          end
          model_param[:branch] = [@params[:branch]]
          model_param[:id_from_branch] = [record[:id]]
          s[:model_name].constantize.create model_param
        else
        end
      end
    end
    render json: {status: "OK"}
  end

  private
  def set_params
    @params = params[:sync]
  end

  def new_record?(record)
    record[:created_at] === record[:updated_at]
  end
end
