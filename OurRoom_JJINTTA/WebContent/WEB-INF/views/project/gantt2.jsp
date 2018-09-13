<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Gantt</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.5.1/snap.svg-min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.css"/>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.js.map"></script> --%>

<%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.min.css"/> --%>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
<script src="/OurRoom/js/frappe-gantt.js"></script>
<link rel="stylesheet" href="/OurRoom/js/frappe-gantt.css">
<style type="text/css">

#innerFrame {
	display: inline-block;
	width: 90vw;
}

#addTaskBtn {
	float: right;
}

#gantt{
	display: inline-block;
	/* height: 84vh; */
	float: left;

}
#sideTap{
	display: inline-block;
	float: left;
	width: 15vw;
	/* height: 84vh; */

}

#sideTap .table th{
	height: 59px;
	padding : 0;
	vertical-align: middle;
}

#sideTap .table td{
	height: 48px;
	padding : 0;
	vertical-align: middle;
}

#addTaskBtn, .addIssueBtn{
		float: right;
}

textarea {
	width: 100%;
	resize: none;
	overflow-y: hidden; /* prevents scroll bar flash */
	padding: 0.5em; /* prevents text jump on Enter keypress */
	line-height: 1.6;
}

#taskDetailModal_tNotiName{
	display: inline-block;
	min-width: 200px;
	min-height: 16px;
}

</style>

</head>

