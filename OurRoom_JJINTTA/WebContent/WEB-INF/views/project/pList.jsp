<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
<style type="text/css">

	#innerFrame{
		background-color: ;
		display: inline-block;
		width: 90%;

	 }


  .openProjectModal{
    cursor : pointer;
  }

  #projectChartModal .modal-dialog{
    width: 70vw;
  }

  .projectChartModal_chartBody{
    width: 50%;
    height: 50%;
    display: block;
    margin : 0;
    padding: 0;
    float: left;
  }

  #projectChartModal_chartBody_projectInfo,
  #projectChartModal_chartBody_projectProgress,
  #projectChartModal_chartBody_signedIssue,
  #projectChartModal_chartBody_completedIssue
  {
    width : 50%;
    height: 50%;
  }

</style>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.5.1/snap.svg-min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
  <link rel="stylesheet"
  	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.9.0.js"></script>
  <script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
</head>
<body>

  <script>
    $(function () {
      $(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
    });
  </script>
<jsp:include page="../mainFrame.jsp"/>

	<div id = "innerFrame">

	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addProject">
	프로젝트 추가
	</button>
	<h2>즐겨찾기 프로젝트</h2>
		<c:forEach items="${pmList}" var="pm">
			<c:if test="${pm.pmFav}">
				<c:forEach items="${progProject}" var="pList">
					<c:if test="${pList.pNum==pm.pNum }">
						<%-- <a onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName}</a> --%>
            <span class="openProjectChartModal" pNum="${pList.pNum}" data-target="#projectChartModal" data-toggle="modal">${pList.pName}</span>
					</c:if>
          <br>
				</c:forEach>
			</c:if>
		</c:forEach>
	<h2>진행중인 프로젝트</h2>
		<c:forEach items="${pmList}" var="pm">
			<c:if test="${!pm.pmFav}">
				<c:forEach items="${progProject}" var="pList">
					<c:if test="${pList.pNum==pm.pNum }">
						<br>
						<%-- <a onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</a> --%>
            <span class="openProjectChartModal" pNum="${pList.pNum}" data-target="#projectChartModal" data-toggle="modal">${pList.pName}</span>
						<br>
					</c:if>
				</c:forEach>
			</c:if>
		</c:forEach>
	<h2>종료된 프로젝트</h2>
		<c:forEach items="${pastProject }" var="past">
			<%-- <a onclick="location.href='gantt?pNum=${past.pNum }'">${past.pName }</a> --%>
      <span class="openProjectChartModal" pNum="${past.pNum}" data-target="#projectChartModal" data-toggle="modal">${past.pName}</span>
			<br>
		</c:forEach>
	</div>

	<!-- The Modal -->
	<div class="modal fade" id="addProject">
	  <div class="modal-dialog">
	    <div class="modal-content">

	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">
	       		프로젝트명:
              <input type="hidden" name="owner" value="${loginUser.mId}" > <%-- ${세션에 있는 아이디 mId} --%>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <div class="col-xs-10" style="margin-left:-12px;">
                <input type="text" id="pName" class="form-control">
              </div>

	        </h4>


	      </div>

	      <!-- Modal body -->
	      <div class="modal-body">
          <div class="col-xs-4" style="margin-left:-12px;">
            시작 : <br> <input type="text" class="datepicker pStartDate form-control" readonly>
          </div>
          <div class="col-xs-4">
            종료 : <br> <input type="text" class="datepicker pEndDate form-control" readonly>
          </div>
          <br/>
          <br/>
          <br/>
          <br/>
          <div class="">
            <p>팀원 초대:</p>



	        	<input type="text" id="memberSearch" class="form-control">
					<!-- 	<input type="button" class='btn' value="검색" id="memberSearchBtn"> -->
						<br>
            ===검색 결과 멤버 ===
            <p id="searchedMember"></p>
            === 초대된 멤버 ===
            <p id="invitedMember"></p>
            <br/>
          </div>

            <button type="button" class="btn btn-success" id = "newProject">생성</button>
  	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>

	      <!-- Modal footer -->
	      <div class="modal-footer">

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

  $(document).ready(function () {

    $('#memberSearch').on('keyup',function () {
      	var searchMembers = []
      	var word = $("#memberSearch").val();

      	if (word.length == 0) {
      		$('#searchedMember').html("");
			return;
		}

      $.ajax({
        url:'../project/memberSearch',
        data: {
          mId: $('#memberSearch').val()
        },
        type: "post",

        success: function (data) {

	      if (data.length == 0) {
	    		$('#searchedMember').html("검색된 회원이 없습니다.");
	    		return;
		  }

          for(var i=0; i<data.length; i++){
        	  if ('${loginUser.mId}' != data[i].mId) {
            //members.push("<p class='member' mId="+data[i].mId+" mNickname="+data[i].mNickname+">"+data[i].mNickname+"</p>")
            searchMembers.push("<p class='member' mNickname="+data[i].mNickname+" mId="+data[i].mId+">"+data[i].mNickname+
            "("+data[i].mId+")</p>")
        	  }
          }
          $('#searchedMember').html(searchMembers)
        }
      })
    })


        var invitedId=[]
        var invitedNickname=[]

    $(document).on('click', '.member', function () {
        var mNickname = $(this).attr('mNickname')
        var mId = $(this).attr('mId')
        if(!invitedId.includes(mId)){
          invitedId.push(mId)
          invitedNickname.push(mNickname)
        }

        var temp=''
        for(var i=0; i<invitedId.length; i++){
          temp+=invitedNickname[i]
          temp+='('
          temp+=invitedId[i]
          temp+=')'
          temp+='<br/>'
        }
        $('#projectMember').val(invitedId)
        $('#invitedMember').html(temp)

    })

		$('#newProject').on('click', function () {
			$.ajax({
				url : "newProject",
				data : {
					pName : $('#pName').val(),
          pStartDate: $('.pStartDate').val(),
          pEndDate: $('.pEndDate').val(),
					owner : '${loginUser.mId}',
					members : invitedId
				},
				type : "post",
				success : function (data) {
					location.href='gantt?pNum=' + data
				}
			})
		})

    //프로젝트 번호 판별용
    let selectedProject = 0
    $('.openProjectChartModal').on('click', function(){
      selectedProject = $(this).attr('pNum')

    })


    //모달창 생성하면서 데이터 불러오기(프로젝트 차트용)
    $("#projectChartModal").on('shown.bs.modal', function() {
      $.ajax({
        url : 'projectChart',
        data : {
          pNum : selectedProject
        },
        type : 'post',
        success : (data) => {

          showProjectChartModal(data)
        }
      })
    })

    // var projectInfo = document.getElementById("projectChartModal_chartBody_projectInfo").getContext('2d');


    let projectInfo = document.getElementById("projectChartModal_chartBody_projectInfo").getContext('2d');
    let projectProgress = document.getElementById("projectChartModal_chartBody_projectProgress").getContext('2d');
    let projectSignedIssue = document.getElementById("projectChartModal_chartBody_signedIssue").getContext('2d');
    let projectCompltedIssue = document.getElementById("projectChartModal_chartBody_completedIssue").getContext('2d');


      const showProjectChartModal = (data) => {

        $('#projectChartModal_pName').html(data.project.pName)

        const dynamicColors = function() {
           let r = Math.floor(Math.random() * 255);
           let g = Math.floor(Math.random() * 255);
           let b = Math.floor(Math.random() * 255);
           return "rgb(" + r + "," + g + "," + b + ")";
        };




        const projectChartModal_chartBody_projectInfo = new Chart(projectInfo, {
          type : 'doughnut',
          data : {
            labels : ['완료', '미완'],
            datasets : [{
              data : [80, 20],
              backgroundColor : ['#000000', '#ffffff'],
              borderColor: 'rgba(0, 0, 0, 0.75)',
              hoverBorderColor: 'rgba(0, 0, 0, 1)',
              borderWidth : 1
            }],
          },
          options : {
          },
        })

        let completedIssue = 0
        let uncompletedIssue = 0
        for(let i = 0; i < data.issueList.length; i++){
          if(data.issueList[i].iStep == 3 || data.issueList[i].iStep == 4){
            completedIssue++
          }else {
            uncompletedIssue++
          }
        }

        const projectChartModal_chartBody_projectProgress = new Chart(projectProgress, {
          type : 'pie',
          data : {
            labels : ['완료 이슈', '미완료 이슈'],
            datasets : [{
              data : [completedIssue, uncompletedIssue],
              backgroundColor : [dynamicColors(), dynamicColors()],
              borderColor: 'rgba(0, 0, 0, 0.75)',
              hoverBorderColor: 'rgba(0, 0, 0, 1)',
              borderWidth : 1
            }],
          },
          options : {
          }
        })

        let projectMember = []
        let signedIssue = []
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
          signedIssue.push(count)
        }

        const projectChartModal_chartBody_projectSignedIssue = new Chart(projectSignedIssue, {
          type : 'polarArea',
          data : {
            labels : projectMember,
            datasets : [{
              label : ' #할당 이슈',
              data : signedIssue,
              backgroundColor : colorSet,
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

        const projectChartModal_chartBody_projectCompltedIssue = new Chart(projectCompltedIssue, {
          type : 'bar',
          data : {
            labels : taskListName,
            datasets : [
              {
              label : '완료 이슈',
              data : completedIssueInTask,
              backgroundColor : ['#000000', '#000000'],
              borderColor: 'rgba(0, 0, 0, 0.75)',
              hoverBorderColor: 'rgba(0, 0, 0, 1)',
              borderWidth : 1
            },
            {
              label : '미완료 이슈',
              data : uncompletedIssueInTask,
              backgroundColor : ['#ffffff', '#ffffff'],
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


      }
})
</script>

</body>
</html>
