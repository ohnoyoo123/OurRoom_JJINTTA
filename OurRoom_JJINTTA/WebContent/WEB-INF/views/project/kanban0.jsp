<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
<style type="text/css">
#ideas, #toDo, #doing, #done, #review {
	float: left;
	background-color: #0099ff;
	width: 18%;
	display: inline-block;
	margin-left: 10px;
	margin-right: 10px;
	text-align: center;
	border-radius: 10px;
}

.issue {
	background-color: #ff9999;
	margin: 5px;
	border-radius: 10px;
	height: 80px;
}

.addIssue {
	background-color: #ffff66;
	margin: 5px;
	border-radius: 10px;
	height: 40px;
}
</style>

<script>
  $(function(){
    $(".datepicker").datepicker();
  });
</script>

</head>

<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<div id="projectInfo"></div>
		<div id="taskInfo"></div>
		<div id="ideas">ideas</div>
		<div id="toDo">toDo</div>
		<div id="doing">doing</div>
		<div id="done">done</div>
		<div id="review">review</div>
	</div>

	<!-- 이슈 상세보기 모달 -->
	<div class="modal fade" id="issueModal"></div>


	<!-- 이슈 추가 모달 -->
	<div class="modal fade" id="addIssueModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						이슈:<br> <input type="text" placeholder="enter issue name"
							id="iName">
					</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					팀원 할당 : <br>
					<c:forEach items="${projectMemberList}" var="pm">
						<div class="selectedMId" mId=${pm.mId}>${pm.mId}</div>
					</c:forEach>
				</div>
				할당된 팀원 : <br>
				<div class="modal-body" id="assignedMember"></div>
				<div class="modal-body" id="selectedMId"></div>
				<div class="modal-body">
					<div>
						시작 : <br> <input type="text" class="datepicker"
							id="iStartDate">
					</div>
					<div>
						종료 : <br> <input type="text" class="datepicker" id="iEndDate">
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="addIssueConfirm">Add</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						id="issueModalClose">Close</button>
				</div>

			</div>
		</div>
	</div>