<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<div class="form-group" style="width:200px">
		  <select class="form-control" id="viewMode">
		  </select>
		</div>
		<div id="projectInfo"></div>
		<div id="sideTap"></div>
		<svg id="gantt"></svg>
	</div>

	<%-- 태스크 추가 모달 --%>
	<div class="modal fade" id="addTaskModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						태스크명: <input type="text" placeholder="enter task name" id="addTaskModal_tName">
					</h4>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<div>
						시작 : <br> <input type="text" class="datepicker" id="addTaskModal_tStartDate" disabled>
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker" id="addTaskModal_tEndDate" disabled>
					</div>
					태스크 설명
					<div id="addTaskModal_tDscrForm">
						<textarea id="addTaskModal_tDscr"></textarea>
					</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="addTaskModalConfirmBtn">Add</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


	<%-- 이슈 추가 모달 --%>
	<div class="modal fade" id="addIssueModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<p class="selectedTask"></p>
					</h2>
					<h4 class="modal-title">
						이슈명: <input type="text" placeholder="enter issue name" id="iName">
					</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div>
						이슈 설명
						<textarea id="addIssueModal_iDscr"></textarea>
					</div>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div>
						시작 : <br> <input type="text" class="datepicker iStartDate" readonly>
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker iEndDate" readonly>
					</div>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div>
						이슈 멤버 할당
					</div>
					<div>
						<c:forEach items="${projectMemberList}" var="member">
							<div class="selectMId" mId="${member.mId}">
								${member.mId}
							</div>
						</c:forEach>
						=====================
						<div id="selectedMId">
							할당된 멤버
						</div>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="addIssue">Add</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<%-- 태스크 상세보기 모달 --%>
	<div class="modal fade" id="TaskDetailModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						태스크명: <span id="taskDetailModal_tName"></span>
						<input type="text" id="taskDetailModal_tNameForm" autofocus>
					</h4>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<div>
						시작 : <br> <input type="text" class="datepicker" id="taskDetailModal_tStartDate" disabled>
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker" id="taskDetailModal_tEndDate" disabled>
					</div>
					태스크 설명
					<div id="taskDetailModal_tDscrForm">
						<textarea id="taskDetailModal_tDscr"></textarea>
						<button id="taskDetailModal_tDscrBtn">저장</button>
					</div>
					태스크 공지
					<div>
						공지 이름 :
						<span id="taskDetailModal_tNotiName"></span>
						<input type="text" id="taskDetailModal_tNotiNameForm">
						<textarea id="taskDetailModal_tNotiContent"></textarea>
						<button id="taskDetailModal_tNotiConfirmBtn">저장</button>
					</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


	<%-- 이슈 상세보기 모달 --%>
	<div class="modal fade" id="IssueDetailModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<p class="selectedTask"></p>
					</h2>
					<h4 class="modal-title">
						이슈명: <span id="IssueDetailModal_iName"></span>
						<input type="text" id="IssueDetailModal_iNameForm" autofocus>
					</h4>
					이슈 멤버 : <p id="issueMember"></p>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div>
						시작 : <br> <input type="text" class="datepicker" id="IssueDetailModal_iStartDate" readonly>
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker" id="IssueDetailModal_iEndDate" readonly>
					</div>
					이슈 설명
					<div id="IssueDetailModal_iDscrForm">
						<textarea id="IssueDetailModal_iDscr"></textarea>
						<button id="IssueDetailModal_iDscrBtn">저장</button>
					</div>
					======================================================================
					<h3>체크리스트<button id="addCheckListForm">+</button></h3>
					<div id="checkListNameForm"></div>
					<div id="checkListList"></div>
					======================================================================
					<h3>코멘트</h3>
					<div id="commentDiv">
						${loginUser.mNickname} : <input type="text" style="width:80%" id="IssueDetailModal_cmContent"><button id="IssueDetailModal_cmBtn">저장</button>
						<div id="commentArea">
						</div>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<%-- 숨겨진 이슈 상세보기 버튼 --%>
	<div id="issueDetailBtn" data-toggle="modal" data-target="#IssueDetailModal"></div>

	<%-- 숨겨진 태스크 상세보기 버튼 --%>
	<div id="taskDetailBtn" data-toggle="modal" data-target="#TaskDetailModal"></div>

	<%-- <script type="text/javascript" src="/OurRoom/js/gantt.js"> </script> --%>
	<script>
	$(function () {
	  $(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
	});

	$(document).ready(function () {

		console.log('==========================');
		let project = ${projectJson}
		console.log(project);
		let taskList = ${taskJson}
		console.log(taskList);
		let issueList = ${issueJson}
		console.log(issueList);
		console.log('==========================');

		let selectedTask = 0
		let selectedissue = 0
		let selCheckList = 0
		let selCheckListItem = 0
		let selMId = ''

		let selectedIssueDscr = ''

		let viewMode = ''

	class Project {
		constructor(id, name, start, end, progress){
			this.id = id
			this.name = name
			this.start = start
			this.end = end
			this.progress = progress
		}
	}

	class Task {
	  constructor(id, name, start, end, progress, custom_class) {
	    this.id = id
	    this.name = name
	    this.start = start
	    this.end = end
	    this.progress = progress
	    this.custom_class = custom_class
	  }
	}

	class Issue {
	  constructor(id, name, start, end, progress, custom_class) {
	    this.id = id
	    this.name = name
	    this.start = start
	    this.end = end
	    this.progress = progress
	    this.custom_class = custom_class
	  }
	}
	let taskAndIssue = []

	const makeGantt = (p, tList, iList) => {

		console.log(p);
		console.log(tList)
		console.log(iList)

		let projectProgress = 0;
		let taskProgress = 0;
		let issueProgress = 0;

		let count = 0;
		let length = 0;

		for(let i = 0; i < iList.length; i++ ){
			if(iList[i].iStep == 3 || iList[i].iStep == 4){
				count++
			}
		}

		projectProgress = (count / iList.length) * 100

		let tempProject = new Project('P_' + p.pNum + '', p.pName, p.pStartDate, p.pEndDate, projectProgress)
		taskAndIssue.push(tempProject)

		count = 0
		length = 0
	  for(let i = 0; i < tList.length; i++) {
			for(let j = 0; j < iList.length; j++){
				if(tList[i].tNum == iList[j].tNum){
					length++
					if(iList[j].iStep == 3 || iList[j].iStep == 4){
						count++
					}
				}
			}

			taskProgress = (count / length) * 100

	    let tempTask = new Task('T_' + tList[i].tNum + '', tList[i].tName, tList[i].tStartDate, tList[i].tEndDate, taskProgress, 'task')
	    taskAndIssue.push(tempTask)

	    for (let j = 0; j < iList.length; j++) {
	      if (tList[i].tNum == iList[j].tNum) {
					//태스크에 진행율을 넣어주고?
					//이슈는? 던이나 리뷰만 완료로?
	        let tempIssue = new Issue('I_' + iList[j].iNum + '_T_' + tList[i].tNum, iList[j].iName, iList[j].iStartDate, iList[j].iEndDate, 0, 'issue')
	        taskAndIssue.push(tempIssue)
	      }
	    }
	  }
	  console.log('makeGantt 실행');
	}
	console.log(taskAndIssue);
	makeGantt(project, taskList, issueList)

	let selTask = 0;
	let selIssue = 0;

	function stopEvent(event) {
		event.preventDefault();
		event.stopPropagation();
	}

	var gantt = new Gantt('#gantt', taskAndIssue, {
	  // can be a function that returns html or a simple html string
	  on_click: function (task) {
			if(task.id.charAt(0) == 'T'){
				//클릭한 녀석이 태스크
				selectedTask = task.id.split('_')[1]
				$('#taskDetailBtn').trigger('click')
			}else if (task.id.charAt(0) == 'I') {
				//클릭한 녀석이 이슈
				selectedTask = task.id.split('_')[3]
				console.log('dsadasdsadsadsadsadsads');
				console.log(selectedTask);
				selectedissue = task.id.split('_')[1]
				$('#issueDetailBtn').trigger('click')
			}
	  },
	  on_date_change: function (task, start, end) {
	    // console.log(task, start, end);
			if(task.id.charAt(0) == 'T'){
				//드래그한 녀석이 태스크
				// selectedTask = task.id.split('_')[1]
				//
				// tempStartDate = new Date(start)
				// tempStartDateString = ''
				// tempStartDateString += tempStartDate.getFullYear()
				// tempStartDateString += '-'
				// tempStartDateString += tempStartDate.getMonth()+1
				// tempStartDateString += '-'
				// tempStartDateString += tempStartDate.getDate()
				//
				// tempEndDate = new Date(end)
				// tempEndDateString = ''
				// tempEndDateString += tempEndDate.getFullYear()
				// tempEndDateString += '-'
				// tempEndDateString += tempEndDate.getMonth()+1
				// tempEndDateString += '-'
				// tempEndDateString += tempEndDate.getDate()
				//
				// data = {
				// 	pNum : ${project.pNum},
				// 	tNum : selectedTask,
				// 	tStartDate : tempStartDateString,
				// 	tEndDate :tempEndDateString
				// }
				// updateTask(data)
			}else if (task.id.charAt(0) == 'I') {
				//드래그한 녀석이 이슈
				selectedTask = task.id.split('_')[3]
				selectedissue = task.id.split('_')[1]

				tempStartDate = new Date(start)
				tempStartDateString = ''
				tempStartDateString += tempStartDate.getFullYear()
				tempStartDateString += '-'
				tempStartDateString += tempStartDate.getMonth()+1
				tempStartDateString += '-'
				tempStartDateString += tempStartDate.getDate()

				tempEndDate = new Date(end)
				tempEndDateString = ''
				tempEndDateString += tempEndDate.getFullYear()
				tempEndDateString += '-'
				tempEndDateString += tempEndDate.getMonth()+1
				tempEndDateString += '-'
				tempEndDateString += tempEndDate.getDate()

				data = {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedissue,
					iStartDate : tempStartDateString,
					iEndDate : tempEndDateString
				}
				updateIssue(data)
			}
	  },
	  on_progress_change: function (task, progress) {
	    console.log(task, progress);
	  },
	  on_view_change: function (mode) {
	    console.log(mode);
			$('.task').children('.handle-group').remove()
			$('.progress').remove()
		},

	});

		//간트 내부 좌단부 생성
		const sideTap = (p, t, i) => {
			console.log('sideTap 실행');
			let project = p
			let taskList = t
			let issueList = i
			txt = ''

			txt += '<table class="table table-bordered">'
			txt += '<tr>'
			txt += '<th>'
			txt += project.pName
			txt += '</th>'
			txt += '</tr>'
			txt += '<tr>'
			txt += '<td>'
			txt += project.pName
			txt += '<button id="addTaskBtn" class="btn" data-toggle="modal" data-target="#addTaskModal">+</button>'
			txt += '</td>'
			txt += '</tr>'
			for(let i = 0; i < taskList.length; i++){
				txt += '<tr>'
				txt += '<td><span onclick="location.href=\'/OurRoom/project/kanban2?pNum='
				txt += ${project.pNum}
				txt += '&tNum='
				txt += taskList[i].tNum
				txt += '\'">'
				txt += taskList[i].tName
				txt += '</span><button class="btn addIssueBtn" tNum="'
				txt += taskList[i].tNum
				txt += '" tName="'
				txt += taskList[i].tName
				txt += '" data-toggle="modal" data-target="#addIssueModal">+</button>'
				txt += '</td>'
				txt += '</tr>'
				for(let j = 0; j < issueList.length; j++){
					if(taskList[i].tNum == issueList[j].tNum){
						txt += '<tr>'
						txt += '<td>'
						txt += issueList[j].iName
						txt += '</td>'
						txt += '</tr>'
					}
				}
			}
			txt += '</table>'
			$('#sideTap').html(txt)
		}

		sideTap(project, taskList, issueList)


		//태스크 추가
	  $('#addTaskModalConfirmBtn').on('click', function () {
			console.log(${project.pNum});
			console.log($('#addTaskModal_tName').val());
			console.log($('#addTaskModal_tDscr').val());
			console.log($('#addTaskModal_tStartDate').val());
			console.log($('#addTaskModal_tEndDate').val());
			selectedMId = []
	    $.ajax({
	      url: 'addTask',
	      data: {
	        pNum: ${project.pNum},
	        tName: $('#addTaskModal_tName').val(),
					tDscr : $('#addTaskModal_tDscr').val(),
	        tStartDate: $('#addTaskModal_tStartDate').val(),
	        tEndDate: $('#addTaskModal_tEndDate').val(),
	      },
	      type: 'post',
	      success: (data) => {
	        console.log(data)
					project = data.projectJson
	        taskList = data.taskJson
	        issueList = data.issueJson
	        taskAndIssue = []

	        makeGantt(project, taskList, issueList)
	        gantt.refresh(taskAndIssue)
					sideTap(project, taskList, issueList)
	        $('.close').trigger('click')
					$('#tName').val('')
					$('.tStartDate').val('')
					$('.tEndDate').val('')
	      }
	    })
	  })


		//이슈에 멤버 할당
		selectedMId = []
		$('.selectMId').on('click', function(){
			console.log($(this).attr('mId'));
			if(!selectedMId.includes($(this).attr('mId'))){
				selectedMId.push($(this).attr('mId'))
				$('#selectedMId').html(selectedMId)
			}
		})

		//선택한 태스크 판별용 변수
		let selectedtNum = 0
		let selectedtName = ''

		//이슈 추가창 생성
		$(document).on('click', '.addIssueBtn', function(){
			console.log(selectedMId);
			selectedMId = []
			selectedtNum = $(this).attr('tNum')
			selectedtName = $(this).attr('tName')
			$('.selectedTask').html("태스크 이름 : " + selectedtName)
		})
		//이슈 추가
		$('#addIssue').on('click', () => {
			console.log('이슈 멤버들 제발 좀');
			console.log(selectedMId);
			$.ajax({
				url : 'addIssue',
				data : {
					pNum : ${project.pNum},
					tNum : selectedtNum,
					iName : $('#iName').val(),
					iDscr : $('#addIssueModal_iDscr').val(),
					iStep : 1,
					iStartDate : $('.iStartDate').val(),
					iEndDate : $('.iEndDate').val(),
					members : selectedMId
				},
				type : 'post',
				success : (data) => {
					console.log('이슈 추가 성공');
					console.log(data)
					$('#iName').val('')
					$('#addIssueModal_dscr').val('')
					$('.iStartDate').val('')
					$('.iEndDate').val('')
					$('#selectedMId').empty()
					selectedMId = []

					project = data.projectJson
					taskList = data.taskJson
					issueList = data.issueJson
					taskAndIssue = []

					makeGantt(project, taskList, issueList)
					gantt.refresh(taskAndIssue)
					sideTap(project, taskList, issueList)
					$('.close').trigger('click')


				}
			})
		})

		//코멘트 답글 생성
		const showReComment = (data, cmNum) => {
			for(let i = 0; i < data.commentList.length; i++){
				if(data.commentList[i].cmSuper == cmNum){
					txt += '<p cmNum="'
					txt += data.commentList[i].cmNum
					txt += '" mId="'
					txt += data.commentList[i].mId
					txt += '">'
					txt += '&emsp;┗&emsp;'
					txt += data.commentList[i].mId
					txt += ' : '
					txt += data.commentList[i].cmContent
					txt += ' : '
					txt += data.commentList[i].cmWriteTime
					if($('#loginUser').val() == data.commentList[i].mId){
						//답글 작성자가 본인이면 삭제 버튼 활성화
						txt += '<button class="IssueDetailModal_deleteCmBtn">삭제</button>'
					}

				}
			}
		}

		//코멘트 생성
		const showComment = (data) => {
			console.log(data.commentList)
			txt =''
			for(let i = 0; i < data.commentList.length; i++){
				if(data.commentList[i].cmSuper == 0){
					txt += '<p cmNum="'
					txt += data.commentList[i].cmNum
					txt += '" mId="'
					txt += data.commentList[i].mId
					txt += '">'
					txt += data.commentList[i].mId
					txt += ' : '
					txt += data.commentList[i].cmContent
					txt += ' : '
					txt += data.commentList[i].cmWriteTime
					if($('#loginUser').val() == data.commentList[i].mId){
						//답글 작성자가 본인이면 삭제 버튼 활성화
						txt += '<button class="IssueDetailModal_deleteCmBtn">삭제</button>'
					}
					txt += '<button class="IssueDetailModal_reCmFormBtn" IssueDetailModal_reCmFormBtn="0">답글</button>'
					txt += '</p>'
					showReComment(data, data.commentList[i].cmNum)
				}
			}
			$('#commentArea').html(txt)
		}

		//코멘트 답글폼 생성
		$(document).on('click', '.IssueDetailModal_reCmFormBtn', function(){
			console.log($(this).parent('p').attr('cmNum'));
			if($(this).attr('IssueDetailModal_reCmFormBtn') == 0){
				$(this).parent('p').append(`
					<input type="text" class="IssueDetailModal_reCmContent"><button class="IssueDetailModal_reCmConfirmBtn">저장</button>
					<button class="IssueDetailModal_reCmCancleBtn">취소</button>
					`)
					$(this).attr('IssueDetailModal_reCmFormBtn', '1')
			}
		})

		//코멘트 답글폼 삭제
		$(document).on('click', '.IssueDetailModal_reCmCancleBtn', function(){
			$(this).siblings('.IssueDetailModal_reCmFormBtn').attr('IssueDetailModal_reCmFormBtn', '0')
			$(this).parent('p').find('.IssueDetailModal_reCmContent').remove()
			$(this).parent('p').find('.IssueDetailModal_reCmConfirmBtn').remove()
			$(this).parent('p').find('.IssueDetailModal_reCmCancleBtn').remove()
		})

		//코멘트 답글 입력
		$(document).on('click', '.IssueDetailModal_reCmConfirmBtn', function () {
			console.log(${project.pNum});
			console.log(selectedTask);
			console.log(selectedIssue);
			console.log($(this).parent('p').attr('cmNum'));
			console.log($(this).siblings('.IssueDetailModal_reCmContent').val());

			$.ajax({
				url : 'addComment',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedIssue,
					mId : $('#loginUser').val(),
					cmContent : $(this).siblings('.IssueDetailModal_reCmContent').val(),
					cmSuper :  $(this).parent('p').attr('cmNum')
				},
				type : 'post',
				success : (data) => {
					showComment(data)
				}
			})
		})

		//코멘트 삭제
		$(document).on('click', '.IssueDetailModal_deleteCmBtn', function(){
			$.ajax({
				url : 'deleteComment',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedIssue,
					cmNum : $(this).parent('p').attr('cmNum')
				},
				type : 'post',
				success : (data) => {
					showComment(data)
				}
			})
		})


		// let selectedTask = 0
		// let selectedIssue = 0
		let issueMember = []

		//체크리스트 친구들 만들기
		const showCheckList = (data) =>{
			console.log('체크체크');
			console.log(data);
			let txt =''
					for (var i = 0; i < data.checkList.length; i++) {
						txt += '<div class=\'checkList\''
						txt += ' pNum=' + data.checkList[i].pNum
						txt += ' tNum=' + data.checkList[i].tNum
						txt += ' iNum=' + data.checkList[i].iNum
						txt += ' clNum=' + data.checkList[i].clNum
						txt += ' clName = ' + data.checkList[i].clName
						txt += '>'
						txt += '체크리스트 이름 : ' + data.checkList[i].clName
						txt +=  '<button style="float:right;" class="deleteCheckListBtn">X</button>'
						txt +=  '<button style="float:right;" class="addCheckListItemFormBtn">O</button><br>'
						txt += '<div class="addCheckListItemForm"></div>'
						txt += '======================================================================'
						for (var j = 0; j < data.checkListItem.length; j++) {
							if (data.checkList[i].clNum == data.checkListItem[j].clNum) {
								txt += '<div class="checkListItem" ciNum="' + data.checkListItem[j].ciNum + '">'
								txt += '&emsp;체크리스트 아이템 : ' + data.checkListItem[j].ciName + '<button class="deleteCheckListItemBtn">X</button>'
								if(data.checkList[i].clIsDone == 1){
									txt += '<input type="checkbox" class="form-check-input ci_checkbox" checked>완료<br>'
								}else {
									txt += '<input type="checkbox" class="form-check-input ci_checkbox">완료<br>'
								}
								for(var k = 0; k < data.checkListItemMember.length; k++){
									if(data.checkListItem[j].ciNum == data.checkListItemMember[k].ciNum){
										txt += data.checkListItemMember[k].mId
										txt += '<br>'
									}
								}
								txt += '----------------------------------------------------------------------------------------------------------------'
								txt += '</div>'
							}
						}
						txt += '</div>'
						txt += '</div>'
						txt += '</div>'
						txt += '<br>'
					}
					$('#checkListList').html(txt)
					$('#checkListNameForm').empty()
		}

		const updateCheckListItem = (data) => {
			console.log(data)
			$.ajax({
				url : 'updateCheckListItem',
				data : {
					pNum : ${project.pNum},
					tNum : data.tNum,
					iNum : data.iNum,
					clNum : data.clNum,
					ciNum : data.ciNum,
					ciName : data.ciName,
					ciIsDone : data.ciIsDone
				},
				type : 'post',
			})
		}


		$(document).on('click', '.ci_checkbox', function () {

			data = {
				tNum : selectedTask,
				iNum : selectedIssue,
				clNum : $(this).closest('.checkList').attr('clNum'),
				ciNum : $(this).closest('.checkListItem').attr('ciNum'),
				ciIsDone : $(this).prop('checked')
			}

			updateCheckListItem(data)

		})


		const showIssue = (data) => {
			console.log(data);
			selectedTask = data.issueList[0].tNum
			selectedIssue = data.issueList[0].iNum
			$('.selectedTask').html(data.issueList[0].tName)
			$('#IssueDetailModal_iName').html(data.issueList[0].iName)
			$('#IssueDetailModal_iDscr').html(data.issueList[0].iDscr)
			$('#IssueDetailModal_iStartDate').val(data.issueList[0].iStartDate)
			$('#IssueDetailModal_iEndDate').val(data.issueList[0].iEndDate)

			$('#issueMember').html('')
			for (var k = 0; k < data.issueMember.length; k++) {
				$('#issueMember').append(data.issueMember[k].mId).append(', ')
			}

			$('#issueDscr').html(data.issueList[0].iDscr)
			$('#IssueDetailModal_iDscrBtn').hide()
			$('#IssueDetailModal_iNameForm').hide()
			//이슈멤버 리스트
			issueMember = []
			issueMember = data.issueMember
			selectedIssueName = ''
			selectedIssueName = data.issueList[0].iName
			selectedIssueDscr = ''
			selectedIssueDscr = data.issueList[0].iDscr

		}


		//이슈 상세정보 보기
		$('#issueDetailBtn').on('click', () => {
			console.log('task');
			console.log(selectedTask);
			console.log('issue');
			console.log(selectedissue);

			$.ajax({
				url : 'issueDetail',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedissue
				},
				type : 'post',
				success : (data) => {
					console.log('성공');
					console.log(data);
					showIssue(data)
					showCheckList(data)
					showComment(data)

				}
			})
		})

		let selectedTaskDscr = ''

		const showTask = (data) => {
			console.log(data);
			$('#taskDetailModal_tName').show()
			$('#taskDetailModal_tNameForm').hide()
			$('#taskDetailModal_tDscrBtn').hide()
			$('#taskDetailModal_tNotiNameForm').hide()
			$('#taskDetailModal_tNotiConfirmBtn').hide()
			$('#taskDetailModal_tNotiName').show()
			selectedTaskName = data.taskList[0].tName
			selectedTaskDscr = data.taskList[0].tDscr
			selectedTaskNotiName = data.taskList[0].tNotiName
			selectedTaskNotiContent = data.taskList[0].tNotiContent
			$('#taskDetailModal_tName').html(data.taskList[0].tName)
			$('#taskDetailModal_tStartDate').val(data.taskList[0].tStartDate)
			$('#taskDetailModal_tEndDate').val(data.taskList[0].tEndDate)
			$('#taskDetailModal_tDscr').val(data.taskList[0].tDscr)
			$('#taskDetailModal_tNotiName').html(data.taskList[0].tNotiName)
			$('#taskDetailModal_tNotiContent').val(data.taskList[0].tNotiContent)

		}

		//태스크 이름 수정폼 생성
		$('#taskDetailModal_tName').on('click', () => {
			$('#taskDetailModal_tName').hide()
			$('#taskDetailModal_tNameForm').show().focus().val(selectedTaskName)
		})

		//태스크 이름 수정폼 삭제(포커스 잃을 시)
		$('#taskDetailModal_tNameForm').on('focusout', () => {
			$('#taskDetailModal_tName').show()
			$('#taskDetailModal_tNameForm').hide()
		})

		//태스크 이름 변경
		$('#taskDetailModal_tNameForm').keyup((e) => {
			if((e.keyCode || e.which) == 13){
				data = {
					tNum : seletedTask,
					tName : $('#taskDetailModal_tNameForm').val()
				}
				updateTask(data)
			}
		})

		//태스크 시작 날짜 변경
		$(document).on('change', '#taskDetailModal_tStartDate', () => {
			data = {
				tNum : seletedTask,
				tStartDate : $('#taskDetailModal_tStartDate').val()
			}
			updateTask(data)
		})

		//태스크 종료 날짜 변경
		$(document).on('change', '#taskDetailModal_tEndDate', () => {
			data = {
				tNum : seletedTask,
				tEndDate : $('#taskDetailModal_tEndDate').val()
			}
			updateTask(data)
		})

		//태스크 설명 변경이 있으면 저장 버튼 활성
		$('#taskDetailModal_tDscr').on('input propertychange', function() {
			if(selectedTaskDscr != $('#taskDetailModal_tDscr').val()){
				$("#taskDetailModal_tDscrBtn").show()
			}else {
				$("#taskDetailModal_tDscrBtn").hide()
			}
		})

		//태스크 설명 변경
		$('#taskDetailModal_tDscrBtn').on('click', () => {
			data = {
				tNum : seletedTask,
				tDscr : $('#taskDetailModal_tDscr').val()
			}
			updateTask(data)
		})

		//태스크 공지 이름 변경폼 생성
		$('#taskDetailModal_tNotiName').on('click', function(){
			$('#taskDetailModal_tNotiName').hide()
			$('#taskDetailModal_tNotiNameForm').show().focus().val(selectedTaskNotiName)
		})

		//태스크 공지 이름 변경
		$('#taskDetailModal_tNotiNameForm').keyup((e) => {
			if((e.keyCode || e.which) == 13){
				data = {
					tNotiName : $('#taskDetailModal_tNotiNameForm').val()
				}
				updateTask(data)
			}
		})

		//태스크 공지 내용 저장 버튼
		$('#taskDetailModal_tNotiContent').on('input propertychange', function() {
			if(selectedTaskNotiContent != $('#taskDetailModal_tNotiContent').val()){
				$("#taskDetailModal_tNotiConfirmBtn").show()
			}else {
				$("#taskDetailModal_tNotiConfirmBtn").hide()
			}
		})

		//태스크 공지 내용 저장
		$(document).on('click', '#taskDetailModal_tNotiConfirmBtn', () => {
			data = {
				tNotiContent : $('#taskDetailModal_tNotiContent').val()
			}
			updateTask(data)
		})



		//태스크 수정
		const updateTask = (data) => {
			console.log('updateTask')
			console.log(data)
			$.ajax({
				url : 'updateTask',
				data : {
					pNum : ${project.pNum},
					tNum : data.tNum,
					tOrder : data.tOrder,
					tName : data.tName,
					tDscr : data.tDscr,
					tStartDate : data.tStartDate,
					tEndDate : data.tEndDate,
					tNotiName : data.tNotiName,
					tNotiContent : data.tNotiContent
				},
				type : 'post',
				success : (data) => {
					showTask(data)
					$.ajax({
						url : 'projectReload',
						data : {
							pNum : ${project.pNum},
							// tNum : selectedTask
						},
						type : 'post',
						success : (data) => {
							project = data.projectJson
							taskList = data.taskJson
							issueList = data.issueJson
							taskAndIssue = []

							makeGantt(project, taskList, issueList)
							gantt.refresh(taskAndIssue)
							sideTap(project, taskList, issueList)

						}
					})
				}
			})
		}

		//리로드
		const projectReload = () => {
			$.ajax({
				url : 'projectReload',
				data : {
					pNum : ${project.pNum},
				},
				type : 'post',
				success : (data) => {
					project = data.projectJson
					taskList = data.taskJson
					issueList = data.issueJson
					taskAndIssue = []

					makeGantt(project, taskList, issueList)
					gantt.refresh(taskAndIssue)
					sideTap(project, taskList, issueList)

				}
			})

		}

		//태스크 상세정보 보기
		$('#taskDetailBtn').on('click', () => {
			console.log('태스크 상세');
			console.log(selectedTask);
			$.ajax({
				url : 'taskDetail',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
				},
				type : 'post',
				success : (data) => {
					showTask(data)
				}
			})
		})

		//체크리스트 추가폼 생성
		$(document).on('click', '#addCheckListForm', function () {
			var txt = ''
			txt += '<input type="text" id="checkListName"/>'
			txt += '<button id="addCheckListBtn">OK</button>'
			$('#checkListNameForm').html(txt)
		})

		//체크리스트 추가
		$(document).on('click', '#addCheckListBtn', () => {
			console.log(${project.pNum});
			console.log(selectedTask);
			console.log(selectedIssue);
			console.log($('#checkListName').val());
			$.ajax({
				url : 'addCheckList',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedIssue,
					clName : $('#checkListName').val()
				},
				type : 'post',
				success : function(data){
					console.log('체크리스트 추가 성공');
					console.log(data);
					showCheckList(data)
				}
			})
		})

		//체크리스트 아이템 추가 폼 생성
		$(document).on('click', '.addCheckListItemFormBtn', function(){
			singedCheckListItemMember = []

			txt =''
			txt += '<input type="text" id="addCheckListItemName">'
			txt += '<button id="addCheckListItemBtn">OK</button>'
			txt += '<br>'
			txt += '====이슈 할당 멤버===='
			for(let i = 0; i < issueMember.length; i++){
				txt += '<div class="unsignedCheckListItemMember" mId="'
				txt += issueMember[i].mId
				txt += '">'
				txt += issueMember[i].mId
				txt += '</div>'
			}
			txt += '====체크리스트 할당 멤버===='
			txt += '<div id="singedCheckListItemMember"></div>'
				$(this).parent().find('.addCheckListItemForm').html(txt)

		})
		//체크리스트 아이템 멤버 배열
		let singedCheckListItemMember = []

		//체크리스트 아이템 멤버 추가
		$(document).on('click', '.unsignedCheckListItemMember', function(){
			if(!singedCheckListItemMember.includes($(this).attr('mId'))){
				console.log(singedCheckListItemMember);
				singedCheckListItemMember.push($(this).attr('mId'))
				txt = ''
				for(let i = 0; i < singedCheckListItemMember.length; i++){
					txt += '<div mId="'
					txt += singedCheckListItemMember[i]
					txt += '">'
					txt += singedCheckListItemMember[i]
					txt += '</div>'
				}
				$('#singedCheckListItemMember').html(txt)
			}
		})



		//체크리스트 아이템 추가
		$(document).on('click', '#addCheckListItemBtn', function(){
			console.log(${project.pNum});
			console.log(selectedTask);
			console.log(selectedIssue);
			console.log($(this).parent('.checkList').attr('clNum'));
			$.ajax({
				url : 'addCheckListItem',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedIssue,
					clNum : $(this).parents('.checkList').attr('clNum'),
					ciName : $('#addCheckListItemName').val(),
					members : singedCheckListItemMember
				},
				type : 'post',
				success : function(data){
					console.log('체크리스트 아이템 추가 성공')
					console.log(data)
					$('.addCheckListItemForm').html('')
					showCheckList(data)
					singedCheckListItemMember = []
				}
			})
		})

		//체크리스트 삭제
		$(document).on('click', '.deleteCheckListBtn', function () {
			$(this).closest('.checkList').attr('clNum')
			if(confirm('삭제하시겠습니까?')){
				$.ajax({
				url : "deleteCheckList",
				data : {
					pNum: $(this).closest('.checkList').attr('pNum'),
					tNum: $(this).closest('.checkList').attr('tNum'),
					iNum: $(this).closest('.checkList').attr('iNum'),
					clNum : $(this).closest('.checkList').attr('clNum'),
				},
				type : "post",
				success : function (data) {
					showCheckList(data)
				}
			})
			}
		})

		//체크리스트 아이템 삭제
		$(document).on('click', '.deleteCheckListItemBtn', function(){
			if(confirm('삭제하시겠습니까?')){
				console.log(selectedTask);
				console.log(selectedIssue);
				console.log($(this).parents('.checkList').attr('clNum'))
				console.log($(this).parent().attr('ciNum'));
				$.ajax({
					url : 'deleteCheckListItem',
					data : {
						pNum : ${project.pNum},
						tNum : selectedTask,
						iNum : selectedIssue,
						clNum : $(this).parents('.checkList').attr('clNum'),
						ciNum : $(this).parent().attr('ciNum')
					},
					type : 'post',
					success : (data) => {
						showCheckList(data)
					}
				})
			}
	})

	//수정하기//

		const updateIssue = (data) => {
			console.log('updateIssue')
			console.log(data)
			$.ajax({
				url : 'updateIssue',
				data : {
					pNum : ${project.pNum},
					tNum : data.tNum,
					iNum : data.iNum,
					iStep : data.iStep,
					iOrder : data.iOrder,
					iName : data.iName,
					iDscr : data.iDscr,
					iStartDate : data.iStartDate,
					iEndDate : data.iEndDate,
					iImpr : data.iImpr
				},
				type : 'post',
				success : (data) => {
					console.log(data);
					showIssue(data)
					showCheckList(data)
					projectReload()
					matchDate_issueToTask()
				}
			})
		}

		//이슈 이름 변경폼
		$('#IssueDetailModal_iName').on('click', () => {
			$('#IssueDetailModal_iNameForm').show().focus().val(selectedIssueName)
			$('#IssueDetailModal_iName').hide()

		})

		//이슈 이름 변경폼 아웃포커스
		$(document).on('focusout', '#IssueDetailModal_iNameForm', () => {
			$('#IssueDetailModal_iNameForm').hide()
			$('#IssueDetailModal_iName').show()
		})

		//이슈 이름 변경
		$('#IssueDetailModal_iNameForm').keyup((e) => {
			if((e.keyCode || e.which) == 13){
				data = {
					tNum : selectedTask,
					iNum : selectedIssue,
					iName : $('#IssueDetailModal_iNameForm').val()
				}
				updateIssue(data)
			}
		})

		//이슈 시작 날짜 변경
		$(document).on('change', '#IssueDetailModal_iStartDate', () => {
			data = {
				tNum : selectedTask,
				iNum : selectedIssue,
				iStartDate : $('#IssueDetailModal_iStartDate').val()
			}
			updateIssue(data)
		})

		//이슈 종료 날짜 변경
		$(document).on('change', '#IssueDetailModal_iEndDate', () => {
			data = {
				tNum : selectedTask,
				iNum : selectedIssue,
				iEndDate : $('#IssueDetailModal_iEndDate').val()
			}
			updateIssue(data)
		})

		//이슈 설명 변경이 있으면 저장 버튼 활성
		$('#IssueDetailModal_iDscr').on('input propertychange', function() {
			if(selectedIssueDscr != $('#IssueDetailModal_iDscr').val()){
				$("#IssueDetailModal_iDscrBtn").show()
			}else {
				$("#IssueDetailModal_iDscrBtn").hide()
			}
		})

		//이슈 설명 변경
		$('#IssueDetailModal_iDscrBtn').on('click', () => {
			data = {
				tNum : selectedTask,
				iNum : selectedIssue,
				iDscr : $('#IssueDetailModal_iDscr').val()
			}
			updateIssue(data)
		})



		//코멘트 부

		//코멘트 입력
		$('#IssueDetailModal_cmBtn').on('click', () => {
			$.ajax({
				url : 'addComment',
				data : {
					pNum : ${project.pNum},
					tNum : selectedTask,
					iNum : selectedIssue,
					mId : $('#loginUser').val(),
					cmContent : $('#IssueDetailModal_cmContent').val(),
					cmSuper :  $(this).parent('p').attr('cmNum')
				},
				type : 'post',
				success : (data) => {
					$('#IssueDetailModal_cmContent').val('')
					showComment(data)
				}

			})

		})

		//코멘트 삭제
		$(document).on('click', '.IssueDetailModal_deleteCmBtn', function(){

		})

		//이슈 날짜 변경시 태스크 날짜 변경
		const matchDate_issueToTask = () => {
				$.ajax({
					url : 'matchDate',
					data : {
						pNum : ${project.pNum},
						tNum : selectedTask,
						iNum : selectedIssue
					},
					type : 'post',
					success : (innerData) => {
						console.log('이슈 날짜 변경했을 때?');
						console.log(innerData);
						newData = {
							tNum : selectedTask,
							tStartDate : innerData.minIStartDate.iStartDate,
							tEndDate : innerData.maxIEndDate.iEndDate
						}
						console.log('newData');
						console.log('=======================================================');
						console.log(newData);
						updateTask(newData)
					}
				})

		}

		//뷰모드 만들기
		gantt.change_view_mode('Day')
		viewMode = 'Day'

		txt = ''
		txt += '<option>Month</option>'
		txt += '<option>Week</option>'
		txt += '<option selected>Day</option>'

		$('#viewMode').html(txt)

		$('#viewMode').on('change', function(){
			if($(this).val() == 'Month'){
				gantt.change_view_mode('Month')
			}else if ($(this).val() == 'Week') {
				gantt.change_view_mode('Week')
			}else if ($(this).val() == 'Day') {
				gantt.change_view_mode('Day')
			}
		})

		//로그에서 넘어왔을 때 테스트용
		if(0){
			$('#IssueDetailModal').modal()
			${log.tNum}
			${log.iNum}
			$.ajax({
				url : 'issueDetail',
				data : {
					pNum : 41,
					tNum : 1,
					iNum : 1
				},
				type : 'post',
				success : (data) => {
					console.log('성공');
					console.log(data);
					showIssue(data)
					showCheckList(data)
					showComment(data)
				}
			})
		}



	})
	</script>

</body>
</html>
