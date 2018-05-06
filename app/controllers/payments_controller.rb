class PaymentsController < ApplicationController

  def daily_report
  end

  def cargo_collect_report
    @date = params[:date]
  end

  def cargo_transaction_report
    @date = params[:date]
  end

end
