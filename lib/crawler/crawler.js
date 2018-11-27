var Crawler = require("crawler");

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'dk'
});


var c = new Crawler({
    maxConnections : 10,
    // This will be called for each crawled page
    callback : function (error, res, done) {
        if(error){
            console.log(error);
        }else{
          console.log(res.options.uri.split('-')[1]);
            var $ = res.$;
            // $ is Cheerio by default
            //a lean implementation of core jQuery designed specifically for the server
          var content  = $(".c-breadcrumb").html();
            connection.query('INSERT INTO raw_categories SET ?', {dkid: res.options.uri.split('-')[1], content: $(".c-breadcrumb").html(), detail: $(".c-params").html() }, function (error, results, fields) {
              if (error) throw error;
              done();
            });
        }

    }
});

for (var i = 2, len = 1000000; i < len; i++) {
  c.queue("https://www.digikala.com/product/dkp-"+i);
}
