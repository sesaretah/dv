//const shoa_url = 'http://localhost:3000';
const shoa_url = 'http://95.156.255.35:8080';
var token = localStorage.getItem("shoa-token");
function auth() {
  var win = window.open(shoa_url + "/interconnects/req?provider=Divan", "", "width=400,height=500");
}

function ajax_call(asset, past, plural, color){
  $.ajax({
    url: shoa_url + '/api/v2/'+asset,
    type: 'GET',
    data: {type: $('#shoa-type').val() , id: $('#shoa-source-id').val(), uuid: token},
    success: function (data) {
      $('#shoa-'+plural).html(data[plural]);
      if(data[past]){
        $('#shoa-'+asset+'-i').css('color', color);
      } else {
        $('#shoa-'+asset+'-i').css('color', '#bbbbbb');
      }
    },
    error: function () { },
  });
}

function like(){
  ajax_call('like', 'liked', 'likes', '#bf4141')
}

function share(){
  $.ajax({
    url: shoa_url + '/api/v2/share',
    type: 'GET',
    data: {stream: $('#shoa_streams').val() ,type: $('#shoa-type').val() , id: $('#shoa-source-id').val(), uuid: token},
    success: function (data) {
      if(data.shared){
        $('#shoa-share-i').css('color', '#467fcf');
      } else {
        $('#shoa-share-i').css('color', '#bbbbbb');
      }
      $('#shoa-shares').html(data.shares);
      $("#shoa-share-modal").hide();
      $('.modal-backdrop').remove();
    },
    error: function () { },
  });
}

function follow(){
  ajax_call('follow', 'followed', 'follows', '#30b749')
}

function bookmark(){
  ajax_call('bookmark', 'bookmarked', 'bookmarks', '#a241bf')
}

function fireShoa(event) {
  var type = $('#shoa-type').val();
  var id = $('#shoa-source-id').val();
  var title = $('#shoa-title').val();
  var content = $('#shoa-content').val();
  $('#shoa-box').css({'padding': '1.5rem','border' : '1px solid rgba(0, 40, 100, 0.12)','border-radius' : '3px 3px 0 0;','font-size': '0.9375rem', 'text-align': 'center', 'letter-spacing': '2px'});
  var cssLink = $("<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css' integrity='sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/' crossorigin='anonymous'>");
  $("head").append(cssLink);
  if (token != null && token.length < 10){
    $('#shoa-box').html("<button type='button' onclick='auth()' class='btn btn-primary btn-block'>اتصال به شعاع </button>");
  } else {
    $('#shoa-box').html("<a onclick='follow()'><i class='fas fa-link' id='shoa-follow-i' style='color: #bbbbbb;'></i><span id='shoa-follows' style='font-size:9px;'>0</a><a data-toggle='modal' data-target='#shoa-share-modal'><i class='fas fa-retweet' id='shoa-share-i' style='color: #bbbbbb;'></i><span id='shoa-shares' style='font-size:9px;'>0</a><a onclick='like()'><i class='fas fa-heart' id='shoa-like-i' style='color: #bbbbbb;'></i><span id='shoa-likes' style='font-size:9px;'>0</a><a onclick='bookmark()'><i class='fas fa-bookmark' id='shoa-bookmark-i' style='color: #bbbbbb;'></i><span id='shoa-bookmarks' style='font-size:9px;'>0</a>")
    $('#shoa-modal').html("<div class='modal' id='shoa-share-modal'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><h4 class='modal-title'>بازنشر </h4><button type='button' class='close' data-dismiss='modal'></button></div><div class='modal-body'>در جویبار زیر بازنشر شود<select id='shoa_streams' class='form-control'></select></div><div class='modal-footer'><button type='button' class='btn btn-danger' data-dismiss='modal'>انصراف</button><button type='button' class='btn btn-success' onclick='share()'> نشر </button></div></div></div></div>");
  }

  $.ajax({
    url: shoa_url + '/api/v2/check_asset',
    type: 'POST',
    data: {title: title, content: content, type: type , id: id, link: window.location.href, uuid: token},
    success: function (data) {
    },
    error: function () { },
  });

  $.ajax({
    url: shoa_url + '/api/v2/authorized',
    type: 'GET',
    data: {uuid: token},
    success: function (data) {
      if(data.result == 'ERROR'){
        localStorage.setItem("shoa-token", null);
      }
    },
    error: function () { },
  });

  $.ajax({
    url: shoa_url + '/api/v2/streams',
    type: 'GET',
    data: {uuid: token},
    success: function (data) {
      for (var i = 0; i < data.streams.length; i++) {
        $('#shoa_streams').append("<option value='"+ data.streams[i].id +"'>"+ data.streams[i].title+"</option>");
      }
    },
    error: function () { },
  });


  $.ajax({
    url: shoa_url + '/api/v2/likes',
    type: 'GET',
    data: {type: type , id: id, uuid: token},
    success: function (data) {
      if(data.liked){
        $('#shoa-like-i').css('color', '#bf4141');
      } else {
        $('#shoa-like-i').css('color', '#bbbbbb');
      }
      $('#shoa-likes').html(data.likes);

    },
    error: function () { },
  });

  $.ajax({
    url: shoa_url + '/api/v2/shares',
    type: 'GET',
    data: {type: type , id: id, uuid: token},
    success: function (data) {
      if(data.shared){
        $('#shoa-share-i').css('color', '#467fcf');
      } else {
        $('#shoa-share-i').css('color', '#bbbbbb');
      }
      $('#shoa-shares').html(data.shares);

    },
    error: function () { },
  });

  $.ajax({
    url: shoa_url + '/api/v2/follows',
    type: 'GET',
    data: {type: type , id: id, uuid: token},
    success: function (data) {
      if(data.followed){
        $('#shoa-follow-i').css('color', '#30b749');
      } else {
        $('#shoa-follow-i').css('color', '#bbbbbb');
      }
      $('#shoa-follows').html(data.follows);

    },
    error: function () { },
  });

  $.ajax({
    url: shoa_url + '/api/v2/bookmarks',
    type: 'GET',
    data: {type: type , id: id, uuid: token},
    success: function (data) {
      if(data.bookmarked){
        $('#shoa-bookmark-i').css('color', '#a241bf');
      } else {
        $('#shoa-bookmark-i').css('color', '#bbbbbb');
      }
      $('#shoa-bookmarks').html(data.bookmarks);

    },
    error: function () { },
  });


  function displayMessage (evt) {
    localStorage.setItem("shoa-token", evt.data);
    location.reload();
  }

  if (window.addEventListener) {
    window.addEventListener("message", displayMessage, false);
  }
  else
  {
    window.attachEvent("onmessage", displayMessage);
  }
}
$(document).on('turbolinks:load', fireShoa)
