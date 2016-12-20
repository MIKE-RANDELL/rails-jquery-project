# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "michael@gmail.com" name: "Michael", password: "sherlock", password_confirmation: "sherlock")

account = Account.create(user_id: user.id)

order = Order.create(account_id: account.id)

item = Item.create(item_type: "Floratam Pallet", with_pallet: true, price: 135)

order_item = OrderItem.create(order_id: order.id, item_id: item.id, quantity: 1, pallet_count: 1) #pallet count manually for now
