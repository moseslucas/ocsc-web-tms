module DeliveriesHelper
  def status_meaning(status)
    if status == 1
      "For Delivery"
    elsif status == 2
      "In Transit"
    elsif status == 3
      "Released"
    else
      "Uknown"
    end
  end
end
