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

	#addTask {
		width: 100%;
	}

</style>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
<script>
  $( function() {
    $( ".datepicker" ).datepicker();
  } );
</script>


</head>

<body>

		<jsp:include page="../mainFrame.jsp" />
		<div id="innerFrame">

			<table class="table table-bordered">
				<tr>
					<th>프로젝트 번호</th>
					<th>프로젝트 이름</th>
					<th>프로젝트 시작</th>
					<th>프로젝트 종료</th>
					<th rowspan="2"><button class="btn" id="addTask" data-toggle="modal" data-target="#addTaskModal">태스크 추가</button></th>
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
					<tr class="issues" pNum="${issue.pNum}" tNum="${issue.tNum}" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
						<td class="tNum">${issue.tNum}</td>
						<td class="iNum">${issue.iNum}</td>
						<td class="iStep">${issue.iStep}</td>
						<td class="iOrder">${issue.iOrder}</td>
						<td class="iName">${issue.iName}</td>
					</tr>
				</c:forEach>
			</table>
		</div>

	<div class="modal fade" id="issueModal">
			<div class="modal-dialog">
				<div class="modal-content">

				<!-- Modal Header -->
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" id="issueName">이슈 이름</h4>
						<div id="issueMember"></div>
					</div>

				<!-- Modal body -->
					<div class="modal-body"></div>
					<h3>체크리스트</h3>
					<div class="modal-body" id="checkListList"></div>

				<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

			</div>
			</div>
		</div>

	<div class="modal" id="addTaskModal">
			<div class="modal-dialog">
				<div class="modal-content">

				<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">
							태스크명:

						<input type="text" placeholder="enter task name" id="tName">
						</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

				<!-- Modal body -->
					<div class="modal-body">
						<div>
							시작 : <br>
							<input type="text" class="datepicker" id="tStartDate">
						</div>
						<div>
							종료 : <br>
							<input type="text" class="datepicker" id="tEndDate">
						</div>
					</div>

				<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-success" id="AddTask">Add</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

			</div>
			</div>
		</div>

	<script type="text/javascript">
			$(document).ready(function () {

			$('.issues').on('click', function () {
					$.ajax({
						url: "../project/issueDetail",
						data: {
							pNum: $(this).attr("pNum"),
							tNum: $(this).attr("tNum"),
							iNum: $(this).attr("iNum"),
						},
						type: "post",
						success: function (data) {
							$('#issueName').html(data.issue[0].iName)
							$('#issueMember').html('')
							for (var k = 0; k < data.issueMember.length; k++) {
								$('#issueMember').append(data.issueMember[k].mId).append(', ')
							}
							var txt = ''
							for (var i = 0; i < data.checkList.length; i++) {
								txt += '<div class=\'checkList\' clName = ' + data.checkList[i].clName + '>'
								txt += '체크리스트 이름 : ' + data.checkList[i].clName + '<br>'
								txt += '</div>'
								for (var j = 0; j < data.checkListItem.length; j++) {
									if (data.checkList[i].clNum == data.checkListItem[j].clNum) {
										txt += '<div>'
										txt += '&emsp;체크리스트 아이템 : ' + data.checkListItem[j].ciName + '<br>'
										txt += '</div>'
									}
								}

						}
							$('#checkListList').html(txt)
						}
					})
				})

			$(document).on('click', '.checkList', function () {
					alert($(this).attr('clName'))
				})

			$('#AddTask').on('click', function () {

				// const tName = $('#tName').val()
				// const tStart = new Date($('#tStartDate').val().split('/'))
				// const tEnd = new Date($('#tEndDate').val().split('/'))
				
				$.ajax({
					url : "../project/addTask",
					data : {
						pNum : ${project.pNum},
						tName : $('#tName').val(),
						tStartDate : new Date($('#tStartDate').val().split('/')),
						tEndDate : new Date($('#tEndDate').val().split('/'))

					},
					type : "post"
				})
				
				
			})



		})

	</script>
	</body>

</html>