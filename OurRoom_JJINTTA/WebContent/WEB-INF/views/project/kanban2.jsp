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
      #innerFrame{
        background-color:#ffffe6
      }
    </style>

    <script src="https://code.jquery.com/jquery-1.9.0.js"></script>

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
          <div class="projectChartModal_chartBody">
            <div>1</div>
            <canvas id="projectChartModal_chartBody_projectInfo"></canvas>
          </div>
          <div class="projectChartModal_chartBody">
            <div>2</div>
            <canvas id="projectChartModal_chartBody_projectProgress"></canvas>
          </div>
          <div class="projectChartModal_chartBody">
            <div>3</div>
            <canvas id="projectChartModal_chartBody_signedIssue"></canvas>
          </div>
          <div class="projectChartModal_chartBody">
            <div>4</div>
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


  var KanbanTest = new jKanban({
      element : '#myKanban',
      gutter  : '10px',
      click : function(el){
            //var addBoardDefault = document.getElementById(el.data-eid)
          // var x = el.getAttribute('data-eid')
          // alert(x+'번 이슈 상세보기')      //    alert(x);



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

  // var projectInfo = document.getElementById("projectChartModal_chartBody_projectInfo").getContext('2d');


  let projectInfo = document.getElementById("projectChartModal_chartBody_projectInfo").getContext('2d');
  let projectProgress = document.getElementById("projectChartModal_chartBody_projectProgress").getContext('2d');
  let signedIssue = document.getElementById("projectChartModal_chartBody_signedIssue").getContext('2d');
  let completedIssue = document.getElementById("projectChartModal_chartBody_completedIssue").getContext('2d');


    const showProjectChartModal = (data) => {
      $('.chartjs-size-monitor').remove()
      $('#projectChartModal_pName').html(data.project.pName)

      const dynamicColors = function(num) {
        const rainbow = []
        //빨강
        rainbow.push('#ff3333')
        //주황
        rainbow.push('#ffb833')
        //노랑
        rainbow.push('#ffff33')
        //초록
        rainbow.push('#33ff33')
        //파랑
        rainbow.push('#3333ff')
        //남색
        rainbow.push('#aa33ff')
        //보라
        rainbow.push('#ff33ff')

         colors = []
         let index = 0
         for(let i = 0; i < num; i++){
           index = i % 7
           colors.push(rainbow[index])
         }
         return colors
      };

      const dynamicColors2 = function(num) {
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

         colors = []
         let index = 0
         for(let i = 0; i < num; i++){
           index = i % 7
           colors.push(rainbow2[index])
         }
         return colors
      };

      const projectChartModal_chartBody_projectInfo = new Chart(projectInfo, {
        type : 'horizontalBar',
        data : {
          labels : ['전체 진행률'],
          datasets : [
            {
            data : [{
              x : new Date(),
              y : 1
            },{
              x : new Date(),
              y : 10
            }],
            label: '지난 기한',
            backgroundColor : dynamicColors(1),
            borderColor: 'rgba(0, 0, 0, 0.75)',
            hoverBorderColor: 'rgba(0, 0, 0, 1)',
            borderWidth : 1
          },
        ],
        },
        options : {
          scales: {
              xAxes: [{
                  type: 'time',
                  time: {
                      displayFormats: {
                          quarter: 'MMM YYYY'
                      }
                  }
              }]
          },
          responsive: true,
          maintainAspectRatio: true,
        }
      })

      let completedIssueCount = 0
      let uncompletedIssueCount = 0
      for(let i = 0; i < data.issueList.length; i++){
        if(data.issueList[i].iStep == 3 || data.issueList[i].iStep == 4){
          completedIssueCount++
        }else {
          uncompletedIssueCount++
        }
      }

      const projectChartModal_chartBody_projectProgress = new Chart(projectProgress, {
        type : 'pie',
        data : {
          labels : ['완료 이슈', '미완료 이슈'],
          datasets : [{
            data : [completedIssueCount, uncompletedIssueCount],
            backgroundColor : dynamicColors(2),
            borderColor: 'rgba(0, 0, 0, 0.75)',
            hoverBorderColor: 'rgba(0, 0, 0, 1)',
            borderWidth : 1
          }],
        },
        options : {
        }
      })

      let projectMember = []
      let signedIssueCount = []
      let colorSet = []

      for(let i = 0; i < data.projectMemberList.length; i++){
        projectMember.push(data.projectMemberList[i].mId)
        colorSet.push(dynamicColors())
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

      const projectChartModal_chartBody_signedIssue = new Chart(signedIssue, {
        type : 'polarArea',
        data : {
          labels : projectMember,
          datasets : [{
            label : ' #할당 이슈',
            data : signedIssueCount,
            backgroundColor : dynamicColors(projectMember.length),
            borderColor: 'rgba(0, 0, 0, 0.75)',
            hoverBorderColor: 'rgba(0, 0, 0, 1)',
            borderWidth : 1
          }],
        },
        options : {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }]
          },
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
            backgroundColor : dynamicColors(taskListName.length),
            borderColor: 'rgba(0, 0, 0, 0.75)',
            hoverBorderColor: 'rgba(0, 0, 0, 1)',
            borderWidth : 1
          },
          {
            label : '미완료 이슈',
            data : uncompletedIssueInTask,
            backgroundColor : dynamicColors2(taskListName.length),
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
                beginAtZero:true
              }
            }]
          },
          responsive: true,
          maintainAspectRatio: true,
        }
      })

      $('#projectChartModal').on('hidden.bs.modal', function () {
        projectChartModal_chartBody_projectInfo.destroy()
        projectChartModal_chartBody_projectProgress.destroy()
        projectChartModal_chartBody_signedIssue.destroy()
        projectChartModal_chartBody_completedIssue.destroy()
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
