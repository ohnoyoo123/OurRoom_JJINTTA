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

   	<script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.6/require.min.js"></script>

    <script src="/OurRoom/js/jkanban.js"></script>
    <link rel="stylesheet" href="/OurRoom/js/jkanban.css">



    <link rel="stylesheet"
  	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script
    	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script
    	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

	  <div class="container-fluid">
   <div class="row">
      <div class="col-md-12">
         <h1>OurRoom Kanban Boards</h1>

         <hr>

        <button class="btn btn-success" id="addToDo">Add element in "To Do" Board</button>

         <div id="myKanban"></div>
         <!-- <button class="btn btn-success" id="addDefault">Add "Default" board</button> -->

         <!-- <button class="btn btn-danger" id="removeBoard">Remove "Done" Board</button> -->
      </div>
   </div>
</div>

  <script type="text/javascript">

  class Issue{
    constructor(step,item){
       this.step='_'+step
       this.item=item
    }


    // {
    //     'id' : issue.step--> _Ideas,,,,
    //     'title'  : issue.step,
    //     'class' : if(issue.step)-->'info',
    //     'item'  : [
    //         {
    //             'id':issue.step + issue.order,
    //             'title':issue.name,
    //         },
    //         {
    //             'id':'2',
    //             'title':'idea2',
    //         }
    //     ]
    // },


  }
  let issues=[]

  const makeKanban = (issueList) => {
    for(let i=0; i<issueList.length;i++){
      let tempIssue = new Issue(

      )
    }
  }
  var KanbanTest = new jKanban({
      element : '#myKanban',
      gutter  : '10px',
      click : function(el){
            //var addBoardDefault = document.getElementById(el.data-eid)
          var x = el.getAttribute('data-eid')
          alert(x+'번 이슈 상세보기')


      //    alert(x);
      },
      boards  :[
          {
              'id' : '_Ideas',
              'title'  : 'Ideas',
              'class' : 'info',
              'item'  : [
                  {
                      'id':'1',
                      'title':'idea1',
                  },
                  {
                      'id':'2',
                      'title':'idea2',
                  }
              ]
          },
          {
              'id' : '_todo',
              'title'  : 'To Do',
              'class' : 'info',
              'item'  : [
                  {
                      'id':'3',
                      'title':'issue1',
                  },
                  {
                      'id':'4',
                      'title':'issue2',
                  }
              ]
          },
          {
              'id' : '_doing',
              'title'  : 'Doing',
              'class' : 'warning',
              'item'  : [
                  {
                      'id':'5',
                      'title':'doing1',
                  },
                  {
                      'id':'6',
                      'title':'doing2',
                  }
              ]
          },
          {
              'id' : '_Done',
              'title'  : 'Done',
              'class' : 'success',
              'item'  : [
                  {
                      'id':'7',
                      'title':'Done1',
                  }
              ]
          },
          {
              'id' : '_Review',
              'title'  : 'Review',
              'class' : 'success',
              'item'  : [
                  {
                      'id':'8',
                      'title':'All right',
                  },
                  {
                      'id':'9',
                      'title':'Ok!',
                  }
              ]
          }
      ]
  });

  </script>

  <script type="text/javascript">

  $(document).ready(function () {

    $('#addToDo').on('click',function () {
      KanbanTest.addElement(
          '_todo',
          {
              'id':'temp',
              'title':"<input type='text' id='textToDo'/>"
          }
      );
    })

    $('#myKanban').on('keypress','#textToDo',function (e) {
       if(e.keyCode == 13){

        KanbanTest.addElement(
            '_todo',
            {   'id':'issue'+$('#textToDo').val(),
                'title':$('#textToDo').val()
            }
        );
        KanbanTest.removeElement('temp')
        //$('#saveToDo').remove()
        }
    })
    // $('#myKanban').on('click','#saveToDo',function () {
    //
    //     KanbanTest.addElement(
    //         '_todo',
    //         {
    //             'title':$('#textToDo').val()
    //         }
    //     );
    //     KanbanTest.removeElement('temp')
    //     //$('#saveToDo').remove()
    //
    // })

    // $('#myKanban').on('click','#saveToDo',function () {
    //     KanbanTest.addElement(
    //         '_todo',
    //         {
    //             'title':$('#textToDo').val()
    //         }
    //     );
    //
    // })

    // $('#addToDo').on('click',function () {
    //   KanbanTest.addElement(
    //       '_todo',
    //       {
    //           'title':'Test Add',
    //       }
    //   );
    // })

    $('#addDefault').on('click',function () {
      KanbanTest.addBoards(
          [{
              'id' : '_default',
              'title'  : 'Kanban Default',
              'class' : 'error',
              'item'  : [
                  {
                      'title':'Default Item',
                  },
                  {
                      'title':'Default Item 2',
                  },
                  {
                      'title':'Default Item 3',
                  }
              ]
          }]
      )
    })

    $('#removeBoard').on('click',function () {
      KanbanTest.removeBoard('_done');
    })






  })

  </script>

</body>
</html>
