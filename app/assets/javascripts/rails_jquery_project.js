$(function() {
  newNoteForm();
  setEventListeners();
});

var setEventListeners = function () {
  $(".js-orders").on('click', function() {
    getOrdersApi();
  });

  $('.js-next-note-button').on('click', function(e) {
    e.preventDefault();
    nextNoteApi();
  });

  $('.js-previous-note-button').on('click', function(e) { //HERE
    e.preventDefault()
    previousNoteApi();
  });
};

var previousNoteApi = function() {
  var noteId = $('.js-current-note').data('note-id')
  var accountId = $('.js-current-note').data('account-id')
  getPreviousNote(accountId, noteId);
}

var nextNoteApi = function() {
  var noteId = $('.js-current-note').data('note-id')
  var accountId = $('.js-current-note').data('account-id')
  getNextNote(accountId, noteId);
}


var getOrdersApi = function() {
  $.getJSON("/books/orders", function(data) {
   var orderObjects = createOrderObjects(data);
   appendOrderObjects(orderObjects);
  });
}

//
// function handleResponse(response) {
//   if (response.data) {
//     var orderObjects = createOrderObjects(data);
//     appendOrderObjects(orderObjects);
//   }
//   if (response.err) {
//     // do something here
//   }
// }

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
  var day = date.getDate()
  var year = date.getFullYear()
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
    var itemHTML = `<span><b>${this.date}</b> # <b>ACCOUNT ${this.account_id}</b></span><br>`
    for (var i = 0; i < this.order_items.length; i++) {
      itemHTML += '<li>' + `${this.items[i].item_type}: ` + `${this.order_items[i].quantity}` + '</li>'
    }
    itemHTML += '<br>'
    return itemHTML
  }
}

class Note {
  constructor(id, account_id, content, date){
    this.id = id
    this.account_id = account_id
    this.content = content
    this.date = formatDate(date)
  }

  formatNote() {
    var noteHTML = `<span class='js-current-note' data-note-id='${this.id}' data-account-id='${this.account_id}'>${this.content} @ date: ${this.date}</span>`;
    return noteHTML;
  }
}

var newNoteForm = function() {
  $('.js-new-note').on('submit', function(event) {
    event.preventDefault();

    var values = $(this).serialize();
    if (!values.split("=")[4].trim()) {
      $('.show-error').html('You must enter some text..')
    } else {
      var noting = $.post('/notes', values);
      noting.done(function(data) {
        var noteObject = createNoteObject(data)
        $('#show-note').html(noteObject.formatNote())
        $('.show-error').html('')
      });
    }

  });
};



var createNoteObject = function(data) {
  var noteObj = new Note(data.id, data.account_id, data.content, data.created_at);
  return noteObj;
};

var getNextNote = function(accountId, noteId) {
  $.get(`/api/next_note/${accountId}/${noteId}`, function(data) {
    var noteObject = createNoteObject(data)
    $('.js-current-note').replaceWith(noteObject.formatNote())
  });
};

var getPreviousNote = function(accountId, noteId) {
  $.get(`/api/previous_note/${accountId}/${noteId}`, function(data) {
    var noteObject = createNoteObject(data)
    $('.js-current-note').replaceWith(noteObject.formatNote())
  });
};

//WAS MESSING WITH LINKING TO AN ACCOUNT
//ORIGINAL DOMAIN SETUP IS NOT IDEAL, SCRAPPED THIS FUNCTIONALITY

//class Account {
//  constructor(accId, userName, userEmail){
//    this.accId = accId
//    this.userName = userName
//    this.userEmail = userEmail
//  }
//
//  formatAccount() {
//    var accHTML = `name: ${this.userName}  email: ${this.userEmail}`;
//    accHTML += `<a href='/account/${this.accId}/orders'>View Account</a>`;
//    return accHTML;
//  };
//}
//
//var setAccountClickHandler = function() {
//  $(document).on('click', '.js-account', function(e) {
//    e.preventDefault();
//    const accountId = $(this).data("id");
//    $.get(`/api/account/${accountId}`, function(data) {
//      var accountObject = createAccountObject(data)
//      appendAccountObject(accountObject)
//    });
//  });
//};
//
//var createAccountObject = function(account) {
//  var jsAccountObj = new Account(account.id, account.name, account.email);
//  return jsAccountObj;
//};
//
//var appendAccountObject = function(account) {
//  $('.js-account').replaceWith(account.formatAccount())
//};

//OLD FUNCTIONALITY without use of JS OBJECTS

//var showOrders = function(data) {
//  var dom = ""
//  $.each(data, function(index, order) {
//    dom += showOrdersHtml(order) + '<br><br>'
//  });
//  $("#orders").html(dom);
//};

//var showOrdersHtml = function(order) {
//  var itemHTML = `<b>${order.date}</b> --- ` + `<a href='/api/account/${order.account_id}'>ACCOUNT</a><br>`
//  for (i = 0; i < order.order_items.length; i++) {
//    itemHTML += '<li>' + `${order.items[i].item_type}: ` + `${order.order_items[i].quantity}` + '</li>'
//  }
//  return itemHTML
//};
