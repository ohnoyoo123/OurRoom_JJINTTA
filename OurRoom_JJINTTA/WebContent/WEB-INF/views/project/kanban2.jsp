<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

    <script src="https://code.jquery.com/jquery-1.9.0.js"></script>

    <script src="/OurRoom/js/jkanban.js"></script>
    <link rel="stylesheet" href="/OurRoom/js/jkanban.css">
    <link rel="stylesheet" href="/OurRoom/css/gantt.css">
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
					<div style="text-align:center;">
          <h1 style="display: inline-block">
            <a style="color:black; font-weight:bold;" href='gantt?pNum=${project.pNum}'>${project.pName}</a> </h1>
          <%-- <i class="material-icons md-30" data-toggle="tooltip" data-placement="right" title="차트 보기"> --%>
          <i class="material-icons md-30" data-toggle="modal" data-target="#projectChartModal">
            insert_chart
          </i>
					<div class="dropdown" style="float:right;" >

            <button style="padding-bottom:-20px; display: inline-block; margin-top:40px; margin-right:15px;" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id='goToTasksBtn'>
              ${task[0].tName} Kanban Boards▼
            </button>
            <div class="dropdown-menu" id='taskList'>
            </div>

         </div>
				</div>

				<hr>
          <i class="material-icons md-12" id="addToDo" data-toggle="tooltip" data-placement="right" title="이슈 추가">
            add_circle
          </i>

           <div id="myKanban" style="margin-top:10px;"></div>
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
					<p id="issueMember"></p>
				</div>

				<!-- Modal body -->
				<div class="modal-body flex">

					<div id="IssueDetailModal_left">
						<div id="IssueDetailModal_iStartDate_div">
							<h4><i class="material-icons modal_icon">calendar_today</i> 이슈 시작일</h4>
							<input type="text" class="datepicker"
								id="IssueDetailModal_iStartDate" readonly>
						</div>
						<div id="IssueDetailModal_iEndDate_div">
							<h4><i class="material-icons modal_icon">calendar_today</i> 이슈 종료일</h4>
							<input type="text" class="datepicker"
								id="IssueDetailModal_iEndDate" readonly>
						</div>
						<br>
						<div id="IssueDetailModal_iDscrForm">
							<h4><i class="material-icons modal_icon">description</i> 이슈 설명</h4>
							<textarea id="IssueDetailModal_iDscr"></textarea>
							<button id="IssueDetailModal_iDscrBtn" type="button" class="btn">저장</button>
						</div>
								<h4 class="hover" id="IssueDetailModal_addCheckListForm" data-toggle="tooltip" data-placement="right" title="체크리스트 추가">
									<i class="material-icons modal_icon">playlist_add_check</i> 체크리스트
								</h4>
							<div id="checkListNameForm"></div>

						<div id="checkListList"></div>
						<div id="commentDiv">
							<h4><i class="material-icons modal_icon">comment</i> 코멘트</h4>
							<button id="IssueDetailModal_cmBtn" class="btn btn-sm" type="button">O</button>
							<div class="IssueDetailModal_nickname">
								<span>${loginUser.mNickname}</span>
							</div>
								<input type="text" id="IssueDetailModal_cmContent" placeholder="코멘트 입력">
							<div id="commentArea"></div>
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

  <script type="text/javascript">
  $(function () {
    $(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
  });

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
       // 김승겸 09.18 19:30 이슈할당 멤버들  프로필 | 닉네임 쌍으로 보여주기
       for (var k = 0; k < data.issueMember.length; k++) {
          var img = "<img class='rounded-circle img-circle' src='data:image/jpg;base64, "+ data.profileList[data.issueMember[k].mId] + "' width='30px' height='30px'>";
          $('#issueMember').append(img+""+data.issueMember[k].mNickname).append(', ')
      }
       //for (var k = 0; k < data.issueMember.length; k++) {
       //   $('#issueMember').append(data.issueMember[k].mId).append(', ')
       //}
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
                txt += '<i class="material-icons modal_icon">    check</i><u>' + data.checkList[i].clName
                txt +=  '</u><button style="float:right;" class="deleteCheckListBtn btn btn-sm" data-toggle="tooltip" data-placement="right" title="체크리스트 삭제">X</button>'
                txt +=  '<button style="float:right;" class="addCheckListItemFormBtn btn btn-sm" data-toggle="tooltip" data-placement="right" title="체크리스트 아이템 추가">O</button><br>'
                txt += '<div class="addCheckListItemForm"></div>'
                for (var j = 0; j < data.checkListItem.length; j++) {
                   if (data.checkList[i].clNum == data.checkListItem[j].clNum) {
                      txt += '<div class="checkListItem" ciNum="' + data.checkListItem[j].ciNum + '">'
                      txt += '<i class="material-icons modal_icon tap">subdirectory_arrow_right</i>' + data.checkListItem[j].ciName
                      txt += '<div class="float_right">'
                      if(data.checkListItem[i].ciIsDone == 1){
                        txt += '<i class="material-icons modal_icon hover ci_checkbox tap">check_box</i>'
                      }else {
                        txt += '<i class="material-icons modal_icon hover ci_checkbox tap">check_box_outline_blank</i>'
                      }
                      txt += '<button class="deleteCheckListItemBtn btn btn-xs">X</button>'
                      txt += '</div>'
                      // for(var k = 0; k < data.checkListItemMember.length; k++){
                      //    if(data.checkListItem[j].ciNum == data.checkListItemMember[k].ciNum){
                      //       txt += data.checkListItemMember[k].mId
                      //       txt += '<br>'
                      //    }
                      // }
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
    //코멘트 답글 생성
    const showReComment = (data, cmNum) => {
       for(let i = 0; i < data.commentList.length; i++){
          if(data.commentList[i].cmSuper == cmNum){
             txt += '<p class="commentArea_comment" cmNum="'
             txt += data.commentList[i].cmNum
             txt += '" mId="'
             txt += data.commentList[i].mId
             txt += '">'
             $.ajax({
               url : 'getNickname',
               data : {
                 mId : data.commentList[i].mId
               },
               type : 'post',
               success : (nickname) => {
                 txt += '<i class="material-icons tap">subdirectory_arrow_right</i><span>'
                 txt += nickname
                 txt += '</span>'
               },
               async : false
             })
             if($('#loginUser').val() == data.commentList[i].mId){
               //답글 작성자가 본인이면 삭제 버튼 활성화
               txt += '<button class="IssueDetailModal_deleteCmBtn btn btn-sm">X</button>'
             }else{
               txt += '<button class="IssueDetailModal_deleteCmBtn btn btn-sm" disabled>X</button>'
             }
             txt += '<span class="IssueDetailModal_cmTime">'
             let mm = data.commentList[i].cmWriteTime.split('-')[1]
             let dd = data.commentList[i].cmWriteTime.split('-')[2].split(' ')[0]
             let hh = data.commentList[i].cmWriteTime.split('-')[2].split(' ')[1].split(':')[0]
             let min = data.commentList[i].cmWriteTime.split('-')[2].split(' ')[1].split(':')[1]
             txt += mm + '-' + dd + ' ' + hh + ':' + min
             txt += '</span>'
             txt += '<input class="form-control IssueDetailModal_cmContentData_re" value="'
             txt += data.commentList[i].cmContent
             txt += '" readonly>'
          }
       }
    }

    //코멘트 생성
    const showComment = (data) => {
       console.log(data.commentList)
       txt =''
       for(let i = 0; i < data.commentList.length; i++){
          if(data.commentList[i].cmSuper == 0){
             txt += '<p class="commentArea_comment" cmNum="'
             txt += data.commentList[i].cmNum
             txt += '" mId="'
             txt += data.commentList[i].mId
             txt += '">'
             // txt += data.commentList[i].mId
             ///
             $.ajax({
               url : 'getNickname',
               data : {
                 mId : data.commentList[i].mId
               },
               type : 'post',
               success : (nickname) => {
                 txt += '<span>'
                 txt += nickname
                 txt += '</span>'
               },
               async : false
             })

             if($('#loginUser').val() == data.commentList[i].mId){
               //답글 작성자가 본인이면 삭제 버튼 활성화
               txt += '<button class="IssueDetailModal_deleteCmBtn btn btn-sm">X</button>'
             }
             txt += '<button class="IssueDetailModal_reCmFormBtn btn btn-sm" IssueDetailModal_reCmFormBtn="0">R</button>'
             txt += '<span class="IssueDetailModal_cmTime">'
             //////문제 있음
             let mm = data.commentList[i].cmWriteTime.split('-')[1]
             let dd = data.commentList[i].cmWriteTime.split('-')[2].split(' ')[0]
             let hh = data.commentList[i].cmWriteTime.split('-')[2].split(' ')[1].split(':')[0]
             let min = data.commentList[i].cmWriteTime.split('-')[2].split(' ')[1].split(':')[1]
             txt += mm + '-' + dd + ' ' + hh + ':' + min
             txt += '</span>'
             txt += '<input class="form-control IssueDetailModal_cmContentData" value="'
             txt += data.commentList[i].cmContent
             txt += '" readonly>'

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
            <div class="IssueDetailModal_reCmForm">
             <button class="IssueDetailModal_reCmCancleBtn btn btn-sm">X</button>
             <button class="IssueDetailModal_reCmConfirmBtn btn btn-sm">O</button>
             <input type="text" class="IssueDetailModal_reCmContent form-control">
             <span class="tap"></span><div class="IssueDetailModal_nickname">
              <span>${loginUser.mNickname}</span>
            </div>
             </div>
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
       console.log($(this).parents('p').attr('cmNum'));
       console.log($(this).siblings('.IssueDetailModal_reCmContent').val());
       $.ajax({
          url : 'addComment',
          data : {
             pNum : ${project.pNum},
             tNum : selectedTask,
             iNum : selectedIssue,
             mId : $('#loginUser').val(),
             cmContent : $(this).siblings('.IssueDetailModal_reCmContent').val(),
             cmSuper :  $(this).parents('p').attr('cmNum')
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

    //체크리스트 추가폼 생성
    $(document).on('click', '#IssueDetailModal_addCheckListForm', function () {
       var txt = ''
       txt += '<input type="text" id="checkListName" class="form-control" placeholder="체크리스트 이름 입력"/>'
       txt += '<button id="addCheckListBtn" class="btn">저장</button>'
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
       txt += '<div class="addCheckListItemForm_inner">'
       txt += '<button id="addCheckListItemCancelBtn" class="btn btn-sm">X</button>'
       txt += '<button id="addCheckListItemBtn" class="btn btn-sm">O</button>'
       txt += '<i class="material-icons modal_icon">subdirectory_arrow_right</i><input type="text" id="addCheckListItemName" class="form-control" placeholder="새 체크리스트 생성">'
       txt += '</div>'
       // txt += '====이슈 할당 멤버===='
       // for(let i = 0; i < issueMember.length; i++){
       //    txt += '<div class="unasassingedCheckListItemMember" mId="'
       //    txt += issueMember[i].mId
       //    txt += '">'
       //    txt += issueMember[i].mId
       //    txt += '</div>'
       // }
       // txt += '====체크리스트 할당 멤버===='
       // txt += '<div id="singedCheckListItemMember"></div>'
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
      alert('이슈 시작일이 종료일보다 늦을 수 없습니다.')
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
     alert('이슈 종료일이 시작일보다 빠를 수 없습니다.')
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
