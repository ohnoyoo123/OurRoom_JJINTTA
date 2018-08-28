<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#innerFrame{
		background-color: yellow;
		display: inline-block;
		width: 96vw;
		
	}
</style>
</head>
<body>
<jsp:include page="../mainFrame.jsp"/>

	<div id = "innerFrame">
		프로젝트입니다.<br>
		projectList : ${projectList }<br>
		TaskList : ${taskList}
	</div>

</body>
</html>