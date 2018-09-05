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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.5.1/snap.svg-min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
      <%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.css"/>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.js.map"></script> --%>

    <%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/frappe-gantt/0.2.0/frappe-gantt.min.css"/> --%>
   <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
     $( function() {
       $( ".datepicker" ).datepicker();
     } );
   </script>

</head>

<body>

      <jsp:include page="../mainFrame.jsp" />
      <div id="innerFrame">

      <button class="btn" id="addTask" data-toggle="modal" data-target="#addTaskModal">태스크 추가</button>

      <svg id="gantt"></svg>



      </div>
<script type="text/javascript">

let taskList =  ${taskJson}
let issueList = ${issueJson}

class Task{
   constructor(id,name,start,end,progress,custom_class){
      this.id=id
      this.name=name
      this.start=start
      this.end=end
      this.progress=progress
      this.custom_class=custom_class
   }
}

class Issue{
  constructor(id,name,start,end,progress,custom_class){
     this.id=id
     this.name=name
     this.start=start
     this.end=end
     this.progress=progress
     this.custom_class=custom_class
  }
}

    let taskAndIssue = []

    const makeGantt = () => {
      for(let i = 0; i < taskList.length; i++){
        let tempTask = new Task(
          'T_' + taskList[i].tNum+'',
          taskList[i].tName,
          taskList[i].tStartDate,
          taskList[i].tEndDate,
          50,
          'task'
        )
        taskAndIssue.push(tempTask)
        for(let j = 0; j < issueList.length; j++){
          if(taskList[i].tNum == issueList[j].tNum){
            let tempIssue = new Issue(
              'I_' + issueList[j].iNum+ '_T_' + taskList[i].tNum,
              issueList[j].iName,
              issueList[j].iStartDate,
              issueList[j].iEndDate,
              50,
              'issue'
            )
            taskAndIssue.push(tempIssue)
          }
        }

      }
    }

   makeGantt()


var gantt = new Gantt('#gantt', taskAndIssue, {
    // can be a function that returns html
    // or a simple html string
      on_click: function (task) {
        console.log(task);
    }
    // on_date_change: function(task, start, end) {
    //     console.log(task, start, end);
    // },
    // on_progress_change: function(task, progress) {
    //     console.log(task, progress);
    // },
    // on_view_change: function(mode) {
    //     console.log(mode);
    // }
});
gantt.change_view_mode('Month')




  </script>


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
