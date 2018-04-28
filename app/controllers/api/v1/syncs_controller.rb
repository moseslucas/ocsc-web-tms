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
    # byebug
    @params = @params.to_h
    for i in 0...@params[:sync_in].count
      sync_in = @params[:sync_in]["#{i}"]
      model = sync_in[:model_name].constantize

      for j in 0...sync_in[:records].count
        record = sync_in[:records]["#{j}"]
        if new_record?(record)
          unless model.find_by(id: record[:id])
            model_param = {}
            record.keys.each do |key|
              model_param[key] = record["#{key}"]
            end
            model_param[:branch] = [@params[:branch]] unless !@params[:branch]
            model_param[:id_from_branch] = [record[:id]]
            model.create model_param
          end
        else
        end
      end
    end
    render json: {status: "OK"}
  end

  private
  def set_params
    @params = params.require(:sync).permit!
  end

  def new_record?(record)
    record[:created_at] === record[:updated_at]
  end

  def all_models
    files = Dir[Rails.root + 'app/models/*.rb']
    files.map{ |m| File.basename(m, '.rb').camelize }
  end
end
