<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <style>
        body{font-family: "Lato"; margin:0; padding: 0;}
      #myKanban{overflow-x: auto; padding-left: 0px; margin-left: -10px; padding-top: 20px}

      .success{background: #00B961; color:#fff}
      .info{background: #2A92BF; color:#fff}
      .warning{background: #F4CE46; color:#fff}
      .error{background: #FB7D44; color:#fff}
      .material-icons.md-12{
        font-size: 45px;
        color: green;
      }
      .material-icons.md-30{
        font-size: 40px;
        vertical-align: bottom;
        padding-bottom: 5px;
      }
      i{
        cursor:pointer;
      }

    </style>

    

    <script src="/OurRoom/js/jkanban.js"></script>
    <link rel="stylesheet" href="/OurRoom/js/jkanban.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
     <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
</head>
<body>
  <jsp:include page="../mainFrame.jsp" />
    <div id="innerFrame">

     <div class="container-fluid" style="padding:90px; margin-top:-40px;">
     <div class="row">
        <div class="col-md-12">

          <h1 style="display: inline-block"><a href='gantt?pNum=${project.pNum}'>${project.pName}</a> </h1>
          <%-- <i class="material-icons md-30" data-toggle="tooltip" data-placement="right" title="차트 보기"> --%>
          <i class="material-icons md-30" data-toggle="modal" data-target="#projectChartModal">
            insert_chart
          </i>

          <div class="dropdown" style="float:right;" >

            <button style="padding-bottom:-20px;" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id='goToTasksBtn'>
              ${task[0].tName} Kanban Boards
            </button>
            <div class="dropdown-menu" id='taskList'>
            </div>


          </div>

           <hr>

          <i class="material-icons md-12" id="addToDo" data-toggle="tooltip" data-placement="right" title="이슈 추가">
            add_circle
          </i>

           <div id="myKanban"></div>
        </div>
     </div>
  </div>
  </div>


  <%-- 차트 모달 --%>
  <!-- The Modal -->
  <div class="modal fade" id="projectChartModal">
    <div class="modal-dialog">
      <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">
            프로젝트명: <span id="projectChartModal_pName"></span>
          </h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">

          <%-- 프로젝트 완료 현황 --%>
          <div class="projectChartModal_chartBody">
            <div id="daysLeft"></div>
            <canvas id="projectChartModal_chartBody_projectProgress"></canvas>
            <br/>
            <div id="progressPercent"></div>
            <progress id="animationProgress" max="1" value="0" style="width: 100%"></progress>

            <%-- 이슈 할당 --%>
            <canvas id="projectChartModal_chartBody_signedIssue"></canvas>

            <%-- 태스크별 이슈완료 --%>
            <br/>
            <canvas id="projectChartModal_chartBody_completedIssue"></canvas>

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
						<span id="IssueDetailModal_iName"></span> <input type="text"
							id="IssueDetailModal_iNameForm" autofocus>
					</h4>
					이슈 멤버 :
					<p id="issueMember"></p>
				</div>

				<!-- Modal body -->
				<div class="modal-body flex">

					<div id="IssueDetailModal_left">
						<div id="IssueDetailModal_iStartDate_div">
							<h4>이슈 시작일</h4>
							<input type="text" class="datepicker"
								id="IssueDetailModal_iStartDate" readonly>
						</div>
						<div id="IssueDetailModal_iEndDate_div">
							<h4>이슈 종료일</h4>
							<input type="text" class="datepicker"
								id="IssueDetailModal_iEndDate" readonly>
						</div>
						<br>
						<div id="IssueDetailModal_iDscrForm">
							<h4>이슈 설명</h4>
							<textarea id="IssueDetailModal_iDscr"></textarea>
							<button id="IssueDetailModal_iDscrBtn" type="button">저장</button>
						</div>
						<h4>
							체크리스트
							<button id="addCheckListForm" type="button">+</button>
						</h4>
						<div id="checkListNameForm"></div>
						<div id="checkListList"></div>
						<h4>코멘트</h4>
						<div id="commentDiv">
							${loginUser.mNickname} : <input type="text" style="width: 80%"
								id="IssueDetailModal_cmContent">
							<button id="IssueDetailModal_cmBtn" class="btn" type="button">저장</button>
							<div id="commentArea"></div>
						</div>
					</div>

					<div id="IssueDetailModal_right">
						사이드<br> 체크리스트 +<br> 멤버<br>
					</div>

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

  <script type="text/javascript">

  console.log(${issueJson});

  class Issue{
    constructor(id, title, order){
      this.id = id
      this.title = title
      this.order=order
      // data-toggle="modal" data-target="#addProject"
    }
  }
  const colorForEachSteps = (step) => {
    if(step==='Ideas' || step==='ToDo'){
      return 'info'
    }else if(step==='Doing'){
      return 'warning'
    }else if(step==='Done' || step==='Review'){
      return 'success'
    }
  }
  const issuesForBoard = (issueList) => {
    let tempIssues =[]
    for(let i=0; i<issueList.length; i++){
      let tempIssue = new Issue(issueList[i].iNum,issueList[i].iName, issueList[i].iOrder)
    //  console.log('이슈==================');
  //    console.log(tempIssue);
      tempIssues.push(tempIssue)
    }
  //  console.log('각 보드에 해당하는 이슈들=================');
  //  console.log(tempIssues);
    return tempIssues
  }

    class Board{
      constructor(step, issueList){
        this.id = step
        this.title = step
        this.class = colorForEachSteps(step)
        this.item = issuesForBoard(issueList)
      }
    }

    let issueList = ${issueList}
  //  console.log(issueList);

    let kanbanIssues = []

    const makeKanban = (iList) => {
      console.log("makeKanban!!!!!!!!!!!!!!!!!");
      console.log(iList);
      let ideasIssues = []
      let todoIssues = []
      let doingIssues = []
      let doneIssues = []
      let reviewIssues = []

      //issueList를 스텝별로 구분
      for(let i=0; i<iList.length; i++){
        if(iList[i].iStep==0){
          ideasIssues.push(iList[i])
        }else if(iList[i].iStep==1){
          todoIssues.push(iList[i])
        }else if(iList[i].iStep==2){
          doingIssues.push(iList[i])
        }else if(iList[i].iStep==3){
          doneIssues.push(iList[i])
        }else if(iList[i].iStep==4){
          reviewIssues.push(iList[i])
        }
      }
      let totalIssues = [ideasIssues,todoIssues,doingIssues,doneIssues,reviewIssues]
  //    console.log('확인!!!!!!!!!!!!!!');

      let steps = ['Ideas','ToDo','Doing','Done','Review']

      for(let i=0; i<totalIssues.length; i++){
  //      console.log('222222222222222222222');
  //      console.log(totalIssues[i]);
        let tempBoard = new Board(steps[i],totalIssues[i])
        kanbanIssues.push(tempBoard)
      }

      return kanbanIssues

    }
// 1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
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
// 111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
  var KanbanTest = new jKanban({
      element : '#myKanban',
      gutter  : '10px',
      click : function(el){
            //var addBoardDefault = document.getElementById(el.data-eid)
          let selectedissue = el.getAttribute('data-eid')

          // alert(x+'번 이슈 상세보기')      //    alert(x);
          $.ajax({
             url : 'issueDetail',
             data : {
                pNum : ${project.pNum},
                tNum : ${task[0].tNum},
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

          $('#IssueDetailModal').modal()

      },
      boards  : makeKanban(issueList),
      dropEl: function (el, target, source, sibling) {

        $.ajax({
          url: 'issueOrderChange',
          data: {
            pNum: ${project.pNum},
            tNum: ${task[0].tNum},
            iNum: el.getAttribute('data-eid'),
            firstStep: $(source).parent('div').attr('data-id'),
            finalStep: $(target).parent('div').attr('data-id'),
            iOrderFormer: el.getAttribute('data-iorder'),
            iOrderLatter: sibling!=null ? sibling.getAttribute('data-iorder') : 0

          },
          type: 'post',
          success: function (issueList) {
            console.log(issueList);

          }
        })
      }
  });


  //모달창 생성하면서 데이터 불러오기(프로젝트 차트용)
  $("#projectChartModal").on('shown.bs.modal', function() {
    $.ajax({
      url : 'projectChart',
      data : {
        pNum : ${project.pNum}
      },
      type : 'post',
      success : (data) => {
        console.log("==============");
        console.log(data);
        showProjectChartModal(data)
      }
    })
  })

  let projectProgress = document.getElementById("projectChartModal_chartBody_projectProgress").getContext('2d');
  let signedIssue = document.getElementById("projectChartModal_chartBody_signedIssue").getContext('2d');
  let completedIssue = document.getElementById("projectChartModal_chartBody_completedIssue").getContext('2d');
  let pEndDate = ${project.pEndDate}

  let today = new Date()

  let yy = ${project.pEndDate.split('-')[0]}
  let mm = ${project.pEndDate.split('-')[1]}
  let dd = ${project.pEndDate.split('-')[2]}
  let ddddd = yy + '-' + mm + '-' + dd

  let chart_pEndDate = new Date(ddddd)

  let calculatedDays = Math.floor((Date.UTC(chart_pEndDate.getFullYear(), chart_pEndDate.getMonth(), chart_pEndDate.getDate()) - Date.UTC(today.getFullYear(), today.getMonth(), today.getDate()) ) /(1000 * 60 * 60 * 24))
  let remainDates = '남은 기한 : '+calculatedDays+'일'

  $('#daysLeft').html(remainDates)

    const showProjectChartModal = (data) => {
      $('.chartjs-size-monitor').remove()
      $('#projectChartModal_pName').html(data.project.pName)

      let completedIssueCount = 0
      let uncompletedIssueCount = 0
      for(let i = 0; i < data.issueList.length; i++){
        if(data.issueList[i].iStep == 3 || data.issueList[i].iStep == 4){
          completedIssueCount++
        }else {
          uncompletedIssueCount++
        }
      }

      let percent = (completedIssueCount/(completedIssueCount+uncompletedIssueCount))*100
      percent = percent.toFixed(1)
      percent = '진행률 : '+percent.toString()+'%'
      $('#progressPercent').html(percent)
      let progress = document.getElementById('animationProgress');
      const projectChartModal_chartBody_projectProgress = new Chart(projectProgress, {
        type : 'pie',
        data : {
          labels : ['완료 이슈', '미완료 이슈'],
          datasets : [{
            data : [completedIssueCount, uncompletedIssueCount],
            backgroundColor : ['#3366cc','#adc1eb'],
            borderColor: 'rgba(0, 0, 0, 0.75)',
            hoverBorderColor: 'rgba(0, 0, 0, 1)',
            borderWidth : 1
          }],
        },
        options : {
          title: {
          display: true,
          text: '전체 진행률',
          fontStyle: 'bold',
          fontSize: 20
          },
          animation: {
					duration: 2000,
					onProgress: function(animation) {
            progress.value = completedIssueCount/(completedIssueCount+uncompletedIssueCount);
					}
          }
        }
      })
      let projectMember = []
      let signedIssueCount = []
      let colorSet = []

      for(let i = 0; i < data.projectMemberList.length; i++){
         projectMember.push(data.projectMemberList[i].mId)
      }
      for(let i = 0; i < projectMember.length; i++){
         let count = 0
         for(let j = 0; j < data.issueMemberList.length; j++){
            if(projectMember[i] == data.issueMemberList[j].mId){
               count++
            }
         }
         signedIssueCount.push(count)
      }
      console.log('확인');
      console.log(projectMember);
      const projectChartModal_chartBody_signedIssue = new Chart(signedIssue, {
         type : 'bar',
         data : {
            labels : projectMember,
            datasets : [{
               data : signedIssueCount,
               backgroundColor : '#3366cc',
               borderColor: 'rgba(0, 0, 0, 0.75)',
               hoverBorderColor: 'rgba(0, 0, 0, 1)',
               borderWidth : 1
            }],
         },
         options : {
            scales: {
                  yAxes: [{
                        ticks: {
                              beginAtZero:true,
                              fixedStepSize: 1
                        }
                  }]
            },
            title: {
            display: true,
            text: '팀원별 할당 이슈',
            fontStyle: 'bold',
            fontSize: 20
            },
            legend: {
             display: false
           },
           tooltips: {
               callbacks: {
                  label: function(tooltipItem) {
                         return tooltipItem.yLabel;
                  }
               }
           }
         }
      })

      let taskListName = []
      let completedIssueInTask = []
      let uncompletedIssueInTask = []
      let completedCount = 0
      let uncompletedCount = 0

      for(let i = 0; i < data.taskList.length; i++){
         taskListName.push(data.taskList[i].tName)
      }

      for(let i = 0; i < data.taskList.length; i++){
         completedCount = 0
         uncompletedCount = 0
         for(let j = 0; j < data.issueList.length; j++){
            if(data.taskList[i].tNum == data.issueList[j].tNum){
               if(data.issueList[j].iStep == 3 || data.issueList[j].iStep == 4){
                  completedCount++
               }else{
                  uncompletedCount++
               }
            }
         }
         completedIssueInTask.push(completedCount)
         uncompletedIssueInTask.push(uncompletedCount)
      }

      const projectChartModal_chartBody_completedIssue = new Chart(completedIssue, {
         type : 'bar',
         data : {
            labels : taskListName,
            datasets : [
               {
               label : '완료 이슈',
               data : completedIssueInTask,
               backgroundColor : '#3366cc',
               borderColor: 'rgba(0, 0, 0, 0.75)',
               hoverBorderColor: 'rgba(0, 0, 0, 1)',
               borderWidth : 1
            },
            {
               label : '미완료 이슈',
               data : uncompletedIssueInTask,
               backgroundColor : '#adc1eb',
               borderColor: 'rgba(0, 0, 0, 0.75)',
               hoverBorderColor: 'rgba(0, 0, 0, 1)',
               borderWidth : 1

            }
         ],
         },
         options : {
            scales: {
               xAxes: [{
                  stacked : true,
               }],
               yAxes: [{
                  stacked : true,
                  ticks: {
                     beginAtZero:true,
                     fixedStepSize: 1
                  }
               }]
            },
            responsive: true,
            maintainAspectRatio: true,
            title: {
            display: true,
            text: '태스크별 현황',
            fontStyle: 'bold',
            fontSize: 20
            }
         }
      })

     }

  </script>

  <script type="text/javascript">

  $(document).ready(function () {

    $('#myKanban').click(function (event) {

    })
    $('#addToDo').on('click',function () {
      KanbanTest.addElement(
          'ToDo',
          {
              'id':'temp',
              'title':"<input type='text' id='textToDo'/>"
          }
      );
      $('#textToDo').focus();
    })

    $('#myKanban').on('keypress','#textToDo',function (e) {
       if(e.keyCode == 13){

         let issueName = $('#textToDo').val()

         $.ajax({
           url : 'addIssue',
           data : {
             pNum: ${project.pNum},
             tNum: ${task[0].tNum},
             iName : issueName,
             iStep : 1,
             iStartDate : '',
             iEndDate : ''
           },
           type : 'post',
              success : (data) => {
             newInum = data.newIssueNum
             newOrder = data.newIssueOrder
             console.log('새로운 이슈 번호===');
             console.log(newInum);

             KanbanTest.addElement(
                 'ToDo',
                 {   'id': newInum,
                     'title':issueName,
                     'order' : newOrder
                 }
             );
              }
         })

        KanbanTest.removeElement('temp')
        }
    })

    $('#goToTasksBtn').on('click',function () {
      $.ajax({
        url: 'getTasks',
        data : {
          pNum: ${project.pNum}
        },
        type: 'post',
        success: (data) => {
            console.log(data);
          let txt=''
          for(let i=0; i<data.length; i++){
            console.log(data[i].tName);

          txt += `<a class="dropdown-item" href='kanban2?pNum=`+${project.pNum}+`&tNum=`+data[i].tNum+`'>`+data[i].tName+`</a><br/>`

          }
          console.log('a 태그');
          console.log(txt);
          $('#taskList').html(txt)
        //  $('#test').add('a').addClass('sss').attr('href', 'sss').val('value')

        }
      })

    })

  })

  </script>

</body>
</html>
