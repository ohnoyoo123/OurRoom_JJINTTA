<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../mainFrame.jsp"/>

	<div style="display: inline-block;">
		프로젝트입니다.<br>
		projectList : ${projectList }<br>
		TaskList : ${taskList }
	</div>

</body>
</html>