$(function() {
  getAllOrders();
  newNoteForm();
  ajaxKaminari();
});

var getAllOrders = function () {
  $(".js-orders").on('click', function() {
    $.getJSON("/books/orders", function(data) {
      showOrders(data);
    });
  });
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

    });
  });
};
var ajaxKaminari = function() {
  $('#notes').html('<%= escape_javascript render(@notes) %>');
  $('#paginator').html('<%= escape_javascript(paginate(@notes, :remote => true).to_s) %>');
};
