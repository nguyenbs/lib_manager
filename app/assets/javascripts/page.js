$( document ).on('turbolinks:load', function() {
  var add_item_to_cart = function(data){
    return html_content = '<li class="clearfix item-content"><img src='+ data.image.url +' /><div class="item-info"><div class="name"><a href="items/'+ data.id+'">'+ data.name +'</a></div></div><a class="remove" onClick="remove_item(event)" data-item_id="'+data.id+'"><i class="fa fa-trash-o" /></a></li>';
  }

  var table_item = function(data) {
    return '<tr class="cart_item item-'+data.id+'"><td data-title="Product" class="product-name" data-th="Title"><span class="bt-content"><span class="product-thumbnail col-xs-8" style="display: inline-block"><a href="/book/'+ data.id +'"><img src="'+ data.image.url +'" alt="cart-product-1" style="width: 300px"></a></span><span class="product-detail" style="display: inline-block"><a href="/book/'+ data.id +'"><strong>    '+ data.name +'</strong></a><span><strong>Description:</strong>    '+ data.description +'</span><span><strong>Lenguage:</strong>   '+ data.lenguage +'</span><span><strong>Amount:</strong>   '+data.amount+'</span><span><strong>Publish Year:</strong>  '+data.publish_year+'</span></span></span></td><td data-title="cbox" class="product-cbox" data-th=" "><span class="bt-content"><span><input type="checkbox" class="item-checkbox" value="'+data.id+'" checked></span></span></td></tr>';
  }

  window.add_item = function(event){
    var data = $(event.target.closest('.icon')).data('item');
    var list_item = localStorage.getItem("list_item")
    if (list_item === null) {
      list_item = [];
      list_item.push(data);
    }else {
      list_item = JSON.parse(list_item);
      list_item.push(data);
    }
    localStorage.setItem("list_item", JSON.stringify(list_item))
    $('#list-cart').append(add_item_to_cart(data));
    var number_item = parseInt($('#number-item').data('number')) + 1;
    $('#number-item').text(number_item);
    alert('You have added an item to cart');
  };

  window.remove_item = function(event) {
    var item_id = $(event.target.closest('.remove')).data('item_id');
    var list_item = JSON.parse(localStorage.getItem("list_item"));
    if(list_item.length === 1) {
      localStorage.removeItem("list_item")
      var list_item = remove_item_on_array(list_item, item_id);
    } else {
      var list_item = remove_item_on_array(list_item, item_id);
      localStorage.setItem("list_item", JSON.stringify(list_item));
    }
    var number_item = parseInt($('#number-item').data('number')) - 1;
    $('#number-item').text(number_item);
    $(event.target.closest('.item-content')).remove();
  }

  var remove_item_on_array = function(items, item_id) {
    for(var i =0; i <= items.length; i++){
      if(items[i] != null) {
        if(items[i].id === item_id){
          items.splice(i, 1)
        }
      }
    }
    return items
  }

  var getItemChecked = function() {
    var checkboxes = $('.item-checkbox');
    var checkboxesChecked = [];
    for (var i=0; i<checkboxes.length; i++) {
      if (checkboxes[i].checked) {
         checkboxesChecked.push(parseInt(checkboxes[i].value));
      }
    }
    return checkboxesChecked.length > 0 ? checkboxesChecked : null;
  }
  var items = JSON.parse(localStorage.getItem("list_item"));
  if(items != null) {
    var is_admin = $('#table-data-item').data('user_admin')
    for(var i =0; i <= items.length-1; i++){
      if(items[i] != null && !is_admin) {
        $('#list-cart').append(add_item_to_cart(items[i]));
        $('#table-data-item').append(table_item(items[i]));
      }
    }
    $('#number-item').text(items.length);
    $('#number-item').data('number', items.length)
  }

  $('#button-delete').on('click', function(){
    var items = JSON.parse(localStorage.getItem("list_item"));
    var item_ids = getItemChecked();
    var list_items = items;
    if (item_ids != null) {
      for(var i =0; i< item_ids.length; i++) {
        list_items = remove_item_on_array(list_items, item_ids[i]);
        $('.item-'+item_ids[i]+'').remove()
      }
      localStorage.setItem("list_item", JSON.stringify(list_items));
      $(this)
    } else {
      alert('Please choose a book')
    }
  });

  $('#button-create').on('click', function(){
    var item_ids = getItemChecked();
    var items = JSON.parse(localStorage.getItem("list_item"));
    var url = $(this).data('url');
    var token = $(this).data('token');
    var date_return = $('.date-return').val();
    var data = {
      item_ids: item_ids,
      authenticity_token: token,
      date_return: date_return
    }
    $.ajax({
      url: url,
      method: 'POST',
      data: data,
      success:function(data) {
        var list_items = items;
        for(var i =0; i< item_ids.length; i++) {
          list_items = remove_item_on_array(list_items, item_ids[i]);
          $('.item-'+item_ids[i]+'').remove()
        }
        $('#exampleModal').modal('hide')
        localStorage.setItem("list_item", JSON.stringify(list_items));
      }
    })
  });

  $('.button-action').on('click', function(){
    var item_ids = getItemChecked();
    var url = $(this).data('url');
    var token = $(this).data('token');
    var status = $(this).data('status');
    var data = {
      item_ids: item_ids,
      authenticity_token: token,
      status: status
    }

    $.ajax({
      url: url,
      method: 'POST',
      data: data,
      success: function(data) {
        for(var i =0; i< item_ids.length; i++) {
          $('.item-'+item_ids[i]+'').remove()
        }
      }
    })
  });

  $('.select-box').on('click', function(){
    var checked = $(this).data('checked');
    if (checked) {
      var checkboxes = $('.item-checkbox').prop('checked', true)
    } else {
      var checkboxes = $('.item-checkbox').prop('checked', false)
    }
  });
});