</body>
<script type="text/javascript">

  $(document).ready(() => {

    $(document).on('click', '#viewGantt', () => {
      location.href = `gantt?pNum=${project.pNum}`
    })

    const projectInfo = () => {
      $('#projectInfo').html(
        `<table class="table table-bordered">
          <tr>
            <th>프로젝트 번호</th>
            <th>프로젝트 이름</th>
            <th>프로젝트 시작</th>
            <th>프로젝트 종료</th>
          </tr>
          <tr>
            <td>${project.pNum}</td>
            <td id="viewGantt">${project.pName}</td>
            <td><fmt:formatDate value="${project.pStartDate}" type="date" pattern="yyyy-MM-dd"/></td>
            <td><fmt:formatDate value="${project.pEndDate}" type="date" pattern="yyyy-MM-dd"/></td>
          </tr>
        </table>`
      )
    }

    const taskInfo = () => {
      $('#taskInfo').html(
        `<table class="table table-bordered">
          <tr>
            <th>태스크 번호</th>
            <th>태스크 이름</th>
            <th>태스크 시작</th>
            <th>태스크 종료</th>
            <th>태스크 공지</th>
          </tr>
          <tr>
            <td>${task[0].tNum}</td>
            <td>${task[0].tName}</td>
            <td><fmt:formatDate value="${task[0].tStartDate}" type="date" pattern="yyyy-MM-dd"/></td>
            <td><fmt:formatDate value="${task[0].tEndDate}" type="date" pattern="yyyy-MM-dd"/></td>
            <td id="tNoti">${task[0].tNotiName}</td>
          </tr>
        </table>
        `
      )
    }

    const ideas = () => {
      $('#ideas').html(
        `<h3 class="iStep" iStep="0">IDEAS</h3>
        <c:forEach items="${issueList}" var="issue">
          <c:if test="${issue.iStep == 0}">
            <div class="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
              ${issue.iName}
            </div>
          </c:if>
        </c:forEach>
        <div class="addIssue" data-toggle="modal" data-target="#addIssueModal">[+]
        </div>
        `
      )
    }

    const toDo = () => {
      $('#toDo').html(
        `<h3 class="iStep" iStep="1">TO DO</h3>
        <c:forEach items="${issueList}" var="issue">
          <c:if test="${issue.iStep == 1}">
            <div class="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
              ${issue.iName}
            </div>
          </c:if>
        </c:forEach>
        <div class="addIssue" data-toggle="modal" data-target="#addIssueModal">[+]
        </div>
        `
      )
    }

    const doing = () => {
      $('#doing').html(
        `<h3 class="iStep" iStep="2">DOING</h3>
        <c:forEach items="${issueList}" var="issue">
          <c:if test="${issue.iStep == 2}">
          <div class="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
              ${issue.iName}
            </div>
          </c:if>
        </c:forEach>
        <div class="addIssue" data-toggle="modal" data-target="#addIssueModal">[+]
        </div>
        `
      )
    }

    const done = () => {
      $('#done').html(
        `<h3 class="iStep" iStep="3">DONE</h3>
        <c:forEach items="${issueList}" var="issue">
          <c:if test="${issue.iStep == 3}">
          <div class="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
              ${issue.iName}
            </div>
          </c:if>
        </c:forEach>
        <div class="addIssue" data-toggle="modal" data-target="#addIssueModal">[+]
        </div>
        `
      )
    }

    const review = () => {
      $('#review').html(
        `<h3 class="iStep" iStep="4">REVIEW</h3>
        <c:forEach items="${issueList}" var="issue">
          <c:if test="${issue.iStep == 4}">
          <div class="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
              ${issue.iName}
            </div>
          </c:if>
        </c:forEach>
        <div class="addIssue" data-toggle="modal" data-target="#addIssueModal">[+]
        </div>
        `
      )
    }

    //이슈멤버 리스트
    var issueMember = []

    //체크리스트 친구들 만들기
    var showCheckList = (data) => {


      $('#issueModal').html(`
        <div class="modal-dialog">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h1 class="modal-title" id="issueName">\${data.issueList[0].iName}</h1>
              <div id="issueDate">
                <div>
                  시작 : <br>
                  <%-- <input type="text" class="datepicker" id="iStartDate"> --%>
                  <input type="text" class="datepicker" id="iStartDate" value="\${new Date(data.issueList[0].iStartDate)}">
                </div>
                <div>
                  종료 : <br>
                  <input type="text" class="datepicker" id="iEndDate" value="\${new Date(data.issueList[0].iEndDate)}">
                </div>
              </div>
              <div id="issueMember">
              </div>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <h3>체크리스트<button id="addCheckListForm">[+]</button></h3>
            </div>
            <div id="checkListNameForm">
            </div>
            <div class="modal-body" id="checkList">
              <c:forEach items="${data.checkList}" var="checkList">
                \${checkList}
              </c:forEach>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>

          </div>
        </div>
        `)


      // let txt =''
      //     for (var i = 0; i < data.checkList.length; i++) {
      //       txt += '<div class=\'checkList\''
      //       txt += ' pNum=' + data.checkList[i].pNum
      //       txt += ' tNum=' + data.checkList[i].tNum
      //       txt += ' iNum=' + data.checkList[i].iNum
      //       txt += ' clNum=' + data.checkList[i].clNum
      //       txt += ' clName = ' + data.checkList[i].clName
      //       txt += '>'
      //       txt += '======================================================================<br>'
      //       txt += '체크리스트 이름 : ' + data.checkList[i].clName
      //       txt +=  '<button style="float:right;" class="deleteCheckList">X</button>'
      //       txt +=  '<button style="float:right;" class="addCheckListItem">O</button><br>'
      //       txt += '<div class="addCheckListItemForm"></div>'
      //       txt += '======================================================================'
      //       for (var j = 0; j < data.checkListItem.length; j++) {
      //         if (data.checkList[i].clNum == data.checkListItem[j].clNum) {
      //           txt += '<div class="checkListItem" ciNum="' + data.checkListItem[j].ciNum + '">'
      //           txt += '&emsp;체크리스트 아이템 : ' + data.checkListItem[j].ciName + '<button class="deleteCheckListItemBtn">X</button><br>'
      //           for(var k = 0; k < data.checkListItemMember.length; k++){
      //             if(data.checkListItem[j].ciNum == data.checkListItemMember[k].ciNum){
      //               txt += data.checkListItemMember[k].mId
      //               txt += '<br>'
      //             }
      //           }
      //           txt += '----------------------'
      //           txt += '</div>'
      //         }
      //       }
      //       txt += '</div>'
      //       txt += '</div>'
      //       txt += '</div>'
      //       txt += '<br>'
      //     }
      //     $('#checkList').html(txt)
      //     $('#checkListNameForm').empty()

    }


    //이슈 상세 보기
    $(document).on('click', '.issue', function(){
      $.ajax({
        url : 'issueDetail',
        data : {
          pNum : ${project.pNum},
          tNum : ${task[0].tNum},
          iNum : $(this).attr('iNum')
        },
        type : 'post',
        success : (data) => {
          $('#issueName').attr('pNum', (data.issueList[0].pNum))
          $('#issueName').attr('tNum', (data.issueList[0].tNum))
          $('#issueName').attr('iNum', (data.issueList[0].iNum))
          $('#issueName').html(data.issueList[0].iName)
          $('#issueMember').html('')


          $('#iStartDate').val(new Date(data.issueList[0].iStartDate))
          $('#iEndDate').val(new Date(data.issueList[0].iEndDate))
          issueMember = []
          var txt = ''
          for (var k = 0; k < data.issueMember.length; k++) {
            issueMember.push(data.issueMember[k].mId)
            txt += '<p mId="'
            txt += data.issueMember[k].mId
            txt += '">'
            txt += data.issueMember[k].mId
            txt += '</p>'
          }
          $('#issueMember').html(txt)
          // $('#issueMember').append(...issueMember)
          showCheckList(data)

        }
      })
    })

    //이슈 맴버 할당
    var selectedMId = []
    $('.selectedMId').on('click', function () {
      if (!selectedMId.includes($(this).attr("mId"))) {
        selectedMId.push($(this).attr("mId"))
        $('#assignedMember').html(selectedMId)

      }
      console.log(selectedMId);

    })

    //이슈 추가하기
    $(document).on('click', '#addIssueConfirm', function () {

      var array = []
      for (var i = 0; i < selectedMId.length; i++) {
        array.push(i)
      }

      $.ajax({
        url: "addIssue",
        data: {
          pNum: ${project.pNum},
          tNum: selectedTask,
          iStep: 1,
          iName: $('#iName').val(),
          iStartDate: function () {
            if ($('#iStartDate').val().length > 0) {
              return $('#iStartDate').val()
            } else {
              return new Date
            }
          },
          iEndDate: function () {
            if ($('#iEndDate').val().length > 0) {
              return $('#iEndDate').val()
            } else {
              return new Date
            }
          },
          members: selectedMId
        },
        type: "post",
        success: function () {
          location.reload()
        }
      })
    })






    projectInfo()
    taskInfo()
    ideas()
    toDo()
    doing()
    done()
    review()










  })

</script>
</html>
