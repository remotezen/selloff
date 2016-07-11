module ApplicationHelper
  def complete_title(title ="")
    this_title = "Sell Off Auction"
    if title.empty?
      this_title
    else
      title  + " | "  + this_title
    end
  end
  
  def form_error_for(object=nil)
    render('shared/form_errors', object: object) unless object.blank?
  end
  def maximum(obj)
    obj.maximum_bid
  end
  def minimum(obj)
    obj.minimum_bid
  end


  
  
end

