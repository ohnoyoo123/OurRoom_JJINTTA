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
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
<script src="/OurRoom/js/frappe-gantt.js"></script>
<link rel="stylesheet" href="/OurRoom/js/frappe-gantt.css">
<link rel="stylesheet" href="/OurRoom/css/gantt.css">

</head>

<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<div class="form-group" style="width:200px;">
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
					<h6 class="modal-title">
						<input type="text" placeholder="이슈명: enter issue name" id="iName">
					</h6>
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
						시작 : <br> <input type="text" class="datepicker" id="addIssueModal_iStartDate" readonly>
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker" id="addIssueModal_iEndDate"readonly>
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

	<%-- 프로젝트 상세보기 모달 --%>
	<div class="modal fade" id="projectDetailModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">
							프로젝트명 :<br>
							<span id="projectDetailModal_pName"></span>
							<input type="text" id="projectDetailModal_pNameForm" autofocus>
						</h4>
				</div>

				<!-- Modal Body -->
				<div class="modal-body">
					<div>
					시작 : <br> <input type="text" class="datepicker" id="projectDetailModal_pStartDate" readonly>
					</div>
					<div>
					종료 : <br> <input type="text" class="datepicker" id="projectDetailModal_pEndDate"readonly>
					</div>
					===========
					할당되어 있는 멤버들
					<div id="projectDetailModal_assingedMember">

					</div>

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
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

	<%-- 숨겨진 태스크 상세보기 버튼 --%>
	<div id="projectDetailBtn" data-toggle="modal" data-target="#projectDetailModal"></div>

	<%-- <script type="text/javascript" src="/OurRoom/js/gantt.js"> </script> --%>
	<script>
	$(function () {
	  $(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
	});

	$(document).ready(function () {

		const rainbow2 = []
		//빨강
		rainbow2.push('#ff9999')
		//주황
		rainbow2.push('#ffdb99')
		//노랑
		rainbow2.push('#ffff99')
		//초록
		rainbow2.push('#99ff99')
		//파랑
		rainbow2.push('#9999ff')
		//남색
		rainbow2.push('#d499ff')
		//보라
		rainbow2.push('#ff99ff')

		const dynamicColors2 = function(num) {
			 colors = []
			 let index = 0
			 for(let i = 0; i < num; i++){
				 index = i % 7
				 colors.push(rainbow2[index])
			 }
			 return colors
		};


		let project = ${projectJson}
		let taskList = ${taskJson}
		let issueList = ${issueJson}
		let projectMemberList = ${projectMemberJson}

		let selectedTask = 0
		let selectedissue = 0
		let selCheckList = 0
		let selCheckListItem = 0
		let selMId = ''

		let selectedIssueDscr = ''

		let viewMode = ''

	class Project {
		constructor(id, name, start, end, progress, custom_class){
			this.id = id
			this.name = name
			this.start = start
			this.end = end
			this.progress = progress
			this.custom_class = custom_class
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

		let tempProject = new Project('P_' + p.pNum + '', p.pName, p.pStartDate, p.pEndDate, projectProgress, 'project')
		taskAndIssue.push(tempProject)

	  for(let i = 0; i < tList.length; i++) {
			count = 0
			length = 0
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

	const gantt = new Gantt('#gantt', taskAndIssue, {
	  // can be a function that returns html or a simple html string
	  on_click: function (task) {
			if(task.id.charAt(0) == 'P'){
				$('#projectDetailBtn').trigger('click')
			}else if(task.id.charAt(0) == 'T'){
				//클릭한 녀석이 태스크
				selectedTask = task.id.split('_')[1]
				$('#taskDetailBtn').trigger('click')
			}else if (task.id.charAt(0) == 'I') {
				//클릭한 녀석이 이슈
				selectedTask = task.id.split('_')[3]
				selectedissue = task.id.split('_')[1]
				$('#issueDetailBtn').trigger('click')
			}
	  },
	  on_date_change: function (task, start, end) {
	    // console.log(task, start, end);
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

			if(task.id.charAt(0) == 'P'){

				data = {
					pStartDate : tempStartDateString,
					pEndDate : tempEndDateString
				}
				updateProject(data)

			}else if(task.id.charAt(0) == 'T'){
				selectedTask = task.id.split('_')[1]

			}else if (task.id.charAt(0) == 'I') {
				//드래그한 녀석이 이슈
				selectedTask = task.id.split('_')[3]
				selectedissue = task.id.split('_')[1]

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

			//프로젝트 바
			$('.gantt .project .bar-progress').css({
			})

			//태스크 바
			$('.gantt .task .bar-progress').each(function(i){
				$(this).css('fill', rainbow2[i%7])
			})

			//이슈 바
			$('.gantt .issue').each(function(i){
				$(this).find('.bar').css({
					'fill' : $(this).prevAll('.task:first').find('.bar-progress').css('fill'),
					'opacity' : '0.5'
				})
			})
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

			for(let i = 0; i < projectMemberList.length; i++){
				if($('#loginUser').val() == projectMemberList[i].mId){
					if(projectMemberList[i].pmFav){
						txt += '<h1><span class="glyphicon glyphicon-star gantt_fav_btn"></span>'
					}else{
						txt += '<h1><span class="glyphicon glyphicon-star-empty gantt_fav_btn"></span>'
					}
				}
			}
			txt += project.pName
			txt += '</h1></th>'
			txt += '</tr>'
			txt += '<tr>'
			txt += '<td>태스크추가<button id="addTaskBtn" class="btn btn-success" data-toggle="modal" data-target="#addTaskModal"><span class="glyphicon glyphicon-plus"></span></button>'
			txt += '</td>'
			txt += '</tr>'
			for(let i = 0; i < taskList.length; i++){
				txt += '<tr>'
				txt += '<td><div class="sideTap_td"><span onclick="location.href=\'/OurRoom/project/kanban2?pNum='
				txt += ${project.pNum}
				txt += '&tNum='
				txt += taskList[i].tNum
				txt += '\'">'
				txt += taskList[i].tName
				txt += '</span><button class="btn btn-success addIssueBtn" tNum="'
				txt += taskList[i].tNum
				txt += '" tName="'
				txt += taskList[i].tName
				txt += '" data-toggle="modal" data-target="#addIssueModal"><span class="glyphicon glyphicon-plus"></span></button>'
				txt += '</div></td>'
				txt += '</tr>'
				for(let j = 0; j < issueList.length; j++){
					if(taskList[i].tNum == issueList[j].tNum){
						txt += '<tr>'
						txt += '<td><div class="sideTap_td">'
						txt += issueList[j].iName
						txt += '</div></td>'
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
			selectedMId = []
	    $.ajax({
	      url: 'addTask',
	      data: {
	        pNum: ${project.pNum},
	        tName: $('#addTaskModal_tName').val(),
					tDscr : $('#addTaskModal_tDscr').val(),
	        tStartDate: '',
	        tEndDate: '',
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
					$('#addTaskModal_tName').val('')
					$('#addTaskModal_tDscr').val('')
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

			if($('#addIssueModal_iStartDate').val() > $('#addIssueModal_iEndDate').val()){
				$('#addIssueModal_iStartDate').val('')
				$('#addIssueModal_iEndDate').val('')
				alert('잘못된 날짜 입력')
			}else {
				$.ajax({
					url : 'addIssue',
					data : {
						pNum : ${project.pNum},
						tNum : selectedtNum,
						iName : $('#iName').val(),
						iDscr : $('#addIssueModal_iDscr').val(),
						iStep : 1,
						iStartDate : $('#addIssueModal_iStartDate').val(),
						iEndDate : $('#addIssueModal_iEndDate').val(),
						members : selectedMId
					},
					type : 'post',
					success : (data) => {
						// matchDate_issueToTask()
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
						matchDate_issueToTask()
						sideTap(project, taskList, issueList)
						$('.close').trigger('click')
					}
				})

			}
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
			//여기 문제가 있는데 잘 모르겠다
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
			console.log('태스크 공지 변경 누름');
			console.log($('#taskDetailModal_tDscr').val());
			data = {
				tNum : selectedTask,
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
					tNum : selectedTask,
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
				tNum : selectedTask,
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

					$('#projectDetailModal_pName').html(project.pName)
					$('#projectDetailModal_pStartDate').val(project.pStartDate)
					$('#projectDetailModal_pEndDate').val(project.pEndDate)

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
			assingedCheckListItemMember = []

			txt =''
			txt += '<input type="text" id="addCheckListItemName">'
			txt += '<button id="addCheckListItemBtn">OK</button>'
			txt += '<br>'
			txt += '====이슈 할당 멤버===='
			for(let i = 0; i < issueMember.length; i++){
				txt += '<div class="unasassingedCheckListItemMember" mId="'
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
		$(document).on('click', '.unassingedCheckListItemMember', function(){
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
				success : (innerData) => {
					console.log(innerData);
					showIssue(innerData)
					showCheckList(innerData)
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
			if($('#IssueDetailModal_iStartDate').val() < $('#IssueDetailModal_iEndDate').val()){
				data = {
					tNum : selectedTask,
					iNum : selectedIssue,
					iStartDate : $('#IssueDetailModal_iStartDate').val()
				}
				updateIssue(data)
			}else{
				alert('삐익!!')
				$('#IssueDetailModal_iStartDate').val(issueList[0].iStartDate)
			}
		})

		//이슈 종료 날짜 변경
		$(document).on('change', '#IssueDetailModal_iEndDate', () => {
			if($('#IssueDetailModal_iStartDate').val() < $('#IssueDetailModal_iEndDate').val()){
				data = {
					tNum : selectedTask,
					iNum : selectedIssue,
					iEndDate : $('#IssueDetailModal_iEndDate').val()
				}
				updateIssue(data)
			}else{
				alert('삐비빅')
				$('#IssueDetailModal_iEndDate').val(issueList[0].iEndDate)
			}
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

		//프로젝트 상세 보기
		$('#projectDetailBtn').on('click', function () {
			$('#projectDetailModal_pNameForm').hide().val('')
			$('#projectDetailModal_pName').show().html(project.pName)
			$('#projectDetailModal_pStartDate').val(project.pStartDate)
			$('#projectDetailModal_pEndDate').val(project.pEndDate)

			//네임폼 클릭 이벤트
			$('#projectDetailModal_pName').on('click', () => {
				$('#projectDetailModal_pName').hide()
				$('#projectDetailModal_pNameForm').show().val($('#projectDetailModal_pName').html()).focus()

				//엔터이벤트
				$('#projectDetailModal_pNameForm').keyup((e) => {
					if((e.keyCode || e.which) == 13){
						data = {
							pName : $('#projectDetailModal_pNameForm').val()
						}
						updateProject(data)
						$('#projectDetailModal_pNameForm').hide()
						$('#projectDetailModal_pName').show()

					}
				})

				//포커스 아웃
				$('#projectDetailModal_pNameForm').on('focusout', () => {
					$('#projectDetailModal_pNameForm').hide()
					$('#projectDetailModal_pName').show()
				})

			})

			$('#projectDetailModal_pStartDate').on('change', () => {

				if($('#projectDetailModal_pStartDate').val() < $('#projectDetailModal_pEndDate').val()){
					data = {
						pStartDate : $('#projectDetailModal_pStartDate').val()
					}
					updateProject(data)
				}else{
					alert('프로젝트 시작일이 종료일보다 늦습니다.')
					$('#projectDetailModal_pStartDate').val(project.pStartDate)
				}
			})

			$('#projectDetailModal_pEndDate').on('change', () => {
				if($('#projectDetailModal_pStartDate').val() < $('#projectDetailModal_pEndDate').val()){
					data = {
						pEndDate : $('#projectDetailModal_pEndDate').val()
					}
					updateProject(data)
				}else{
					alert('프로젝트 종료일이 시작일보다 빠릅니다.')
					$('#projectDetailModal_pEndDate').val(project.pEndDate)
				}
			})



			$.ajax({
				url : 'projectDetail',
				data : {
					pNum : ${project.pNum}
				},
				type : 'post',
				success : (data) => {
					console.log(data);
					txt = ''
					for(let i = 0; i < data.addressList.length; i++){
						$('#projectDetailModal_assingedMember').html(data.addressList[i].mId)
					}

				}
			})
		})


		//프로젝트 내용 변경
		const updateProject = (data) => {
			$.ajax({
				url : 'updateProject',
				data : {
					pNum : ${project.pNum},
					pName : data.pName,
					pStartDate : data.pStartDate,
					pEndDate : data.pEndDate,
					pBackGround : data.pBackground
				},
				type : 'post',
				success : () => {
					projectReload()
				}
			})
		}



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

		//이슈 날짜 변경시 태스크 날짜 변경
		const matchDate_issueToTask = () => {
			console.log('여기가 좀 이상해');
			console.log(selectedTask);
			console.log(selectedIssue);
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

		//뷰모드
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

		$('.table').addClass('table-striped')
		$('.table').addClass('grid-background')

		$('.gantt_fav_btn').on('click', () => {
			for(let i = 0; i < projectMemberList.length; i++){
				if($('#loginUser').val() == projectMemberList[i].mId){
					data = {
						pmFav : !projectMemberList[i].pmFav
					}
					updateProjectMember(data)

					if(	$('.gantt_fav_btn').hasClass('glyphicon-star')){
						$('.gantt_fav_btn').removeClass('glyphicon-star')
						$('.gantt_fav_btn').addClass('glyphicon-star-empty')
					}else{
						$('.gantt_fav_btn').removeClass('glyphicon-star-empty')
						$('.gantt_fav_btn').addClass('glyphicon-star')
					}
				}
			}
		})

		const updateProjectMember = (data) => {
			$.ajax({
				url : 'updateProjectMember',
				data : {
					pNum : ${project.pNum},
					mId : $('#loginUser').val(),
					pmIsAdmin : data.pmIsAdmin,
					pmIsAuth : data.pmIsAuth,
					pmFav : data.pmFav
				},
				type : 'post',
				success : () => {
				}
			})
		}

	})
	</script>

</body>
</html>
