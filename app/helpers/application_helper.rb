module ApplicationHelper


 def format_exp_date(time)
  date = time.to_date if time
   date.strftime("%b, %Y") if time 
  end
  
  
  def difference_in_months(date1, date2)
    date1 = date1.to_date if date1.present? 
    date2 = date2.to_date if date2.present?
    number_of_months = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
    months = number_of_months.to_i
    "#{pluralize(months/12, 'year')} #{pluralize(months%12, 'month')}"
    
  end

end
