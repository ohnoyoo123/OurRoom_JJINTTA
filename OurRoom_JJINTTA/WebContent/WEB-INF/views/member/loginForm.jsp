<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="login" method="post">
		<input type="text" id="mId" name="mId" placeholder="ID(e-mail)"><br> <input
			type="password" id="mPw" name="mPw" placeholder="PASSWORD"><br>
	<br>
	<input type="submit" value="로그인">
	<input type="button" onclick="location.href='joinForm_step1'" value="회원가입">
	</form>
</body>
</html>