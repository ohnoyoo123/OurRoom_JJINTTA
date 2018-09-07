<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css"
	type="text/css" />

<script type="text/javascript">  
	jQuery.browser = {};
	(function() {
		jQuery.browser.msie = false;
		jQuery.browser.version = 0;
		if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
			jQuery.browser.msie = true;
			jQuery.browser.version = RegExp.$1;
		}
	})();
</script>
<title>Insert title here</title>
<style type="text/css">
html, body {
	height: 96%;
}

#top {
	width: 100%;
	height: 50px;
	background-color: black;
	color: white;
	display: inline-block;
}

#left {
	width: 50px;
	background-color: black;
	height: 100%;
	padding-top: 50px;
	color: white;
	display: inline-block;
}

.topIcon {
	width: 50px;
	height: 50px;
	float: right;
	background-color: black;
	margin-right: 50px;
	font-size: 45px;
	color: white;
	cursor: pointer;
}

.topHome {
	width: 50px;
	height: 50px;
	background-color: black;
	margin: 0 auto;
	font-size: 45px;
	color: white;
	cursor: pointer;
}

.leftIcon {
	width: 50px;
	height: 50px;
	background-color: black;
	margin-bottom: 50px;
	font-size: 45px;
	color: white;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(function() {
		var wsUri = "ws://localhost:8080/OurRoom/websocket/echo";
		//var loginUser = '${loginUser.mId}';
		var loginUser = 'hong123@gmail.com';

		send_message();

		function send_message() {
			console.log("sendMessage");
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
			//writeToScreen("Connected to Endpoint!");
			doSend(loginUser);
		}
		// 서버 -> 클라이언트 메시지 도착
		function onMessage(evt) {
			console.log(evt.data);
			if (evt.data != 0) {
				$("#noti").html(evt.data);
			}
		}
		// 오류가 발생했을 때
		function onError(evt) {
			//writeToScreen('ERROR: ' + evt.data);
		}
		function doSend(message) {
			//writeToScreen("Message Sent: " + message); 
			websocket.send(message);
			//websocket.close();
		}
		function writeToScreen(message) {
			//var pre = document.createElement("p");
			//pre.style.wordWrap = "break-word";
			//pre.innerHTML = message;

		}
	});
</script>
<script>
	$(function() {
		/* 알림버튼을 클릭했을 때 
		   mId에 해당하는 모든 noti 가져오기*/
		$("#noti").on("click", function() {
			var searchNotis = [];
			
			$.ajax({
				url : "${pageContext.request.contextPath}/readAndGetNoti",
				data : {
					mId : 'hong123@gmail.com'
				},
				success : function(data) {
					console.log(data);
					$("#noti").html("");
					for(var i=0; i<data.length; i++){
			      		console.log(data[i].lCat);
			      		
			      		switch(data[i].lCat){
			      			// 프로젝트 생성
			      			//case 11:
			      			//	console.log(data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트를 생성했습니다.");
				      		//	searchNotis.push("<p>"+data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트를 생성했습니다.</p>");
			      			//	break;
				      		// 프로젝트 멤버추가
			      			case 13:
				      			console.log(data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트의 멤버로 초대하였습니다.");
				      			searchNotis.push("<p>"+data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트의 멤버로 초대하였습니다.</p>");
				      			break;
				      		// 프로젝트 멤버삭제
			      			case 14:
				      			console.log(data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트의 멤버에서 제외했습니다.");
				      			searchNotis.push("<p>"+data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트의 멤버에서 제외했습니다.</p>");
				      			break;
				      		// 이슈 생성
			      			case 31:
				      			console.log(data[i].mNickname+"("+data[i].mId+")님이 " + data[i].iName+" 이슈를 생성했습니다."); 
				      			searchNotis.push("<p>"+data[i].mNickname+"("+data[i].mId+")님이 " + data[i].iName+" 이슈를 생성했습니다.</p>");
				      			break;
				      		// 이슈 멤버 할당
				      		case 33:
				      			console.log(data[i].mNickname+"("+data[i].mId+")님이 " + data[i].iName+" 이슈를 할당했습니다."); 
				      			searchNotis.push("<p>"+data[i].mNickname+"("+data[i].mId+")님이 " + data[i].iName+" 이슈를 할당했습니다.</p>");
				      			break;
			      		}
						
						
			           /*  searchNotis.push("<p class='noti' mId="+data[i].mId+">"
			            		+"pNum="+data[i].pNum+", pName="+ data[i].pName+", "  +"("+data[i].mId+")</p>")   */
			        	  
			          }
					$("#output").html(searchNotis);
				}
			});
		});

	}); 
</script>
</head>
<body>
	<div id="output"></div>  
	<input id="loginUser" type="hidden" value="${loginUser.mId}" />
	<div id="top">
		<div class="topIcon"> 
			<span class="glyphicon glyphicon-log-out"></span>
		</div>
		<div class="topIcon">
			<span class="glyphicon glyphicon-bell" id="noti"></span> 

		</div>
		<div class="topIcon">
			<span class="glyphicon glyphicon-comment"></span>
		</div>
		<div class="topHome">
			<span class="glyphicon glyphicon-home"></span>
		</div>
	</div>
	<div id="left">
		<div class="leftIcon" onclick="location.href='/OurRoom/home'">
			<span class="glyphicon glyphicon-home"></span>
		</div>
		<div class="leftIcon" onclick="location.href='/OurRoom/project/pList'"> 
			<span class="glyphicon glyphicon-briefcase"></span>
		</div>
		<div class="leftIcon" onclick="location.href='/OurRoom/address'">
			<span class="glyphicon glyphicon-phone-alt"></span>
		</div>
		<div class="leftIcon" onclick="location.href='/OurRoom/myPage'">
			<span class="glyphicon glyphicon-user"></span>
		</div>
	</div>
</body>
</html>