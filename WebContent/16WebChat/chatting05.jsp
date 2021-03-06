<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatting04.jsp</title>
<link rel="stylesheet" href="css/default.css" />
<script type="text/javascript">
	var messageWindow;
	var inputMessage;
	var chat_id, chat_room; //채팅방 전역변수 선언
	var webSocket;

	window.onload = function() {
		messageWindow = document.getElementById("chat-container");

		messageWindow.scrollTop = messageWindow.scrollHeight;

		inputMessage = document.getElementById('inputMessage');

		
		chat_id = document.getElementById('chat_id').value;
		chat_room = document.getElementById('chat_room').value;

		
		webSocket = new WebSocket(
				'ws://192.168.219.121:8282/K07JSPServlet/ChatServer02');

		/*
			웹소켓 연결후 메세지전송, 에러발생 등은 모두 이벤트를 통해 함수를 호출한다
			이때 이벤트객체가 전달된다.
		 */
		//연결되었을때 ...
		webSocket.onopen = function(event) {
			wsOpen(event);
		}
		//메세지가 전송될때...
		webSocket.onmessage = function(event) {
			wsMessage(event);
		}
		//웹소켓이 닫혔을때
		webSocket.onclose = function(event) {
			wsClose(event);
		}
		//에러가 발생했을때
		webSocket.onerror = function(event) {
			wsError(event);
		}
	}
	function wsOpen(event) {
		messageWindow.value += "연결성공\n";
	}

	//서버로부터 Echo된 메세지를 클라이언트에서 출력
	function wsMessage(event) {
		//메세지 내용을 파이프로 split해서 배열로 만든다
		var message = event.data.split("|");
		
		var room = message[0]; //0번방: 룸정보
		var sender = message[1]; //1번방: 아이디
		var content = message[2]; //2번방: 메세지
		
		var msg;

		if (content == "") {

		} else {
			//같은 룸에있는 클라이언트에게만 메세지를 디스플래이한다
			if(chat_room==room){
				//보낸 메세지에 ...
				if (content.match("/")) {
					//슬러쉬가 포함되어있다면 명령어로 인식..
					if (content.match(("/" + chat_id))) {
						//귓속말 명령어를 한글로 대체한 후
						var temp = content.replace(("/" + chat_id), "[귓속말]: ");
						msg = makeBalloon(sender, temp);
						messageWindow.innerHTML += msg;
						messageWindow.scrollTop = messageWindow.scrollHeight;
					}
				} else {
					//귓속말이 아니면 모두에게 디스플레이한다
					msg = makeBalloon(sender, content);
					messageWindow.innerHTML += msg;
					messageWindow.scrollTop = messageWindow.scrollHeight;
				}
			}
		}
	}

	function makeBalloon(id, cont) {
		var msg = '';
		msg += '<div class="chat chat-left">';
		msg += '	<!--프로필 이미지 -->';
		msg += '	<span class="profile profile-img-b"></span>';
		msg += '	<div class="chat-box">';
		msg += '		<p style="font-weight:bold; font-size:1.1em; margin-bottom:5px;">'+id+'</p>';
		msg += '  		<p class="bubble">' +cont+ '</p>';
		msg += ' 		<span class="bubble-tail"></span>';
		msg += ' 	</div>';
		msg += '</div>';
		return msg;
	}

	function wsClose(event) {
		messageWindow.value += "연결끊기성공\n";
	}

	function wsError(event) {
		alert(event.data);
	}

	//웹소켓서버에 메세지를 보낸다.
	function sendMessage() {
		//메세지 입력후 전송할때 "채팅방+아이디+메세지" 형태로 조립해서 보낸다.
		webSocket.send(chat_room+'|'+chat_id + '|' + inputMessage.value);
		var msg = '';
		msg += '<div class="chat chat-right">';
		msg += ' <!--프로필 이미지-->';
		msg += ' <span class="profile profile-img-a"></span>';
		msg += '  <p class="bubble-me">' + inputMessage.value + '</p>';
		msg += '  <span class="bubble-tail"></span>';
		msg += ' </div>';
		msg += '</div>';

		messageWindow.innerHTML += msg;
		inputMessage.value = "";
		messageWindow.scrollTop = messageWindow.scrollHeight;
	}

	function enterkey() {
		if (window.event.keyCode==13) {
			sendMessage();
		}
	}
</script>
</head>
<link rel="stylesheet" href="css/default.css" />
<body>
	<div id="chat-wrapper">
		<header id="chat-header">
			<h1>채팅창 - 최강KOSMO61기</h1>
		</header>
		<input type="hid-den" id="chat_id" value="${param.chat_id }"style="border: 1px dotted red;" />
		<input type="hid-den" id="chat_room" value="${param.chat_room }"style="border: 1px dotted red;" />
		
		<div id="chat-container" class="chat-area"
			style="height: 500px; overflow: auto;">
			<%
				//for(int i=1 ; i<=30 ; i++){
			%>
			<!-- 왼쪽 채팅 -->
			<!-- <div class="chat chat-left">			
			<span class="profile profile-img-b"></span>
			<div class="chat-box">
				<p style="font-weight:bold;font-size:1.1em;margin-bottom:5px;">미르</p>
				<p class="bubble">낙자<br/>뭐해?</p>
				<span class="bubble-tail"></span>
			</div>
		</div> -->
			<!-- 오른쪽 채팅 -->
			<!-- <div class="chat chat-right">			
			<span class="profile profile-img-a"></span>
			<div class="chat-box">				
				<p class="bubble-me">그냥 쉬고있는 중ㅋ</p>
				<span class="bubble-tail"></span>
			</div>
		</div> -->
			<%
				//}
			%>
		</div>
		<footer id="chat-footer">
			<p class="text-area">
				<input type="text" id="inputMessage" onkeyup="enterkey();"
					style="width: 450px; height: 60px; font-size: 1.5em; border: 0px;" />
				<button type="button" onclick="sendMessage();">보내기</button>
			</p>
		</footer>
	</div>

</body>
</html>