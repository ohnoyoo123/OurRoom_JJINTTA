<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../mainFrame.jsp" />
	<!-- 2018. 8. 31. 시작 -->
	<h1>Home</h1>
	<br>
	<h2>프로젝트리스트</h2>
	<div>
		<table border="1">
			<tr>
				<th>pNum</th>
				<th>pName</th>
				<th>pStartDate</th>
				<th>pEndDate</th>
			</tr>
			<c:forEach var="project" items="${projectList }">
				<tr>
					<td>${project.pNum }</td>
					<td>${project.pName }</td>
					<td><fmt:formatDate value="${project.pStartDate }"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${project.pEndDate }"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<br>
	<h2>프로젝트 멤버 리스트</h2>
	<br>
	<div>
		<table border="1">
			<tr>
				<th>pNum</th>
				<th>mId</th>
				<th>pmIsAdmin</th>
				<th>pmIsAuth</th>
				<th>pmFav</th>
			</tr>
			<c:forEach var="projectMember" items="${projectMemberList }">
				<tr>
					<td>${projectMember.pNum }</td>
					<td>${projectMember.mId }</td>
					<td>${projectMember.pmIsAdmin }</td>
					<td>${projectMember.pmIsAuth }</td>
					<td>${projectMember.pmFav }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<h2>공지존재하는 태스크 리스트</h2>
	<br>
	<div></div>
	<h2>로그정보</h2>
	<br>
	<div></div>

</body>
</html>