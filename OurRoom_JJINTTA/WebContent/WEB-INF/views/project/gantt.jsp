<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#innerFrame{
		background-color: yellow;
		display: inline-block;
		width: 96%;
		
	}
</style>

</head>
<body>
<jsp:include page="../mainFrame.jsp"/>
	<div id="innerFrame">
		project : ${project}<br>
		taskList : ${taskList }<br>
		issueList : ${issueList}
	</div>


</body>
</html>