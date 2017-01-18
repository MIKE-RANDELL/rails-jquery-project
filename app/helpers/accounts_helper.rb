module AccountsHelper
  def current_balance(balance)
    sprintf("%.2f", balance.truncate(2))
  end

  def order_total(order)
    total = 0
    tax = 1.06
    pallet_price = 6.00
    order.order_items.each do |order_item|
      if order_item.pallet_count > 0
        total += ((order_item.quantity * order_item.item.price) * tax) + (order_item.pallet_count * pallet_price)
      else
        total += (order_item.quantity * order_item.item.price * tax)
      end
    end
    number_to_currency(total)
  end

  def pallet_total(order)
    total = 0
    order.order_items.each do |order_item|
      total += order_item.pallet_count
    end
    total
  end

  def pallet_return(account, amount)
    account.pallet_count -= amount
    account.balance -= amount * 6
    account.save
  end

  def make_payment(account, payment)
    account.balance -= payment
    account.save
  end

  def order_date(date)
    date_obj = Time.parse(date)
    date_obj.strftime('%D, %l:%M %p')
  end

  def account_details(account)
    content_tag(:h4, "Name: " + account.user.name + " | " + "Email: " + account.user.email) unless !account.user.email
  end
end
