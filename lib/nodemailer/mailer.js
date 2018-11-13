var  nodemailer = require('nodemailer');
var argv = require('minimist')(process.argv.slice(2));
var mysql      = require('mysql');
var async = require('async');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'divan'
});

var base_url = 'http://194.225.14.164'
var mail_type = argv['mail_type']
var text = ''
var subject = ''
var url = ''
var receivers = []
var article_ids = []
var article_titles = []
var content = ''

function html(text, url) {
  console.log(url);
  var t =  "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns:v='urn:schemas-microsoft-com:vml'><head> <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/> <meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0;'/> <meta name='viewport' content='width=600,initial-scale=2.3,user-scalable=no'> <link href='https://fonts.googleapis.com/css?family=Work+Sans:300,400,500,600,700' rel='stylesheet'> <link href='https://fonts.googleapis.com/css?family=Quicksand:300,400,700' rel='stylesheet'> <link href='http://cdn.font-store.ir/shahab.css' rel='stylesheet'> <title></title> <style type='text/css'> body{width: 100%; background-color: #ffffff; margin: 0; padding: 0; -webkit-font-smoothing: antialiased; mso-margin-top-alt: 0px; mso-margin-bottom-alt: 0px; mso-padding-alt: 0px 0px 0px 0px;}p, h1, h2, h3, h4{margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0;}span.preheader{display: none; font-size: 1px;}html{width: 100%;}table{font-size: 14px; border: 0;}/* ----------- responsivity ----------- */ @media only screen and (max-width: 640px){/*------ top header ------ */ .main-header{font-size: 20px !important;}.main-section-header{font-size: 28px !important;}.show{display: block !important;}.hide{display: none !important;}.align-center{text-align: center !important;}.no-bg{background: none !important;}/*----- main image -------*/ .main-image img{width: 440px !important; height: auto !important;}/*======divider======*/ .divider img{width: 440px !important;}/*-------- container --------*/ .container590{width: 440px !important;}.container580{width: 400px !important;}.main-button{width: 220px !important;}/*-------- secions ----------*/ .section-img img{width: 320px !important; height: auto !important;}.team-img img{width: 100% !important; height: auto !important;}}@media only screen and (max-width: 479px){/*------ top header ------ */ .main-header{font-size: 18px !important;}.main-section-header{font-size: 26px !important;}/*======divider======*/ .divider img{width: 280px !important;}/*-------- container --------*/ .container590{width: 280px !important;}.container590{width: 280px !important;}.container580{width: 260px !important;}/*-------- secions ----------*/ .section-img img{width: 280px !important; height: auto !important;}}</style><!--[if gte mso 9]><style type=”text/css”> body{font-family: arial, sans-serif!important;}</style><![endif]--></head><body class='respond' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'> <table style='display:none!important;'> <tr> <td> <div style='overflow:hidden;display:none;font-size:1px;color:#ffffff;line-height:1px;font-family:shahab;maxheight:0px;max-width:0px;opacity:0;'></div></td></tr></table> <table border='0' width='100%' cellpadding='0' cellspacing='0' bgcolor='ffffff'> <tr> <td align='center'> <table border='0' align='center' width='590' cellpadding='0' cellspacing='0' class='container590'> <tr> <td height='25' style='font-size: 25px; line-height: 25px;'>&nbsp;</td></tr><tr> <td align='center'> <table border='0' align='center' width='590' cellpadding='0' cellspacing='0' class='container590'> <tr> <td align='center' height='70' style='height:70px;'> <a href='' style='display: block; border-style: none !important; border: 0 !important;'><img width='100' border='0' style='display: block; width: 150px;' src='http://194.225.14.164/assets/logo.png' alt=''/></a> </td></tr></table> </td></tr><tr> <td height='25' style='font-size: 25px; line-height: 25px;'>&nbsp;</td></tr></table> </td></tr></table> <table border='0' width='100%' cellpadding='0' cellspacing='0' bgcolor='ffffff' class='bg_color'> <tr> <td align='center'> <table border='0' align='center' width='590' cellpadding='0' cellspacing='0' class='container590'> <tr> <td align='center' style='color: #343434; font-size: 24px; font-family: Quicksand, Calibri, sans-serif; font-weight:700;letter-spacing: 3px; line-height: 35px;' class='main-header'> <div style='line-height: 35px'> سامانه مدیریت یکپارچه <span style='color: #5caad2;'>دانش</span> </div></td></tr><tr> <td height='10' style='font-size: 10px; line-height: 10px;'>&nbsp;</td></tr><tr> <td align='center'> <table border='0' width='40' align='center' cellpadding='0' cellspacing='0' bgcolor='eeeeee'> <tr> <td height='2' style='font-size: 2px; line-height: 2px;'>&nbsp;</td></tr></table> </td></tr><tr> <td height='20' style='font-size: 20px; line-height: 20px;'>&nbsp;</td></tr><tr> <td align='right'> <table border='0' width='590' align='center' cellpadding='0' cellspacing='0' class='container590'> <tr> <td align='right' style='color: #888888; font-size: 16px; font-family:shahab; line-height: 24px;'> <p style='line-height: 24px; margin-bottom:15px;'> باسلام؛ </p><p style='line-height: 24px;margin-bottom:15px;direction: rtl;'>"
  +text+"</p><p style='line-height: 24px; margin-bottom:20px;'> </p><table border='0' align='center' width='180' cellpadding='0' cellspacing='0' bgcolor='5caad2' style='margin-bottom:20px;'> <tr> <td height='10' style='font-size: 10px; line-height: 10px;'>&nbsp;</td></tr><tr> <td align='center' style='color: #ffffff; font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; line-height: 22px; letter-spacing: 2px;'> <div style='line-height: 22px;'> <a href="
  +url+" style='color: #ffff88; text-decoration: none;'>کلیک کنید</a> </div></td></tr><tr> <td height='10' style='font-size: 10px; line-height: 10px;'>&nbsp;</td></tr></table> <p style='line-height: 24px'> ،با تشکر</br> تیم دیوان </p></td></tr></table> </td></tr></table> </td></tr><tr> <td height='40' style='font-size: 40px; line-height: 40px;'>&nbsp;</td></tr></table><table border='0' width='100%' cellpadding='0' cellspacing='0' bgcolor='ffffff' class='bg_color'> <tr> <td height='60' style='font-size: 60px; line-height: 60px;'>&nbsp;</td></tr><tr> <td align='center'> <table border='0' align='center' width='590' cellpadding='0' cellspacing='0' class='container590 bg_color'> <tr> <td align='center'> <table border='0' align='center' width='590' cellpadding='0' cellspacing='0' class='container590 bg_color'> <tr> <td> <table border='0' width='300' align='left' cellpadding='0' cellspacing='0' style='border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;' class='container590'> <tr> <td align='left'> <a href='' style='display: block; border-style: none !important; border: 0 !important;'><img width='80' border='0' style='display: block; width: 80px;' src='http://194.225.14.164/assets/logo.png' alt=''/></a> </td></tr><tr> <td height='25' style='font-size: 25px; line-height: 25px;'>&nbsp;</td></tr><tr> <td align='left' style='color: #888888; font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; line-height: 23px;' class='text_color'> <div style='color: #333333; font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; font-weight: 600; mso-line-height-rule: exactly; line-height: 23px;'> Email us: <br/> <a href='mailto:' style='color: #888888; font-size: 14px; font-family: 'Hind Siliguri', Calibri, Sans-serif; font-weight: 400;'>divan@ut.ac.ir</a> </div></td></tr></table> <table border='0' width='2' align='left' cellpadding='0' cellspacing='0' style='border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;' class='container590'> <tr> <td width='2' height='10' style='font-size: 10px; line-height: 10px;'></td></tr></table> <table border='0' width='200' align='right' cellpadding='0' cellspacing='0' style='border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;' class='container590'> <tr> <td class='hide' height='45' style='font-size: 45px; line-height: 45px;'>&nbsp;</td></tr><tr> <td height='15' style='font-size: 15px; line-height: 15px;'>&nbsp;</td></tr><tr> <td> <table border='0' align='right' cellpadding='0' cellspacing='0'> <tr> <td> <a href='https://www.facebook.com/divanapp' style='display: block; border-style: none !important; border: 0 !important;'><img width='24' border='0' style='display: block;' src='http://i.imgur.com/Qc3zTxn.png' alt=''></a> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td> <a href='https://twitter.com/divanapp' style='display: block; border-style: none !important; border: 0 !important;'><img width='24' border='0' style='display: block;' src='http://i.imgur.com/RBRORq1.png' alt=''></a> </td></tr></table> </td></tr></table> </td></tr></table> </td></tr></table></td></tr><tr> <td height='60' style='font-size: 60px; line-height: 60px;'>&nbsp;</td></tr></table></body></html>"
  return t
}
console.log('article_ids ------------------>' , argv['article_ids'], argv['article_ids'].toString().length);
//console.log('ids ------------------>' , argv['id']);
async.series([
  function(callback) {
    if (argv['article_ids'].toString() != 'true'  && argv['article_ids'].toString().length > 0){
      var q = "SELECT * FROM articles WHERE id IN (" + argv['article_ids'] + ")"
      connection.query(q, function (error, results, fields) {
        for (var i = 0, len = results.length; i < len; i++) {
          console.log(results[i]);
          article_ids.push(results[i].id)
          article_titles.push(results[i].title)
          if (i == len - 1){
            callback(null, 'articles');
          }
        }
      });
    } else {
      callback(null, 'articles');
    }
  },
  function(callback) {
    var q = "SELECT * FROM users WHERE id IN (" + argv['id'] + ")"
    connection.query(q, function (error, results, fields) {
      for (var i = 0, len = results.length; i < len; i++) {
        receivers.push(results[i].email)
        switch (mail_type) {
          case 'change_password':
          url = base_url + '/users/password/edit?reset_password_token=' + results[i].reset_password_token
          break;
          case 'article_sent':
          url = base_url + '/articles/' + article_ids[0]
          break;
          case 'article_refund':
          url = base_url + '/articles/' + article_ids[0]
          break;
          case 'role_assignment':
          url = base_url
          break;
        }
        if (i == len - 1){
          callback(null, 'one');
        }
      }
    });
  },
  function(callback) {
    switch (mail_type) {
      case 'change_password':
      text = 'درخواستی از سمت شما برای تغییر رمز به ما رسیده است. چنانچه این درخواست از سوی شما بوده دکمه زیر را کلیک کنید. در غیر اینصورت این پیام را نادیده بگیرید.'
      subject = 'درخواست تغییر رمز عبور'
      callback(null, 'two')
      break;
      case 'article_sent':
      title = article_titles[0]
      text = 'سندی با عنوان' + " ' " +title + " ' " + 'به میز کار شما اضافه شد. با کلیک  بر روی لینک زیر می توانید جزئیات سند را مشاهده کنید.'
      subject = 'دریافت سند'
      callback(null, 'two')
      break;
      case 'article_refund':
      title = article_titles[0]
      text = 'سند با عنوان' + " ' " +title + " ' " + 'به شما عودت داده شد. برای مشاهده جزئیات کلیک کنید.'
      subject = 'عودت سند'
      callback(null, 'two')
      break;
      case 'role_assignment':
      title = argv['role_title']
      text = 'نقش' + " ' " +title + " ' " + 'به نقش های شما در سامانه افزوده شد'
      subject = 'نقش کاربر'
      callback(null, 'two')
      break;
      case 'role_unassignment':
      title = argv['role_title']
      text = 'نقش' + " ' " +title + " ' " + 'از نقش های شما حذف شد'
      subject = 'حذف نقش'
      callback(null, 'two')
      break;
    }
  }
],

function(err, results) {
  content = html(text, url)
  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'appdivan@gmail.com',
      pass: 'salam64511'
    }
  });

  const mailOptions = {
    from: 'appdivan@gmail.com', // sender address
    to: receivers, // list of receivers
    subject: subject , // Subject line
    html: content
  };

  transporter.sendMail(mailOptions, function (err, info) {
    if(err)
    console.log(err)
    else
    console.log(info);
  });
  connection.end();
});
