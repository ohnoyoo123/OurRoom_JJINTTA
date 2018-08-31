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
			<!-- 프로젝트 정보 -->
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
			<!-- 태스크 정보 -->
		<c:if test="${taskList != null}">
			<table class="table">
				<tr>
					<th>태스크 번호</th>
					<th>태스크 순서</th>
					<th>태스크 이름</th>
					<th>태스크 시작</th>
					<th>태스크 종료</th>
					<th>태스크 삭제</th>
					<th>이슈 추가</th>
				</tr>
				<c:forEach items="${taskList}" var="task">
					<tr>
						<td>${task.tNum}</td>
						<td>${task.tOrder}</td>
						<td>${task.tName}</td>
						<td>${task.tStartDate}</td>
						<td>${task.tEndDate}</td>
						<td><button class="deleteTask" tNum="${task.tNum}">X</button></td>
						<td><button class="addIssue" data-toggle="modal" data-target="#addIssueModal" tNum="${task.tNum}">O</button></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>

		<!-- 이슈 정보 -->
		<c:if test="${issueList != null}">
		<table class="table" id="taskTable">
				<tr>
					<th>태스크 번호</th>
					<th>이슈 번호</th>
					<th>이슈 단계</th>
					<th>이슈 순서</th>
					<th>이슈 이름</th>
					<th>이슈 삭제</th>
				</tr>
				<c:forEach items="${issueList}" var="issue">
					<tr class="issues" pNum="${issue.pNum}" tNum="${issue.tNum}" iNum="${issue.iNum}">
						<td class="tNum">${issue.tNum}</td>
						<td class="iNum">${issue.iNum}</td>
						<td class="iStep">${issue.iStep}</td>
						<td class="iOrder">${issue.iOrder}</td>
						<td class="iName"><p data-toggle="modal" data-target="#issueModal" class="issueDet">${issue.iName}</p></td>
						<td><button class="deleteIssue">X</button></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>	
		</div>

	<!-- 이슈 상세보기 모달 -->
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

	<!-- 태스크 추가 모달 -->
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
						태스트 설명<br>
						<textarea style="width: 100%; resize: none" id="tDscr"></textarea>
					</div>

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
						<button type="button" class="btn btn-success" id="addTaskConfirm">Add</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal" id="taskModalClose">Close</button>
					</div>

			</div>
			</div>
		</div>

		<!-- 이슈 추가 모달 -->
		<div class="modal" id="addIssueModal">
				<div class="modal-dialog">
					<div class="modal-content">
	
					<!-- Modal Header -->
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">
								이슈:<br>
							<input type="text" placeholder="enter issue name" id="iName">
							</h4>
						</div>
	
					<!-- Modal body -->
						<div class="modal-body">
							팀원 할당 : <br>
							<c:forEach items="${projectMemberList}" var="pm">
								<div class="selectedMId" mId=${pm.mId}>
									${pm.mId}
								</div>
							</c:forEach>
						</div>
							할당된 팀원 : <br>
						<div class="modal-body" id = "assignedMember">

						</div>
						<div class="modal-body" id="selectedMId">

						</div>
	
	
						<div class="modal-body">
							<div>
								시작 : <br>
								<input type="text" class="datepicker" id="iStartDate">
							</div>
							<div>
								종료 : <br>
								<input type="text" class="datepicker" id="iEndDate">
							</div>
						</div>
	
					<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-success" id="addIssueConfirm">Add</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal" id="issueModalClose">Close</button>
						</div>
	
				</div>
				</div>
			</div>
	

	<script type="text/javascript">
			$(document).ready(function () {
			
			//이슈 상세보기
			$(document).on('click', '.issueDet', function () {
					console.log(12312);
					
					$.ajax({
						url: "../project/issueDetail",
						data: {
							pNum: $(this).closest('.issues').attr("pNum"),
							tNum: $(this).closest('.issues').attr("tNum"),
							iNum: $(this).closest('.issues').attr("iNum"),
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

			//태스크 추가
			$('#addTaskConfirm').on('click', function () {
				
				$.ajax({
					url : "../project/addTask",
					data : {
						pNum : ${project.pNum},
						tOrder : ${taskList.size()} + 1,
						tName : $('#tName').val(),
						tDscr : $('#tDscr').val(),
						tStartDate : function () {
							if($('#tStartDate').val().length > 0){
								return $('#tStartDate').val()
							}else{
								return new Date
							}
						},
						tEndDate : function () {
							if($('#tEndDate').val().length > 0){
								return $('#tEndDate').val()
							}else{
								return new Date
							}
						}
					},
					type : "post",
					success : function () {
						location.reload()
					}
				})
				
				
			})
			
			//태스크 삭제
			$('.deleteTask').on('click', function () {
				if(confirm('삭제하시겠습니까?')){
					$.ajax({
						url : "deleteTask",
						data : {
							pNum : ${project.pNum},
							tNum : $(this).attr("tNum")
						},
						type : "post",
						success : function () {
							location.reload()
						}
					})
				}
				
			})

			//이슈 맴버 할당
			var selectedMId = []
			$('.selectedMId').on('click', function () {
				if(!selectedMId.includes($(this).attr("mId"))){
					selectedMId.push($(this).attr("mId"))
					$('#assignedMember').html(selectedMId)
					
				}
				console.log(selectedMId);
				
			})

			//선택한 태스크 정보 불러오기
			var selectedTask;
			$('.addIssue').on('click', function () {
				selectedTask = $(this).attr('tNum')
			})

			//이슈 추가하기
			$(document).on('click', '#addIssueConfirm', function () {
				
				var array = []
				for(var i = 0; i < selectedMId.length; i++){
					array.push(i)
				}
				
				$.ajax({
					url : "addIssue",
					data : {
						pNum : ${project.pNum},
						tNum : selectedTask,
						iStep : 1,
						iName : $('#iName').val(),
						iStartDate : function () {
							if($('#iStartDate').val().length > 0){
								return $('#iStartDate').val()
							}else{
								return new Date
							}
						},
						iEndDate : function () {
							if($('#iEndDate').val().length > 0){
								return $('#iEndDate').val()
							}else {
								return new Date
							}
						},
						members : selectedMId
					},
					type : "post",
					success : function () {
						location.reload()
					}

				})
			})
			
			//이슈 삭제
			$('.deleteIssue').on('click', function () {
				console.log($(this).closest('.issues').attr('tNum'))
				
				if(confirm('삭제하시겠습니까?')){
					$.ajax({
						url : "deleteIssue",
						data : {
							pNum : ${project.pNum},
							tNum : $(this).closest('.issues').attr('tNum'),
							iNum : $(this).closest('.issues').attr('iNum'),
						},
						type : "post",
						success : function () {
							location.reload()
						}
					})
				}
				
			})

			
			
		})

	</script>
	</body>

</html>