<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../mainFrame.jsp" />
	<!-- 2018. 8. 31. 시작 -->
	<h1>Home</h1><br>
	 <h2>프로젝트리스트</h2>
	<div>${projectList }</div><br>
	<h2>프로젝트 멤버 리스트</h2><br>
	<div>${projectmemberList }</div>
	<h2>공지존재하는 태스크 리스트</h2><br>
	<div>${projectmemberList }</div>
	<h2>로그정보</h2><br>
	<div>${projectmemberList }</div>
	
</body>
</html>