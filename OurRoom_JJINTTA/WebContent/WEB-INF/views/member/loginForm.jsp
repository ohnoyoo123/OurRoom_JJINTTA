<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a {
	color: #000;
}

.mask {
	width: 100%;
	height: 100%;
	position: fixed;
	left: 0;
	top: 0;
	z-index: 10;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
}

#modalLayer {
	display: none;
	position: relative;
}

#modalLayer2 {
	display: none;
	position: relative;
}

#modalLayer .modalContent, #modalLayer2 .modalContent2 {
	width: 440px;
	height: 300px;
	padding: 20px;
	border: 1px solid #ccc;
	position: fixed;
	left: 50%;
	top: 50%;
	z-index: 11;
	background: #fff;
}

.modalContent_inner_div {
	text-align: center;
}

/* .modalContent_inner_div2 {
	text-align: center;
} */

#modalLayer .modalContent button {
	position: absolute;
	right: 0;
	top: 0;
	cursor: pointer;
}

#modalLayer2 .modalContent2 button {
	position: absolute;
	right: 0;
	top: 0;
	cursor: pointer;
}
</style>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#loginBtn").on("click", function() {
			// 회원 여부 체크
			$.ajax({
				url : "loginMemberCheck",
				async : false,
				data : {
					mId : $("#mId").val(),
					mPw : $("#mPw").val()
				},
				success : function(result) {
					if (result) {
						$("form").submit();
					} else {
						$("#memberCheckMsg").css("color", "red");
						$("#memberCheckMsg").html("회원정보를 잘못 입력하셨습니다.");
					}
				},
				error : function(result) {
					$("#memberCheckMsg").html("에러..." + result);
				}
			});
		});

	});

	$(document).ready(function() {

		var modalLayer = $("#modalLayer");
		var modalLink = $(".modalLink");
		var modalCont = $(".modalContent");

		var modalLayer2 = $("#modalLayer2");

		var marginLeft = modalCont.outerWidth() / 2;
		var marginTop = modalCont.outerHeight() / 2;

		modalLink.click(function() {
			modalLayer.fadeToggle("slow");
			modalCont.css({
				"margin-top" : -marginTop,
				"margin-left" : -marginLeft
			});
			$(this).blur();
			$(".modalContent > a").focus();
			return false;
		});

		$("#cancelBtn").on("click", function() {
			modalLayer.fadeOut("slow");
			modalLink.focus();
		});

		/* 비밀번호 찾기 요청 */
		$("#pwQ_nextBtn").on("click", function() {

			modalLayer.fadeOut("fast");

			$.ajax({
				url : "forgetPw",
				async : false,
				data : {
					mId : $("#pwQ_mId").val(),
					mQuestion : $("#pwQ_mQuestion").val(),
					mAnswer : $("#pwQ_mAnswer").val()
				},
				success : function(result) {
					if (result) {
						// 비밀번호 변경 모달창띄우기
						inputPw();
					}
				},
				error : function(result) {

				}

			});
		});

		/* 비밀번호 변경 요청 */
		$("#updateBtn").on("click", function() {

			var pw = $("#update_mPw").val();
			var pw2 = $("#update_mPw2").val();
	
			// 
			if(!chkPw2(pw,pw2)){
				return;
			}
			
			if(pw != pw2){
				return;
			}
			
			$.ajax({
				url : "updatePw",
				async : false,
				data : {
					mId : $("#pwQ_mId").val(),
					mPw : $("#update_mPw").val()
				},
				success : function(result) {
					if (result) {
						alert("비밀번호가 수정되었습니다.");
						location.reload();
					}
				},
				error : function(result) {
				}
			});
		});
	});
	function inputPw() {
		var marginLeft = $(".modalContent2").outerWidth() / 2;
		var marginTop = $(".modalContent2").outerHeight() / 2; 

		$("#modalLayer2").fadeToggle("slow");
		$(".modalContent2").css({
			"margin-top" : -marginTop,
			"margin-left" : -marginLeft
		});

		$(".modalContent > a").focus();
		return false;
	};
	
	/* PW Check */
	function chkPw(str){
		
		 var strPw = $.trim(str);
		 var num = strPw.search(/[0-9]/g);
		 var eng = strPw.search(/[a-z]/ig);
		 var spe = strPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		 
		 if(strPw.length < 8 || strPw.length > 20){

			$("#pwCheckMsg").css("color", "red"); 
			$("#pwCheckMsg").html("8자 이상, 20자 이하로 입력하세요");
			return false;
		 }
		 if(strPw.search(/₩s/) != -1){
			$("#pwCheckMsg").css("color", "red");
			$("#pwCheckMsg").html("비밀번호는 공백없이 입력해주세요.");
			return false;
		 } 
		 if(num < 0 || eng < 0 || spe < 0 ){
			$("#pwCheckMsg").css("color", "red");
			$("#pwCheckMsg").html("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
			return false;
		 }

		$("#pwCheckMsg").css("color", "green");
		$("#pwCheckMsg").html("사용 가능합니다.");
			
		return true;

	}
	
	// mPw와 mPw2가 같은지 비교
	 function chkPw2(pw,pw2) {
     
       if(!chkPw(pw)){
			$("#pw2CheckMsg").html("");
       	return false;
       }
       
       if (pw != pw2) {
       	$("#pw2CheckMsg").css("color", "red");
			$("#pw2CheckMsg").html("비밀번호가 다릅니다.");
           return false;
       }else{
       	$("#pw2CheckMsg").css("color", "green");
			$("#pw2CheckMsg").html("사용 가능합니다.");
           return true;
       }
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="home" method="post">
		<input type="text" id="mId" name="mId" placeholder="ID(e-mail)">
		<br> <input type="password" id="mPw" name="mPw"
			placeholder="PASSWORD"><br> <b id="memberCheckMsg"></b>
		<br> <input id="loginBtn" type="button" value="로그인"> <input
			type="button" onclick="location.href='joinForm_step1'" value="회원가입">
	</form>

	<!-- 비밀번호 찾기 모달 -->
	<a href="modalLayer" class="modalLink">비밀번호가 기억나지 않으세요?</a>
	<div id="modalLayer">
		<div class="modalContent">
			<div class="modalContent_inner_div">
				<h1>비밀번호 찾기</h1>
				<hr>

				<b>아이디(E-mail)</b> <br> <input type="text" id="pwQ_mId"
					name="mId"> <br> <b>질문</b><br> <select
					id="pwQ_mQuestion" name="mQuestion">
					<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
					<option value="2">졸업한 초등학교 이름은?</option>
					<option value="3">어머니 성함은?</option>
					<option value="4">아버지 성함은?</option>
				</select> <br> <b>답변</b><br> <input type="text" id="pwQ_mAnswer"
					name="mAnswer"><br> <br> <input type="button"
					id="cancelBtn" value="취소"> <input type="button"
					id="pwQ_nextBtn" value="다음">

			</div>
		</div>
	</div>

	<!-- 비밀번호 변경 모달 -->
	<div id="modalLayer2">
		<div class="modalContent2">
			<div class="modalContent_inner_div2">
				<h1>비밀번호 변경</h1>
				<hr>

				<b>비밀번호</b> <br> <input type="password" id="update_mPw"><b id="pwCheckMsg"></b> <br>
				<b>비밀번호 재입력</b><br> <input type="password" id="update_mPw2"><b id="pw2CheckMsg"></b><br>
				<br> <input type="button" id="updateBtn" value="수정">

			</div>
		</div>
	</div>
</body>
</html>