class DeliveriesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper

  def index 
    deliveries_scope = Document.from_branch(session[:branch]).includes(
      :source,
      :destination,
      :vehicles,
      :employees
    ).delivery.not_cancelled
    deliveries_scope = deliveries_scope.search(params[:filter]) if params[:filter]
    @deliveries = smart_listing_create(
      :deliveries,
      deliveries_scope,
      partial: "deliveries/list",
      default_sort: {updated_at: "desc"}
    )
  end

  def show
    @doc = Document.find_by id: params[:id]
  end

  private

end
