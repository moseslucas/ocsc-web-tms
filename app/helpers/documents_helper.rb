module DocumentsHelper
  def status1_meaning(status)
    if status == 0
      "CANCELLED"
    elsif status == 1
      "OPEN"
    elsif status == 2
      "CLOSED"
    else
      "Uknown"
    end
  end

  def status2_meaning(status)
    if status == 0
      "CANCELLED"
    elsif status == 1
      "FOR DELIVERY"
    elsif status == 2
      "IN TRANSIT"
    elsif status == 3
      "RELEASED"
    else
      "UNKNOWN"
    end
  end
end
