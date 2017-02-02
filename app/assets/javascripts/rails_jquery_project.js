$(function() {
  getAllOrders();
  newNoteForm();
});

var getAllOrders = function () {
  $(".js-orders").on('click', function() {
    $.getJSON("/books/orders", function(data) {
      //createOrderObjects(data);
      showOrders(data);
    });
  });
};

var createOrderObjects = function(orders) {
  orders.forEach(function(order) {
    debugger;
    var jsOrderObj = new Order(order.date, order.account_id, order.items, order.order_items)
  });
};

function Order(date, account_id, items, order_items) {
  this.date = date
  this.account_id = account_id
  this.items = items
  this.order_items = order_items
};

Order.prototype.formatOrder = function() {
  var itemHTML = `<b>${this.date}</b> --- ` + `<b>Account ID: ${this.account_id}</b><br>`
  for (i = 0; i < this.order_items.length; i++) {
    itemHTML += '<li>' + `${this.items[i].item_type}: ` + `${this.order_items[i].quantity}` + '</li>'
  }
  return itemHTML
};

var showOrders = function(data) {
  var dom = ""
  $.each(data, function(index, order) {
    dom += showOrdersHtml(order) + '<br><br>'
  });
  $("#orders").html(dom);
};

var showOrdersHtml = function(order) {
  var itemHTML = `<b>${order.date}</b> --- ` + `<b>Account ID: ${order.account_id}</b><br>`
  for (i = 0; i < order.order_items.length; i++) {
    itemHTML += '<li>' + `${order.items[i].item_type}: ` + `${order.order_items[i].quantity}` + '</li>'
  }
  return itemHTML
};

var newNoteForm = function() {
  $('.js-new-note').on('submit', function(event) {
    event.preventDefault();

    var values = $(this).serialize();

    var noting = $.post('/notes', values);

    noting.done(function(data) {
      debugger;
      $('#show_note').html(`${data.content}`)
    });
  });
};
