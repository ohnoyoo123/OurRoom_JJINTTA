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


</style>

  <link rel="stylesheet" href="/OurRoom/css/pList.css">

</head>
<body>

<jsp:include page="../mainFrame.jsp"/>

	<div id = "innerFrame">

      <div id="pList_top">
        <i class="material-icons md-55 add_circle" data-toggle="modal" data-target="#addProject">add_box</i>
      </div>
      <div id="pList">
      <div id="pList_fav">
        <h2>
          <i class="material-icons md-30">favorite</i>
        <span id="pList_fav_toggle" data-toggle="collapse" data-target="#pList_fav_content">즐겨찾기 프로젝트</span>
      </h2>
          <%-- <button id="pList_fav_toggle" data-toggle="collapse" data-target="#pList_fav_content" class="btn btn-success">접기</button> --%>
        <div id="pList_fav_content" class="collapse in">
          <c:forEach items="${pmList}" var="pm">
            <c:if test="${pm.pmFav}">
              <c:forEach items="${progProject}" var="pList">
                <c:if test="${pList.pNum==pm.pNum }">
                  <div class="pList_fav_content_project openProjectChartModal" pNum="${pList.pNum}" data-target="#projectChartModal" data-toggle="modal">
                  <span>${pList.pName}</span>
                  </div>
                </c:if>
              </c:forEach>
            </c:if>
          </c:forEach>
        </div>
      </div>

      <div id="pList_prog">
        <h2>
          <i class="material-icons md-30">assignment</i>
          <span id="pList_prog_toggle" data-toggle="collapse" data-target="#pList_prog_content">진행중인 프로젝트</span>
        </h2>
        <div id="pList_prog_content" class="collapse in">
          <c:forEach items="${pmList}" var="pm">
            <c:if test="${!pm.pmFav}">
              <c:forEach items="${progProject}" var="pList">
                <c:if test="${pList.pNum==pm.pNum }">
                  <div class="pList_prog_content_project openProjectChartModal" pNum="${pList.pNum}" data-target="#projectChartModal" data-toggle="modal">
                  <span >${pList.pName}</span>
                  </div>
                </c:if>
              </c:forEach>
            </c:if>
          </c:forEach>
        </div>
      </div>

      <div id="pList_past">
        <h2>
          <i class="material-icons md-30">archive</i>
          <span id="pList_past_toggle" data-toggle="collapse" data-target="#pList_past_content">종료된 프로젝트</span>
        </h2>
        <div id="pList_past_content" class="collapse">
          <c:forEach items="${pastProject}" var="past">
            <div class="pList_past_content_project openProjectChartModal" pNum="${past.pNum}" data-target="#projectChartModal" data-toggle="modal">
            <span>${past.pName}</span>
            </div>
          </c:forEach>
        </div>
      </div>


      </div>
    </div>

 <%-- 프로젝트 추가 모달 --%>
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
            시작 : <br> <input type="text" class="datepicker form-control" id="addProjectModal_pStartDate">
          </div>
          <div class="col-xs-4">
            종료 : <br> <input type="text" class="datepicker form-control" id="addProjectModal_pEndDate">
          </div>
          <br/>
          <br/>
          <br/>
          <br/>
          <div>
            <p>팀원 초대:</p>
	        	<input type="text" id="memberSearch" class="form-control">
					<!-- 	<input type="button" class='btn' value="검색" id="memberSearchBtn"> -->
						<br>

            <p id="searchedMember"></p>
            초대된 팀원
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
  $(function () {
    $(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
  });

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
          pStartDate: $('#addProjectModal_pStartDate').val(),
          pEndDate: $('#addProjectModal_pEndtDate').val(),
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
    let signedIssue = document.getElementById("projectChartModal_chartBody_signedIssue").getContext('2d');
    let completedIssue = document.getElementById("projectChartModal_chartBody_completedIssue").getContext('2d');


      const showProjectChartModal = (data) => {
        $('.chartjs-size-monitor').remove()
        $('#projectChartModal_pName').html(data.project.pName)
        .attr('onclick', `location.href="/OurRoom/project/gantt?pNum=\${selectedProject}"`)
        .css({'cursor' : 'pointer', 'color' : 'blue'})

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

      //버튼 모양 바꾸기
      // $('#pList_fav_content').on('hidden.bs.collapse	', function(){
      //   $('#pList_fav_toggle').html('펴기')
      // })
      //
      // $('#pList_fav_content').on('shown.bs.collapse	', function(){
      //   $('#pList_fav_toggle').html('접기')
      // })
      //
      // $('#pList_prog_content').on('hidden.bs.collapse	', function(){
      //   $('#pList_prog_toggle').html('펴기')
      // })
      //
      // $('#pList_prog_content').on('shown.bs.collapse	', function(){
      //   $('#pList_prog_toggle').html('접기')
      // })
      // $('#pList_past_content').on('hidden.bs.collapse	', function(){
      //   $('#pList_past_toggle').html('펴기')
      // })
      //
      // $('#pList_past_content').on('shown.bs.collapse	', function(){
      //   $('#pList_past_toggle').html('접기')
      // })






})
</script>

</body>
</html>
