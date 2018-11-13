const https = require('https');
var argv = require('minimist')(process.argv.slice(2));
var fs = require('fs');
var path = require('path');
var {google} = require('googleapis');
var PROJECT_ID = 'divan-97d24';
var HOST = 'fcm.googleapis.com';
var PATH = '/v1/projects/' + PROJECT_ID + '/messages:send';
var MESSAGING_SCOPE = 'https://www.googleapis.com/auth/firebase.messaging';
var SCOPES = [MESSAGING_SCOPE];

function getAccessToken() {
  return new Promise(function(resolve, reject) {
    var key = require(path.resolve( __dirname, 'divan-97d24-firebase-adminsdk-d7wgz-f646bafdae.json'));
    var jwtClient = new google.auth.JWT(
      key.client_email,
      null,
      key.private_key,
      SCOPES,
      null
    );
    jwtClient.authorize(function(err, tokens) {
      if (err) {
        reject(err);
        return;
      }
      resolve(tokens.access_token);
    });
  });
}

function sendFcmMessage(fcmMessage) {
  getAccessToken().then(function(accessToken) {
    console.log(accessToken);
    var options = {
      hostname: HOST,
      path: PATH,
      method: 'POST',
      headers: {
        'Authorization': 'Bearer ' + accessToken
      }
    };

    var request = https.request(options, function(resp) {
      resp.setEncoding('utf8');
      resp.on('data', function(data) {
        console.log('Message sent to Firebase for delivery, response:');
        console.log(data);
      });
    });

    request.on('error', function(err) {
      console.log('Unable to send message to Firebase');
      console.log(err);
    });

    request.write(JSON.stringify(fcmMessage));
    request.end();
  });
}

function buildCommonMessage() {
  return {
    "message": {
      "token" : argv['token'],
      "notification": {
        "title": argv['title'],
        "body": argv['body']
      },
      "webpush": {
        "headers": {
          "Urgency": "high"
        },
        "notification": {
          "body": "This is a message from FCM to web",
          "requireInteraction": "true",
          "badge": "/badge-icon.png"
        }
      }
    }
  };
}

sendFcmMessage(buildCommonMessage());
