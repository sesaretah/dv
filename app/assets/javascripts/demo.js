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
            //console.log(data);
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

  $('#assignment_profile').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#assignment_user_id').val(this.options[value]['user_id']);
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

  $('#assignment_role').selectize({
    create:       false,
    labelField:   'title',
    valueField:   'title',
    searchField:  'title',
    maxItems: 1,
    preload:      true,
    onItemAdd: function (value, item) {
      $('#assignment_role_id').val(this.options[value]['id']);
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
        //console.log(item);
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



  $( ".article-progress" ).each(function( index ) {
    var id = $(this).attr('id').split("_")[1];
    var nodes = JSON.parse($('#nodes_'+id).text());
    var edges = JSON.parse($('#edges_'+id).text());
    var current_node = parseInt($('#current_node_'+id).text());
    var start_node = parseInt($('#start_node_'+id).text());
    var g = new graphlib.Graph({ directed: true });
    async.series([
      function(callback) {
        for (var i = 0, len = nodes.length; i < len; i++) {
          g.setNode(nodes[i]['id']);
          if (i == len - 1){
            callback(null, 'one');
          }
        }
      },
      function(callback) {
        for (var i = 0, len = edges.length; i < len; i++) {
          var source = edges[i]['source']['id']
          var target = edges[i]['target']['id']
          g.setEdge(source,target);
          if (i == len - 1){
            callback(null, 'two');
          }
        }
      }
    ],
    // optional callback
    function(err, results) {
      var d = graphlib.alg.dijkstra(g, current_node);
      var m = graphlib.alg.dijkstra(g, start_node);
      var root_to_current = m[current_node]['distance'] + 1
      var max = 0;
      for (var i = 0, len = Object.keys(d).length; i < len; i++) {
        var distance =  d[Object.keys(d)[i]]['distance']
        if (Number.isInteger(distance) && distance > max)
        {
          max = distance
        }
        if (i == len - 1)
        {
          var percent = (root_to_current/(root_to_current  + max)) * 100;
          if ( percent > 2){
            if (percent == 100){
              $('#pb_'+id).attr('style', "width:100%;");
              $('#pb_'+id).removeClass( "bg-yellow" ).addClass( "bg-green" );
            } else {
              $('#pb_'+id).attr('style', "width:" + percent +"%;");
            }
          } else {
            $('#pb_'+id).attr('style', "width:2%;");
            $('#pb_'+id).removeClass( "bg-yellow" ).addClass( "bg-red" );
          }

          $('#pb_'+id).attr('aria-valuenow', percent);
          $('#progress_percent_'+id).text( Math.round(percent)+'%');
        }
      }
    });
  });

  $("#article_content_template_id").change(function() {
    if ($("#article_content_template_id").val()){
      $.get( "/content_templates/"+$("#article_content_template_id").val()+".json", function( data ) {
        CKEDITOR.instances['sometext'].insertText(data.content + '\n\n');
      });
    }
  });



}
$(document).on('turbolinks:load', fireThisUponEvent)
//$(document).ready(fireThisUponEvent);
$(document).on("focus", ".exhibition_title",  fireThisUponEvent)
$(document).on("focus", ".certification_title",  fireThisUponEvent)
$(document).on("focus", "#article_relation_type",  fireThisUponEvent)
