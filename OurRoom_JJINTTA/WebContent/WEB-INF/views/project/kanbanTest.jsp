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
</head>
<body>


    <div class="container-fluid">
   <div class="row">
      <div class="col-md-12">
         <h1>Kanban Boards</h1>
         <p>Pure agnostic Javascript plugin for Kanban boards</p>
            <a class="btn-xl btn btn-default" href="https://github.com/riktar/jkanban" target="_blank">Fork on GitHub</a>
         <hr>
         <div id="myKanban"></div>
         <button class="btn btn-success" id="addDefault">Add "Default" board</button>
         <button class="btn btn-success" id="addToDo">Add element in "To Do" Board</button>
         <button class="btn btn-danger" id="removeBoard">Remove "Done" Board</button>
      </div>
   </div>
</div>



<script type="text/javascript">

  var KanbanTest = new jKanban({
      element : '#myKanban',
      gutter  : '10px',
      click : function(el){
          alert(el.innerHTML);
      },
      boards  :[
          {
              'id' : '_todo',
              'title'  : 'To Do (drag me)',
              'class' : 'info',
              'item'  : [
                  {
                      'title':'Try drag me',
                  },
                  {
                      'title':'Click me!!',
                  }
              ]
          },
          {
              'id' : '_working',
              'title'  : 'Working',
              'class' : 'warning',
              'item'  : [
                  {
                      'title':'Do Something!',
                  },
                  {
                      'title':'Run?',
                  }
              ]
          },
          {
              'id' : '_done',
              'title'  : 'Done',
              'class' : 'success',
              'item'  : [
                  {
                      'title':'All right',
                  },
                  {
                      'title':'Ok!',
                  }
              ]
          }
      ]
  });

  var toDoButton = document.getElementById('addToDo');
  toDoButton.addEventListener('click',function(){
      KanbanTest.addElement(
          '_todo',
          {
              'title':'Test Add',
          }
      );
  });

  var addBoardDefault = document.getElementById('addDefault');
  addBoardDefault.addEventListener('click', function () {
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
  });

  var removeBoard = document.getElementById('removeBoard');
  removeBoard.addEventListener('click',function(){
      KanbanTest.removeBoard('_done');
  });


  </script>
</body>
</html>