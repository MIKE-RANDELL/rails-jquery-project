$(function() {
  getAllOrders();
  newNoteForm();
});

var getAllOrders = function () {
  $(".js-orders").on('click', function() {
    $.getJSON("/books/orders", function(data) {
      var orderObjects = createOrderObjects(data);
      appendOrderObjects(orderObjects);
    });
  });
};

var createOrderObjects = function(orders) {
  var jsOrderObjs = [];
  orders.forEach(function(order) {
    var jsOrderObj = new Order(order.date, order.account_id, order.items, order.order_items);
    jsOrderObjs.push(jsOrderObj);
  });
  return jsOrderObjs;
};

var appendOrderObjects = function(orders) {
  orders.forEach(function(order) {
    $('#orders').append(order.formatOrder())
  });
};

var formatDate = function(date) {
  var date = new Date(date);
  var month = date.getMonth() + 1;
  var day = date.getDate();
  var year = date.getFullYear();
  return `${month}/` + `${day}/` + `${year}`
}

class Order {
  constructor(date, account_id, items, order_items){
    this.date = formatDate(date)
    this.account_id = account_id
    this.items = items
    this.order_items = order_items
  }

  formatOrder() {
    var itemHTML = `<b>${this.date}</b> --- ` + `<a href='/api/account/${this.account_id}'>ACCOUNT</a><br>`//`<b>Account ID: ${this.account_id}</b><br>`
    for (var i = 0; i < this.order_items.length; i++) {
      itemHTML += '<li>' + `${this.items[i].item_type}: ` + `${this.order_items[i].quantity}` + '</li>'
    }
    return itemHTML
  }
}

var showOrders = function(data) {
  var dom = ""
  $.each(data, function(index, order) {
    dom += showOrdersHtml(order) + '<br><br>'
  });
  $("#orders").html(dom);
};

var showOrdersHtml = function(order) {
  var itemHTML = `<b>${order.date}</b> --- ` + `<a href='/api/account/${order.account_id}'>ACCOUNT</a><br>`
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
      $('#show_note').html(`${data.content}`)
    });
  });
};
