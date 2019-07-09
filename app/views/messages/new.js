$("#messages").replaceWith("<%= escape_javascript(render(:partial => 'messages/form', locals: {message: @message})) %>");
$('.input-users').selectize({
  plugins: ['remove_button'],
  create:       false,
  hideSelected: true,
  labelField:   'title',
  valueField:   'title',
  searchField:  'title',
  preload:      true,
  onItemAdd: function (value, item) {
    $('#recipients').val($('#recipients').val() +','+ this.options[value]['user_id']);
  },
  onItemRemove: function (value, item) {
    var value = $('#recipients').val().replace(","+this.options[value]['user_id'], "");
    $('#recipients').val(value);
  },
  render: {
    option: function (item, escape) {
      //console.log(item);
      return '<div>' + escape(item.title) + '</div>';
    }
  },
  load: function(query, callback) {
    if (!query.length) return callback();
    $.ajax({
      url: '/profiles/search_in_users/1',
      type: 'GET',
      dataType: 'json',
      data: {
        q: query,
      },
      error: function() {
        callback();
      },
      success: function(res) {
        callback(res);
      }
    });
  }
});
