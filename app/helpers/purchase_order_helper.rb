module PurchaseOrderHelper
  def print_state(purchase_order)
    if purchase_order.drafted?
      "<td><span class='rounded border border-light p-1 bg-light'>#{po.state}</span></td>".html_safe
    elsif purchase_order.confirmed?
      "<td><span class='rounded border border-warning p-1 bg-warning'>#{po.state}</span></td>".html_safe
    elsif purchase_order.delivered?
      "<td><span class='rounded border border-success p-1 bg-success'>#{po.state}</span></td>".html_safe
    end
  end
  
  def state_colors(purchase_order)
    if purchase_order.drafted?
      { text: 'warning', bg: 'pending' }
    elsif purchase_order.confirmed?
      { text: 'info', bg: 'approved' }
    else
      { text: 'success', bg: 'completed' }
    end
  end
end
