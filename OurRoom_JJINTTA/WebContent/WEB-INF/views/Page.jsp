<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>

<head>

<meta charset="UTF-8">

<title>Your First WebSocket!</title>

</head>

<body> 
	<script type="text/javascript">
		var wsUri = "ws://localhost:8080/OurRoom/websocket/echo";

		function init() {
			output = document.getElementById("output");
		}
		
		//send버튼 클릭
		function send_message() {
			//웹소켓 생성
			websocket = new WebSocket(wsUri);
			
			websocket.onopen = function(evt) {
				onOpen(evt) 
			};
			websocket.onmessage = function(evt) {
				onMessage(evt)
			};
			websocket.onerror = function(evt) {
				onError(evt)
			};
		}

		// 웹소켓 세션이 열렸을 때
		function onOpen(evt) {
			writeToScreen("Connected to Endpoint!");
			doSend(textID.value);
		}
		// 서버 -> 클라이언트 메시지 도착
		function onMessage(evt) {
			writeToScreen("Message Received: " + evt.data);
		}
		// 오류가 발생했을 때
		function onError(evt) {
			writeToScreen('ERROR: ' + evt.data);
		}
		function doSend(message) {
			writeToScreen("Message Sent: " + message);
			websocket.send(message);
			//websocket.close();
		}
		function writeToScreen(message) {
			var pre = document.createElement("p");
			pre.style.wordWrap = "break-word";
			pre.innerHTML = message;

			output.appendChild(pre);
		}
		window.addEventListener("load", init, false);
	</script>
	<h1 style="text-align: center;">Hello World WebSocket Client</h1>
	<br>
	<div style="text-align: center;">
		<form action="">
			<input onclick="send_message()" value="Send" type="button"> <input
				id="textID" name="textID" value="Hello WebSocket!" type="text"><br>
		</form>
	</div>
	<div id="output"></div>
</body>
</html>