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
<%-- <script type="text/javascript" src='<c:url value="/js/arrow.js"/>'></script>
   <script src='<c:url value="/js/bar.js"/>'></script>
   <script src='<c:url value="/js/date_utils.js"/>'></script>
   <script src='<c:url value="/js/index.js"/>'></script>
   <script src='<c:url value="/js/popup.js"/>'></script>
   <script src='<c:url value="/js/svg_utils.js"/>'></script>
   <link href='<c:url value="/js/gantt.scss"/>' rel="stylesheet"> --%>
<script src="/OurRoom/js/frappe-gantt.js"></script>
<link rel="stylesheet" href="/OurRoom/js/frappe-gantt.css">

	<script>
  $(function () {
    $(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
  });
</script>
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
</style>

</head>

<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<div id="projectInfo"></div>

		<%-- <button class="btn" id="addTaskBtn" data-toggle="modal"
			data-target="#addTaskModal">태스크 추가</button> --%>
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
						태스크명: <input type="text" placeholder="enter task name" id="tName">
					</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div>
						시작 : <br> <input type="text" class="datepicker tStartDate" readonly>
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker tEndDate" readonly>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="addTask">Add</button>
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
						<p id="selectedTask"></p>
					</h2>
					<h4 class="modal-title">
						이슈명: <input type="text" placeholder="enter issue name" id="iName">
					</h4>
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

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="addIssue">Add</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<%-- 이슈 상세보기 모달 --%>
	<div class="modal fade" id="IssueModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<p id="selectedTask"></p>
					</h2>
					<h4 class="modal-title">
						이슈명: <input type="text" placeholder="enter issue name" id="iName">
					</h4>
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

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="addIssue">Add</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<%-- 숨겨진 이슈 상세보기 버튼 --%>
	<div id="issueDetailBtn" data-toggle="modal" data-target="#IssueModal"></div>


<script type="text/javascript">

$(document).ready(function () {
console.log('==========================');
let project = ${projectJson}
console.log(project);
let taskList = ${taskJson}
console.log(taskList);
let issueList = ${issueJson}
console.log(issueList);
console.log('==========================');

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

	let tempProject = new Project('P_' + p.pNum + '', p.pName, p.pStartDate, p.pEndDate, 50)
	taskAndIssue.push(tempProject)

  for (let i = 0; i < tList.length; i++) {
    let tempTask = new Task('T_' + tList[i].tNum + '', tList[i].tName, tList[i].tStartDate, tList[i].tEndDate, 50, 'task')
    taskAndIssue.push(tempTask)

    for (let j = 0; j < iList.length; j++) {
      if (tList[i].tNum == iList[j].tNum) {
        let tempIssue = new Issue('I_' + iList[j].iNum + '_T_' + tList[i].tNum, iList[j].iName, iList[j].iStartDate, iList[j].iEndDate, 50, 'issue')
        taskAndIssue.push(tempIssue)
      }
    }
  }
  console.log('makeGantt 실행');
}
console.log(taskAndIssue);
makeGantt(project, taskList, issueList)

var gantt = new Gantt('#gantt', taskAndIssue, {
  // can be a function that returns html or a simple html string
  on_click: function (task) {
		if(task.id.charAt(0) == 'T'){
			//클릭한 녀석이 태스크
			alert('태스크')
		}else if (task.id.charAt(0) == 'I') {
			//클릭한 녀석이 이슈
			$('#issueDetailBtn').trigger('click')
			console.log(task.id);
		}
  },
  on_date_change: function (task, start, end) {
    console.log(task, start, end);
  },
  on_progress_change: function (task, progress) {
    console.log(task, progress);
  },
  on_view_change: function (mode) {
    console.log(mode);
  },
});

gantt.change_view_mode('Month')


  $('.issues').on('click', function () {
    $.ajax({
      url: "issueDetail",
      data: {
        pNum: $(this).attr("pNum"),
        tNum: $(this).attr("tNum"),
        iNum: $(this).attr("iNum")
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
			txt += '<td>'
			txt += taskList[i].tName
			txt += '<button class="btn addIssueBtn" tNum="'
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

  $('#addTask').on('click', function () {
    $.ajax({
      url: 'addTask',
      data: {
        pNum: ${project.pNum},
        tName: $('#tName').val(),
        tStartDate: $('.tStartDate').val(),
        tEndDate: $('.tEndDate').val()
      },
      type: 'post',
      success: (data) => {
        console.log(data)
        taskList = data.taskJson
        issueList = data.issueJson
        taskAndIssue = []

        makeGantt(taskList, issueList)
        gantt.refresh(taskAndIssue)
				sideTap(taskList, issueList)
        $('.close').trigger('click')
      }
    })
  })

	//선택한 태스크 판별용 변수
	let selectedtNum = 0
	let selectedtName = ''

	//이슈 추가창 생성
	$('.addIssueBtn').on('click', function(){
		selectedtNum = $(this).attr('tNum')
		selectedtName = $(this).attr('tName')
		$('#selectedTask').html("태스크 이름 : " + selectedtName)
	})

	//이슈 추가
	$('#addIssue').on('click', () => {
		$.ajax({
			url : 'addIssue',
			data : {
				pNum : ${project.pNum},
				tNum : selectedtNum,
				iName : $('#iName').val(),
				iStep : 1,
				iStartDate : $('.iStartDate').val(),
				iEndDate : $('.iEndDate').val()
			},
			type : 'post',
			success : (data) => {
				console.log('이슈 추가 성공');
				console.log(data)
				taskList = data.taskJson
				issueList = data.issueJson
				taskAndIssue = []

				makeGantt(taskList, issueList)
				gantt.refresh(taskAndIssue)
				sideTap(taskList, issueList)
				$('.close').trigger('click')

			}
		})
	})

})
</script>
</body>

</html>
