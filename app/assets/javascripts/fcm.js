function startFcm(event) {
  var config = {
    apiKey: "AIzaSyD3FXsFmgM-7yvOAPhfxU7AKCBxbj5-H7Y",
    authDomain: "divan-97d24.firebaseapp.com",
    databaseURL: "https://divan-97d24.firebaseio.com",
    projectId: "divan-97d24",
    storageBucket: "divan-97d24.appspot.com",
    messagingSenderId: "507346080586"
  };
  firebase.initializeApp(config);
  const messaging = firebase.messaging();
  messaging.usePublicVapidKey("BAV1NqJZ3ynfwYz4gXHtlkXFYzOO3VL-qxDDHQ_Tcfn-3YYcNaCtoSMnu5ruex9OEkvbTsOz1GZ0SRU0yZajk3c");
  messaging.requestPermission().then(function() {
    console.log('Notification permission granted.');
  }).catch(function(err) {
    console.log('Unable to get permission to notify.', err);
  });

  messaging.getToken().then(function(currentToken) {
    if (currentToken) {
      console.log(currentToken);
    } else {
      // Show permission request.
      console.log('No Instance ID token available. Request permission to generate one.');
      // Show permission UI.
      updateUIForPushPermissionRequired();
      setTokenSentToServer(false);
    }
  }).catch(function(err) {
    console.log('An error occurred while retrieving token. ', err);
    showToken('Error retrieving Instance ID token. ', err);
    setTokenSentToServer(false);
  });
  messaging.onMessage(function(payload) {
    new Noty({
        type: 'alert',
        theme    : 'relax',
        timeout: 2000,
        layout: 'bottomLeft',
        text: payload.notification.title + ': ' + payload.notification.body
    }).show();

    console.log('Message received. ', payload);
  });
}

//$(document).on('turbolinks:load', startFcm)
