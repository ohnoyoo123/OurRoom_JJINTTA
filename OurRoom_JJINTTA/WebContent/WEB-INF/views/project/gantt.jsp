<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gantt</title>
<style type="text/css">
#innerFrame {
	display: inline-block;
	width: 90vw;
}

</style>

</head>

<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<table class="table">
			<tr>
				<th>프로젝트 번호</th>
				<th>프로젝트 이름</th>
				<th>프로젝트 시작</th>
				<th>프로젝트 종료</th>
			</tr>
			<tr>
				<td>${project.pNum}</td>
				<td>${project.pName}</td>
				<td>${project.pStartDate}</td>
				<td>${project.pEndDate}</td>
			</tr>
		</table>

		<table class="table">
			<tr>
				<th>태스크 번호</th>
				<th>태스크 순서</th>
				<th>태스크 이름</th>
			</tr>
			<c:forEach items="${taskList}" var="task">
				<tr>
					<td>${task.tNum}</td>
					<td>${task.tOrder}</td>
					<td>${task.tName}</td>
				</tr>
			</c:forEach>
		</table>

		<table class="table">
			<tr>
				<th>태스크 번호</th>
				<th>이슈 번호</th>
				<th>이슈 단계</th>
				<th>이슈 순서</th>
				<th>이슈 이름</th>
			</tr>
			<c:forEach items="${issueList}" var="issue">
				<tr class="issues" pNum="${issue.pNum}" tNum="${issue.tNum}" iNum="${issue.iNum}"  data-toggle="modal" data-target="#issueModal">
					<td class = "tNum">${issue.tNum}</td>
					<td class = "iNum">${issue.iNum}</td>
					<td class = "iStep">${issue.iStep}</td>
					<td class = "iOrder">${issue.iOrder}</td>
					<td class = "iName">${issue.iName}</td>
				</tr>
			</c:forEach>
		</table>
	</div>


	<div class="modal fade" id="issueModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="issueName"></h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">Modal body..</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<script type="text/javascript">
				$(document).ready(function () {

					$('.issues').on('click', function(){
						
						$.ajax({
							url : "../project/issueDetail",
							data : {
								pNum : $(this).attr("pNum"),
								tNum : $(this).attr("tNum"),
								iNum : $(this).attr("iNum")
							},
							type : "post"
						})
					})


				})

			</script>
</body>

</html>