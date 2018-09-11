<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <style>
        body{font-family: "Lato"; margin:0; padding: 0;}
      #myKanban{overflow-x: auto; padding:20px 0;}

      .success{background: #00B961; color:#fff}
      .info{background: #2A92BF; color:#fff}
      .warning{background: #F4CE46; color:#fff}
      .error{background: #FB7D44; color:#fff}
    </style>

    <script src="https://code.jquery.com/jquery-1.9.0.js"></script>

    <script src="/OurRoom/js/jkanban.js"></script>
    <link rel="stylesheet" href="/OurRoom/js/jkanban.css">

      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>
  <jsp:include page="../mainFrame.jsp" />
    <div id="innerFrame">

     <div class="container-fluid">
     <div class="row">
        <div class="col-md-12">


            <div class="dropdown">
               <h1><a href='gantt?pNum=${project.pNum}'>${project.pName}</a> </h1>

              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id='goToTasksBtn'>
                ${task[0].tName} Kanban Boards
              </button>
              <div class="dropdown-menu" id='taskList'>
               <!-- <a class="dropdown-item" href="#">Link 1</a>
                <a class="dropdown-item" href="#">Link 2</a>
                <a class="dropdown-item" href="#">Link 3</a> -->
              </div>
            </div>

           <hr>

          <button class="btn btn-success" id="addToDo">Add element in "To Do" Board</button>

           <div id="myKanban"></div>
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
            makeKanban(issueList)
          }
        })
      }
  });

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