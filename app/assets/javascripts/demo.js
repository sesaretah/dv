function fireAutoCompleteEvent(event) {
  $(function () {
    $(".exhibition_title").autocomplete({
      source: function (request, response) {
        $.ajax({
          url: "/exhibitions/search/1",
          dataType: "jsonp",
          data: {
            query: request.term,
          },
          success: function (data) {
            response(data);
          },
        });
      },
      minLength: 2,
      select: function (event, ui) {
        $("#exhibition_id").val(ui.item.id);
      },
    });
  });

  $(function () {
    $(".certification_title").autocomplete({
      source: function (request, response) {
        $.ajax({
          url: "/certifications/search/1",
          dataType: "jsonp",
          data: {
            query: request.term,
          },
          success: function (data) {
            //console.log(data);
            if (data === undefined || data.length == 0) {
              $("#cert_id").val("");
            }
            response(data);
          },
        });
      },
      minLength: 2,
      select: function (event, ui) {
        $("#cert_id").val(ui.item.id);
      },
    });
  });

  $("#article_role").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#contribution_role_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/roles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_profile").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#contribution_profile_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/profiles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_publisher").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#involvement_publisher_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/publishers/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_duty").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#contribution_duty_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/duties/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#publication_publisher").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#publication_publisher_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/publishers/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#assignment_profile").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      console.log("test", this.options[value]["user_id"]);
      $("#assignment_user_id").val(this.options[value]["user_id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/profiles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#profile_grouping").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#profile_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/profiles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_profile_1").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#profile_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/profiles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_profile_2").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#profile_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/profiles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_keyword_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#keyword_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/keywords/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_keyword_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#keyword_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/keywords/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_article_area_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#article_area_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_areas/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_article_area_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#article_area_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_areas/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_article_event_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#article_event_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_events/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_article_event_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#article_event_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_events/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_article_format_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#article_format_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_formats/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_article_format_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#article_format_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_formats/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_article_relation_type_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#article_relation_type_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_relation_types/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_article_relation_type_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#article_relation_type_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_relation_types/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_article_source_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#article_source_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_sources/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_article_source_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#article_source_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_sources/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_article_type_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#article_type_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_types/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_article_type_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#article_type_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_types/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_duty_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#duty_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/duties/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_duty_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#duty_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/duties/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_language_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#language_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/languages/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_language_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#language_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/languages/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_role_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#role_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/roles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_role_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#role_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/roles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#megre_publisher_1").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    onItemAdd: function (value, item) {
      $("#publisher_1").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + item.title + "(" + item.id + ")" + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/publishers/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          console.log(res.slice(0, 30));
          callback(res.slice(0, 30));
        },
      });
    },
  });

  $("#megre_publisher_2").selectize({
    create: false,
    labelField: "title",
    valueField: "id",
    searchField: "title",
    maxItems: 1,
    maxOptions: 30,
    // preload:      true,
    onItemAdd: function (value, item) {
      $("#publisher_2").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return (
          "<div>" + escape(item.title) + "(" + escape(item.id) + ")" + "</div>"
        );
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/publishers/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#assignment_role").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#assignment_role_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/roles/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_relation_type").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#kinship_article_relation_type_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_relation_types/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_access_group").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#access_group_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/access_groups/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_kin").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#kinship_kin_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      var article_id = $("#article_id").text();
      $.ajax({
        url: "/articles/search/1?domain=workflow&article_id=" + article_id,
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_source").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#originating_article_source_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_sources/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $("#article_area").selectize({
    create: false,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    maxItems: 1,
    preload: true,
    onItemAdd: function (value, item) {
      $("#areaing_article_area_id").val(this.options[value]["id"]);
    },
    render: {
      option: function (item, escape) {
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/article_areas/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $(".input-tags").selectize({
    plugins: ["remove_button"],
    create: false,
    hideSelected: true,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    preload: true,
    //  options: JSON.parse($('#keyword_data').val()) ,
    onItemAdd: function (value, item) {
      $("#keyword").val($("#keyword").val() + "," + this.options[value]["id"]);
      var id = $(".input-tags").attr("id");
      $.ajax({
        type: "post",
        dataType: "html",
        url: "/articles/" + id,
        data: $("#keywords").serialize(),
        success: function (response) {},
      });
    },
    onItemRemove: function (value, item) {
      var value = $("#keyword")
        .val()
        .replace("," + this.options[value]["id"], "");
      $("#keyword").val(value);
      var id = $(".input-tags").attr("id");
      $.ajax({
        type: "post",
        dataType: "html",
        url: "/articles/" + id,
        data: $("#keywords").serialize(),
        success: function (response) {},
      });
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/keywords/search/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $(".input-users").selectize({
    plugins: ["remove_button"],
    create: false,
    hideSelected: true,
    labelField: "title",
    valueField: "title",
    searchField: "title",
    preload: true,
    onItemAdd: function (value, item) {
      $("#recipients").val(
        $("#recipients").val() + "," + this.options[value]["user_id"]
      );
    },
    onItemRemove: function (value, item) {
      var value = $("#recipients")
        .val()
        .replace("," + this.options[value]["user_id"], "");
      $("#recipients").val(value);
    },
    render: {
      option: function (item, escape) {
        //console.log(item);
        return "<div>" + escape(item.title) + "</div>";
      },
    },
    load: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: "/profiles/search_in_users/1",
        type: "GET",
        dataType: "json",
        data: {
          q: query,
        },
        error: function () {
          callback();
        },
        success: function (res) {
          callback(res);
        },
      });
    },
  });

  $.extend($.ui.autocomplete.prototype.options, {
    open: function (event, ui) {
      $(this)
        .autocomplete("widget")
        .css({
          width: $(this).width() + 25 + "px",
        });
    },
  });

  $(".article-progress").each(function (index) {
    var id = $(this).attr("id").split("_")[1];
    var nodes = JSON.parse($("#nodes_" + id).text());
    var edges = JSON.parse($("#edges_" + id).text());
    var current_node = parseInt($("#current_node_" + id).text());
    var start_node = parseInt($("#start_node_" + id).text());
    var g = new graphlib.Graph({ directed: true });
    async.series(
      [
        function (callback) {
          for (var i = 0, len = nodes.length; i < len; i++) {
            g.setNode(nodes[i]["id"]);
            if (i == len - 1) {
              callback(null, "one");
            }
          }
        },
        function (callback) {
          for (var i = 0, len = edges.length; i < len; i++) {
            var source = edges[i]["source"]["id"];
            var target = edges[i]["target"]["id"];
            g.setEdge(source, target);
            if (i == len - 1) {
              callback(null, "two");
            }
          }
        },
      ],
      // optional callback
      function (err, results) {
        var d = graphlib.alg.dijkstra(g, current_node);
        var m = graphlib.alg.dijkstra(g, start_node);
        var root_to_current = m[current_node]["distance"] + 1;
        var max = 0;
        for (var i = 0, len = Object.keys(d).length; i < len; i++) {
          var distance = d[Object.keys(d)[i]]["distance"];
          if (Number.isInteger(distance) && distance > max) {
            max = distance;
          }
          if (i == len - 1) {
            var percent = (root_to_current / (root_to_current + max)) * 100;
            if (percent > 2) {
              if (percent == 100) {
                $("#pb_" + id).attr("style", "width:100%;");
                $("#pb_" + id)
                  .removeClass("bg-yellow")
                  .addClass("bg-green");
              } else {
                $("#pb_" + id).attr("style", "width:" + percent + "%;");
              }
            } else {
              $("#pb_" + id).attr("style", "width:2%;");
              $("#pb_" + id)
                .removeClass("bg-yellow")
                .addClass("bg-red");
            }

            $("#pb_" + id).attr("aria-valuenow", percent);
            $("#progress_percent_" + id).text(Math.round(percent) + "%");
          }
        }
      }
    );
  });

  $("#article_content_template_id").change(function () {
    if ($("#article_content_template_id").val()) {
      $.get(
        "/content_templates/" +
          $("#article_content_template_id").val() +
          ".json",
        function (data) {
          CKEDITOR.instances["sometext"].insertText(data.content + "\n\n");
        }
      );
    }
  });
}
$(document).on("turbolinks:load", fireAutoCompleteEvent);
$(document).ready(fireAutoCompleteEvent);
$(document).on("focus", ".exhibition_title", fireAutoCompleteEvent);
$(document).on("focus", ".certification_title", fireAutoCompleteEvent);
$(document).on("focus", "#article_relation_type", fireAutoCompleteEvent);
$(document).on("focus", "#article_area", fireAutoCompleteEvent);

$(document).on("focus", "#article_profile", fireAutoCompleteEvent);
$(document).on("focus", "#article_role", fireAutoCompleteEvent);
$(document).on("focus", "#article_duty", fireAutoCompleteEvent);
$(document).on("focus", "#article_kin", fireAutoCompleteEvent);
