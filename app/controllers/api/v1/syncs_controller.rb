class Api::V1::SyncsController < ApplicationController
  before_action :set_params, only: [:create]

  def index
    if all_models.include? params[:model_name]
      render json: params[:model_name].constantize.all
    else
      render json: {error: "Model does not exist"}
    end
  end

  def create
    @params[:sync_in].each do |s|
      s[:records].each do |record|
        if new_record?(record)
          model_param = {}
          record.keys.each do |key|
            model_param[key] = record["#{key}"]
          end
          model_param[:branch] = [@params[:branch]] unless !@params[:branch]
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

  def all_models
    files = Dir[Rails.root + 'app/models/*.rb']
    files.map{ |m| File.basename(m, '.rb').camelize }
  end
end
