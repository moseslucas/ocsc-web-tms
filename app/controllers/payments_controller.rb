class PaymentsController < ApplicationController

  def daily_report
  end

  def cargo_collect_report
    @date = params[:date]
		# @result = daily_transaction @date, "collect"
    @result = Document.includes(
      :client,
      :document_details,
      :payments
    ).from_exact_branch(session[:branch])
    .not_cancelled
    .where(documents: {trans_date: @date})
    @result = @result.where(payments: {payment_type: nil})
    .or(@result.where(payments: {payment_type: "collect"}))
  end

  def cargo_transaction_report
    @date = params[:date]
    format_daily_report
  end

  private

	def daily_transaction(date, payment_type)
		@date = date
		if payment_type == "collect"
			query = "documents.id as doc_id, 
      documents.ref_id as cwb, 
      clients.name as client_name, 
      shipper, 
      total_amount as amount"
			#this condition set when there is no payment type, only cargo waybill query continues and return result
			# but when if it is not null (false) payment_type must be equals to collect s
			payment_type_condition = "payment_type IS NULL or payment_type = 'collect'"
			result = Document.select(query).
        joins(:client, :document_details).
        left_joins(:payments).
        where(documents:{trans_date: date}).
        where(payment_type_condition).
        where.not(status1: 0).
        group("documents.id")

		elsif payment_type == "all"
			query = "documents.id as doc_id, 
      documents.ref_id as cwb, 
      clients.name as client_name, 
      shipper, 
      SUM(payments.amount) as amount, 
      payment_type, 
      SUM(qty) as qty"
			result = Document.select(query).
        joins(:client, :payments, :document_details).
        where(documents:{ doc_type: 'rec', trans_date: date }).
        where.not(documents: {status1: 0}).
        group("payments.id")

			#start to pass var result to var x as array of hashes
			# will convert active record result to json then store to array x as hashes
			i=0	#declare index counter as 0
			x = [] #declre x as array
			#start loop
			while i < result.length do
				x.push result[i].as_json #insert result as hash into x[index of i]
				#store array of tags in hash of index of array x
				x[i]['tags'] = get_tags_array x[i]['doc_id']
				i+=1
			end
			result = x
		end
		return result
	end

  def format_daily_report
    @report_totals = {collect: 0, cash: 0, remittance: 0, total: 0, qty: 0}
    @report = @waybills.map do |waybill|
      payment_mode = payment_mode waybill.id
      if waybill.status1 === 0
        amount = 0.00
        cash = 0.00
        collect = 0.00
        qty = 0
      else
        amount = waybill.total_amount
        cash = (payment_mode === "cash" ? amount : 0.00)
        collect = (payment_mode === "collect" ? amount : 0.00)
        qty = waybill.document_details.sum(:qty)
      end
      {
        cwb: "#{prefix_waybill}#{remove_cwb_waybill_batch_prefix waybill.ref_id}",
        tags: format_document_tags(waybill.document_tags.ids),
        qty: qty,
        cash: cash,
        collect: collect,
        total: amount,
        remittance: cash,
        deleted: waybill.status1 === 0
      }
    end
  end

end
