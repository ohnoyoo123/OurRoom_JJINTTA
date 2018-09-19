<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>
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
                  <div class="pList_fav_content_project img-rounded" onclick="location.href='/OurRoom/project/gantt?pNum=' + ${pList.pNum}">
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
                  <div class="pList_prog_content_project img-rounded" onclick="location.href='/OurRoom/project/gantt?pNum=' + ${pList.pNum}">
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
            <div class="pList_past_content_project img-rounded" onclick="location.href='/OurRoom/project/gantt?pNum=' + ${past.pNum}">
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







})
</script>

</body>
</html>
