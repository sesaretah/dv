var Crawler = require("crawler");
const cheerio = require('cheerio');
var mysql      = require('mysql');
var async = require('async');
var crypto = require('crypto');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'dk'
});


var c = new Crawler({
  maxConnections : 10,
  callback : function (error, res, done) {
    if(error){
      console.log(error);
    }else{
      async.waterfall([
        function(callback) {
          var $ = res.$;
          var content  = $(".c-breadcrumb").html();
          var $ = cheerio.load(content);
          var i = 0;
          $('a').each(function(index){
            var obj = this
            //console.log(index , this.children[0].children[0].data);
            if (obj.children[0] !== undefined && obj.children[0].children[0].data !== undefined ){

              var hash = crypto.createHash('md5').update(obj.children[0].children[0].data).digest("hex");
              //console.log(index , obj.children[0].children[0].data);
              var q = "SELECT * FROM categories WHERE hash = '" + hash + "'"
              connection.query(q, function (error, results, fields) {
                //  console.log(results[0]['id']);
                if (error) throw error;
                if (results.length == 0){
                  connection.query('INSERT INTO categories SET ?', { title: obj.children[0].children[0].data, stage: index, hash: hash}, function (error, results, fields) {
                    if (error) throw error;
                  });
                }
              });
            }
            if (index == $('a').length - 1){
              //console.log('First Callback');
              callback(null, obj.children[0].children[0].data);
            }
          });
        },
        function(arg1, callback) {
          var $ = res.$;
          var i = 0;
          $('.c-params__list-key').each(function(index){
            var obj = this
            if (obj.children[0] !== undefined && obj.children[0].children[0].data !== undefined ){
              var spec_hash = crypto.createHash('md5').update(obj.children[0].children[0].data).digest("hex");
              var q = "SELECT * FROM specs WHERE hash = '" + spec_hash +"'"
              connection.query(q, function (error, results, fields) {
                if (error) throw error;
                if (results.length == 0){
                  var q = "SELECT * FROM categories WHERE title = '" + arg1 +"'"
                  connection.query(q, function (error, results, fields) {
                    if (error) throw error;
                    connection.query('INSERT INTO specs SET ?', { title: obj.children[0].children[0].data, category_id: results[0]['id'], hash: spec_hash}, function (error, results, fields) {
                      if (error) throw error;
                    });
                  });
                }
              });
            }
            if (index == $('.c-params__list-key').length - 1){
              //console.log('Second Callback');
              callback(null, index);
            }
          });

        }
      ],
      function(err, results) {
        //console.log('Waterfall Ended');
        console.log(res.options.uri.split('-')[1]);
        done();
      });
    }
  }
});

for (var i = 2, len = 1000000; i < len; i++) {
  c.queue("https://www.digikala.com/product/dkp-"+i);
}
