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

  $('#article_relation_type').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#kinship_article_relation_type_id').val(this.options[value]['id']);
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
        url: '/article_relation_types/search/1',
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

  $('#article_kin').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#kinship_kin_id').val(this.options[value]['id']);
    },
    render: {
      option: function (item, escape) {
        return '<div>' + escape(item.title) + '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: '/articles/search/1',
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

  $('#article_source').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#originating_article_source_id').val(this.options[value]['id']);
    },
    render: {
      option: function (item, escape) {
        return '<div>' + escape(item.title) + '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: '/article_sources/search/1',
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

  $('#article_area').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#areaing_article_area_id').val(this.options[value]['id']);
    },
    render: {
      option: function (item, escape) {
        return '<div>' + escape(item.title) + '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: '/article_areas/search/1',
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
    //  options: JSON.parse($('#keyword_data').val()) ,
    onItemAdd: function (value, item) {
      $('#keyword').val($('#keyword').val() +','+ this.options[value]['id']);
    },
    onItemRemove: function (value, item) {
      var value = $('#keyword').val().replace(","+this.options[value]['id'], "");
      $('#keyword').val(value);
    },
    render: {
      option: function (item, escape) {
        console.log(item);
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
$(document).on("focus", "#article_relation_type",  fireThisUponEvent)
