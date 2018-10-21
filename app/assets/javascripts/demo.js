function fireThisUponEvent(event) {
  $( function() {
    $( ".exhibition_title" ).autocomplete({
      source: function( request, response ) {
        $.ajax({
          url: "/exhibitions/search/1",
          dataType: "jsonp",
          data: {
            query: request.term
          },
          success: function( data ) {
            response( data );
          }
        });
      },
      minLength: 2,
      select: function(event, ui) {
        $('#exhibition_id').val(ui.item.id);
      }
    });
  });

  $( function() {
    $( ".certification_title" ).autocomplete({
      source: function( request, response ) {
        $.ajax({
          url: "/certifications/search/1",
          dataType: "jsonp",
          data: {
            query: request.term
          },
          success: function( data ) {
            console.log(data);
            if (data === undefined || data.length == 0) {
              $('#cert_id').val('');
            }
            response( data );

          }
        });
      },
      minLength: 2,
      select: function(event, ui) {
        $('#cert_id').val(ui.item.id);
      }
    });
  });

  $('#article_role').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#contribution_role_id').val(this.options[value]['id']);
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
        url: '/roles/search/1',
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

  $('#article_profile').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#contribution_profile_id').val(this.options[value]['id']);
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
        url: '/profiles/search/1',
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

  $('#article_duty').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#contribution_duty_id').val(this.options[value]['id']);
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
        url: '/duties/search/1',
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

  $('#input-tags').selectize({
    plugins: ['remove_button'],
    create:       false,
    hideSelected: true,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    preload:      true,
    render: {
      option: function (item, escape) {
        return '<div>' + escape(item.title) + '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: '/keywords/search/1',
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

  $.extend($.ui.autocomplete.prototype.options, {
    open: function(event, ui) {
      $(this).autocomplete("widget").css({
        "width": ($(this).width()+ 25 + "px")
      });
    }
  });

}
$(document).on('turbolinks:load', fireThisUponEvent)
$(document).ready(fireThisUponEvent);
$(document).on("focus", ".exhibition_title",  fireThisUponEvent)
$(document).on("focus", ".certification_title",  fireThisUponEvent)
