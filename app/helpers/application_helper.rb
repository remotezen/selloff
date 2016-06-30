module ApplicationHelper
  def complete_title(title ="")
    this_title = "Sell Off Auction"
    if title.empty?
      this_title
    else
      title  + " | "  + this_title
    end
  end
end
