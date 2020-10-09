/*
*  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
*
*  Use of this source code is governed by a BSD-style license
*  that can be found in the LICENSE file in the root of the source
*  tree.
*/

// This code is adapted from
// https://rawgit.com/Miguelao/demos/master/mediarecorder.html
$( document ).ready(function() {
'use strict';

/* globals MediaRecorder */

let mediaRecorder;
let recordedBlobs;

const errorMsgElement = document.querySelector('span#errorMsg');
const recordedVideo = document.querySelector('audio#recorded');
/*const recordButton = document.querySelector('button#record');
recordButton.addEventListener('click', () => {
  if (recordButton.textContent === 'Start Recording') {
    //startRecording();
  } else {
   stopRecording();
    recordButton.textContent = 'Start Recording';
    playButton.disabled = false;
    downloadButton.disabled = false;
  }
});*/

const playButton = document.querySelector('button#play');
playButton.addEventListener('click', () => {
  const superBuffer = new Blob(recordedBlobs, {type: 'audio/webm'});
  recordedVideo.src = null;
  recordedVideo.srcObject = null;
  recordedVideo.src = window.URL.createObjectURL(superBuffer);
  recordedVideo.controls = true;
  recordedVideo.play();
});

const downloadButton = document.querySelector('button#download');
downloadButton.addEventListener('click', () => {
  //const blob = new Blob(recordedBlobs, {type: 'audio/webm'});
  fileUpload()
  /*const url = window.URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.style.display = 'none';
  a.href = url;
  a.download = 'test.webm';
  document.body.appendChild(a);
  a.click();
  setTimeout(() => {
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
  }, 100);*/
});

function handleDataAvailable(event) {
  console.log('handleDataAvailable', event);
  if (event.data && event.data.size > 0) {
    recordedBlobs.push(event.data);
  }
}

function startRecording() {
  recordedBlobs = [];
  let options = {mimeType: 'audio/webm;codecs=opus'};
  if (!MediaRecorder.isTypeSupported(options.mimeType)) {
    console.error(`${options.mimeType} is not supported`);
    options = {mimeType: 'audio/webm;codecs=opus'};
    if (!MediaRecorder.isTypeSupported(options.mimeType)) {
      console.error(`${options.mimeType} is not supported`);
      options = {mimeType: 'audio/webm'};
      if (!MediaRecorder.isTypeSupported(options.mimeType)) {
        console.error(`${options.mimeType} is not supported`);
        options = {mimeType: ''};
      }
    }
  }

  try {
    mediaRecorder = new MediaRecorder(window.stream, options);
  } catch (e) {
    console.error('Exception while creating MediaRecorder:', e);
    errorMsgElement.innerHTML = `Exception while creating MediaRecorder: ${JSON.stringify(e)}`;
    return;
  }

  console.log('Created MediaRecorder', mediaRecorder, 'with options', options);
  //recordButton.textContent = 'Stop Recording';
  startButton.textContent = 'Stop';
  playButton.disabled = true;
  downloadButton.disabled = true;
  mediaRecorder.onstop = (event) => {
    console.log('Recorder stopped: ', event);
    console.log('Recorded Blobs: ', recordedBlobs);
  };
  mediaRecorder.ondataavailable = handleDataAvailable;
  mediaRecorder.start();
  console.log('MediaRecorder started', mediaRecorder);
}

function stopRecording() {
  mediaRecorder.stop();
}

function handleSuccess(stream) {
  //recordButton.disabled = false;
  startButton.disabled = false;
  console.log('getUserMedia() got stream:', stream);
  window.stream = stream;

  const gumVideo = document.querySelector('audio#gum');
  gumVideo.srcObject = stream;
  
}

async function init(constraints) {
  try {
    const stream = await navigator.mediaDevices.getUserMedia(constraints);
    handleSuccess(stream);
    
  } catch (e) {
    console.error('navigator.getUserMedia error:', e);
    errorMsgElement.innerHTML = `navigator.getUserMedia error:${e.toString()}`;
  }
}

function fileUpload(){
  const url = '/uploads';
  const formData = new FormData();
  var id = document.querySelector('span#article_id').textContent
  const blob = new Blob(recordedBlobs);
  var file = new File([blob], "rec.webm", {type:"audio/webm", lastModified:new Date()});
  formData.append('file', file)
  formData.append('authenticity_token',window._token)
  formData.append('filename','rec.webm')
  formData.append('upload[uploadable_id]', id)
  formData.append('upload[uploadable_type]', 'Article')
  formData.append('upload[attachment_type]', 'article_voices')
  const config = {
      headers: {
          'content-type': 'multipart/form-data',
          'Authorization': "bearer " 
      }
  }
  axios.post(url, formData,config).then(function (response) {
    location.reload();
  })
  .catch(function (error) {
    console.log(error);
  });
}

const startButton = document.querySelector('button#start');
document.querySelector('button#start').addEventListener('click', async () => {
  const constraints = {
    audio: {
      echoCancellation: {exact: true}
    }
  };
  console.log('SSSSSS')
  console.log('Using media constraints:', constraints);
  await init(constraints);
  if (startButton.textContent === 'Record') {
    startRecording();
  } else {
   stopRecording();
    startButton.textContent = 'Record';
    playButton.disabled = false;
    downloadButton.disabled = false;
  }
});
});