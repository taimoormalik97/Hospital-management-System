module PurchaseOrderHelper
  def print_state(po)
    if po.drafted?  
      "<td><span class='rounded border border-light p-1 bg-light'>#{po.state}</span></td>".html_safe
    elsif po.confirmed?  
      "<td><span class='rounded border border-warning p-1 bg-warning'>#{po.state}</span></td>".html_safe
    elsif po.delivered? 
      "<td><span class='rounded border border-success p-1 bg-success'>#{po.state}</span></td>".html_safe 
    end
  end
end
