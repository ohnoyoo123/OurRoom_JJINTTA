<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
hr.style5 {
	background-color: #fff;
	border-top: 2px dashed #8c8b8b;
}

hr.style13 {
	height: 10px;
	border: 0;
	box-shadow: 0 10px 10px -10px #8c8b8b inset;
}
</style>
<link rel="stylesheet" href="/OurRoom/css/modal.css">
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

   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.3/dist/semantic.min.css">
   <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.3/dist/semantic.min.js"></script>


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
#innerFrame {
    display: inline-block;
    width: 95%;
    position: absolute;
    margin: 10px;
  }


#top {
   width: 100%;
   height: 45px;
   background-color: #339933;
   color: white;
}

#left {
   width: 50px;
   background-color: white;
   height: 100%;
   padding-top: 50px;
   color: white;
   display: inline-block;
}

.topIcon {
   width: 50px;
   height: 40px;
   float: right;
   background-color: #339933;
   margin-right: 25px;
   font-size: 40px;
   color: #e6ffe6;
   cursor: pointer;
}

i::before{
   margin: 0px;
   padding: 0px;
}
</style>
<script type="text/javascript">
	$(function() {
		var wsUri = "ws://localhost:8080/OurRoom/websocket/echo";
		var loginUser = '${loginUser.mId}';
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
$(function(){
	$("#noti").on("click",function() {
	    console.log("33");
	    var searchNotis = [];
	
	    $.ajax({
	       url : "${pageContext.request.contextPath}/readAndGetNoti",
	       data : {
	          mId : '${loginUser.mId}'
	       },
	       success : function(data) {
	          console.log(data);
	          $("#noti").html("");
	          for (var i = 0; i < data.length; i++) {
	
	             console.log(data[i]);
	
	             var notiDefaultMsg = "<p style='text-align:left;'> <b> From. "
	                   + data[i].mNickname
	                   + "("
	                   + data[i].mId
	                   + ")</b> <br><br>";
	             var notiDetailMsg = "";
	
	             switch (data[i].lCat) {
	             // 프로젝트 생성
	             //case 11:
	             //   console.log(data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트를 생성했습니다.");
	             //   searchNotis.push("<p>"+data[i].mNickname+"("+data[i].mId+")님이 " + data[i].pName+" 프로젝트를 생성했습니다.</p>");
	             //   break;
	             // 프로젝트 멤버추가
	             case 13:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/gantt?pNum="
	                      + data[i].pNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 프로젝트의 멤버로 초대하였습니다.</p>";
	                break;
	             // 프로젝트 멤버삭제
	             case 14:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/gantt?pNum="
	                      + data[i].pNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 프로젝트의 멤버에서 제외했습니다.</p>";
	                break;
	             // 이슈 생성
	             case 31:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 이슈를 생성했습니다.</p>";
	                break;
	             // 이슈 멤버 할당
	             case 33:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 이슈를 할당하였습니다.</p>";
	                break;
	
	             case 41:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "&clNum="
	                      + data[i].clNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 체크리스트를 추가하였습니다.</p>";
	                break;
	             case 42:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "&clNum="
	                      + data[i].clNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 체크리스트를 삭제하였습니다.</p>";
	                break;
	             case 51:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "&clNum="
	                      + data[i].clNum
	                      + "&ciNum="
	                      + data[i].ciNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 체크리스트 아이템을 추가하였습니다.</p>";
	                break;
	             case 52:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "&clNum="
	                      + data[i].clNum
	                      + "&ciNum="
	                      + data[i].ciNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 체크리스트 아이템을 삭제하였습니다.</p>";
	                break;
	             case 53:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum
	                      + "&clNum="
	                      + data[i].clNum
	                      + "&ciNum="
	                      + data[i].ciNum
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 체크리스트 아이템을 할당하였습니다.</p>";
	                break;
	             case 61:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum               
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 이슈에 댓글을 남겼습니다.</p>";   
	                break;
	             case 63:
	                notiDetailMsg = "<a href='${pageContext.request.contextPath}/project/kanban2?pNum="
	                      + data[i].pNum
	                      + "&tNum="
	                      + data[i].tNum
	                      + "&iNum="
	                      + data[i].iNum               
	                      + "'>"
	                      + data[i].lName
	                      + "</a> 댓글을 참조했습니다.</p>";   
	                break;
	             }
	       
	             searchNotis.push(notiDefaultMsg
	                         + notiDetailMsg
	                         + "<h6> "
	                         + data[i].lTime
	                         + "</h6>"
	                         + "<hr class='style5'>");
	          }
	
	          $("#noti_div").html(searchNotis);
	          $("#notiModal").modal();
	       }         
	    });  
	 }); 
/* 로그아웃 처리 */
$("#logout").on("click", function() {
	console.log("close");
	location.href = "${pageContext.request.contextPath}/logout";
});
});
 </script>
</head> 
<body> 

	<%-- <fmt:parseDate value=""/>  --%>
	<input id="loginUser" type="hidden" value="${loginUser.mId}" />
	<div id="top">
   <h2 style="display:inline-block; vertical-align:bottom; cursor:pointer; margin-left:25px;" onclick="location.href='/OurRoom/home'">OurRoom</h2>		<div class="topIcon">
			<span class="glyphicon glyphicon-log-out" id="logout"></span>
		</div>
		
	      <div class="topIcon" onclick="location.href='/OurRoom/myPage'">
	         <i class="user icon"></i>
	      </div>
	
		<div class="topIcon">
			<span class="glyphicon glyphicon-bell" id="noti"></span>
		</div>
	      <div class="topIcon" onclick="location.href='/OurRoom/project/pList'">
	         <span class="glyphicon glyphicon-briefcase"></span>
	      </div>
    </div>

	<!-- 알림 modal -->
	<!-- <a class="btn btn-default" data-target="#notiModal" data-toggle="modal">알림모달버튼</a> -->
	<div class="row">
		<div class="modal right fade" id="notiModal" tabindex="-1"
			role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div class="modal-header" style="text-align: center">Notifications</div>
					<div class="modal-body" style="text-align: right">
						<div id="noti_div"></div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
