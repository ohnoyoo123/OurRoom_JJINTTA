<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
						alert("로그인 성공!!! 추카포카리스웨트~");
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
</script>
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="login" method="post">
		<input type="text" id="mId" name="mId" placeholder="ID(e-mail)">
		<br> <input type="password" id="mPw"
			name="mPw" placeholder="PASSWORD"><br> <b id="memberCheckMsg"></b>
		<br> <input id="loginBtn" type="button" value="로그인"> <input
			type="button" onclick="location.href='joinForm_step1'" value="회원가입">
	</form>
</body>
</html>