module AccountsHelper
  def grand_total(orders)
    total = 0
    tax = 1.06
    orders.each do |order|
      order.order_items.each do |order_item|
        total += order_item.item.price * order_item.quantity
      end
    end
    number_to_currency(total * tax)
  end

  def order_total(order)
    total = 0
    tax = 1.06
    order.order_items.each do |order_item|
      total += order_item.quantity * order_item.item.price
    end
    number_to_currency(total * tax)
  end

  def order_date(date)
    date_obj = Time.parse(date)
    date_obj.strftime('%D, %l:%M %p')
  end

  def pallet_total(order)
    total = 0
    order.order_items.each do |order_item|
      total += order_item.pallet_count
    end
    total
  end

  def grand_pallet_total(orders)
    total = 0
    orders.each do |order|
      order.order_items.each do |order_item|
        total += order_item.pallet_count
      end
    end
    total
  end
end
