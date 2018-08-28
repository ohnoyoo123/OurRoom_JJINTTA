<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입-step1  페이지</h1>
	<form action="joinForm_step2" method="post">
		<b>ID(e-mail)</b> <br> <input type="email" id="mId" name="mId"><br>
		<b>PASSWORD</b><br> <input type="password" id="mPw" name="mPw"><br>
		<b>NICKNAME</b><br> <input type="text" id="mNickname"
			name="mNickname"><br> <b>질문</b><br> <select
			id="mQuestion" name="mQuestion">
			<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
			<option value="2">졸업한 초등학교 이름은?</option>
			<option value="3">어머니 성함은?</option>
			<option value="4">아버지 성함은?</option>
		</select> <br> <b>답변</b><br> <input type="text" id="mAnswer"
			name="mAnswer"> <br> <br>
		<input type="button" onclick="history.go(-1)" value="취소">
		<input type="submit" value="다음">
	</form>
</body>
</html>