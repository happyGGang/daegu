<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<h1>오디오</h1>
<button id="recordButton">녹음 시작</button>
<button id="stopButton" disabled>종료</button>
<button id="sendButton" disabled>전송</button>
<audio id="audioPlayback" controls></audio>
<p id="transcription"></p>

<script type="text/javascript">
  let mediaRecorder;
  let audioChunks = [];
  const recordButton = document.getElementById('recordButton');
  const stopButton = document.getElementById('stopButton');
  const sendButton = document.getElementById('sendButton');
  const audioPlayback = document.getElementById('audioPlayback');
  const transcriptionElement = document.getElementById('transcription');
  let audioBlob;

  recordButton.addEventListener('click', async () => {
    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    mediaRecorder = new MediaRecorder(stream);
    mediaRecorder.start();

    mediaRecorder.ondataavailable = event => {
      audioChunks.push(event.data);
    };

    mediaRecorder.onstop = () => {
      audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
      audioPlayback.src = URL.createObjectURL(audioBlob);
      sendButton.disabled = false;
    };

    recordButton.disabled = true;
    stopButton.disabled = false;
  });

  stopButton.addEventListener('click', () => {
    mediaRecorder.stop();
    recordButton.disabled = false;
    stopButton.disabled = true;
  });

  sendButton.addEventListener('click', async () => {
    const formData = new FormData();
    formData.append('audio', audioBlob);

    const response = await fetch('/stt/sttGooGleTestUpload.do', {
      method: 'POST',
      body: formData
    });

    const result = await response.json();
    console.log('Transcription: ' + result.transcription);
    transcriptionElement.innerText = '텍스트변경: ' + result.transcription;


    audioPlayback.src = '';
    audioBlob = null;
    sendButton.disabled = true;
  });
</script>
