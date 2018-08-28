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
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addProject">
  	프로젝트 추가
	</button>
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
	
	<!-- The Modal -->
	<div class="modal" id="addProject">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">
	       		 프로젝트명:
	        	<input type="text" placeholder="enter project name">
	        </h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        	팀원 초대:
	        	<input type="text" placeholder="enter email or nickname">
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	

</body>
</html>