module DeliveriesHelper
  def status_meaning(status)
    if status == 0
      "For Delivery"
    elsif status == 1
      "In Transit"
    elsif status == 2
      "Released"
    else
      "Uknown"
    end
  end
end
