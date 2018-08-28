<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
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

	<div id = "innerFrame">
	<h1><a href="프로젝트 추가 모달 ">프로젝트 추가</a></h1>
	<h2>즐겨찾기 프로젝트</h2>
		<c:forEach items="${pmList}" var="pm">
			<c:if test="${pm.pmFav}">
				<c:forEach items="${progProject}" var="pList">
					<c:if test="${pList.pNum==pm.pNum }">						
						<a onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</a>
					</c:if>
					<br>
				</c:forEach>			
			</c:if>
		</c:forEach>
	<h2>진행중인 프로젝트</h2>
		<c:forEach items="${pmList}" var="pm">
			<c:if test="${!pm.pmFav}">
				<c:forEach items="${progProject}" var="pList">
					<c:if test="${pList.pNum==pm.pNum }">
						<a onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</a>
					</c:if>
					<br>
				</c:forEach>			
			</c:if>
		</c:forEach>
	<h2>종료된 프로젝트</h2>
		<c:forEach items="${pastProject }" var="past">
			<a onclick="location.href='gantt?pNum=${past.pNum }'">${past.pName }</a>
			<br>
		</c:forEach>
		
	</div>

</body>
</html>