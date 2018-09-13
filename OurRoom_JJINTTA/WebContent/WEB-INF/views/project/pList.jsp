<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">

	#innerFrame{
		background-color: ;
		display: inline-block;
		width: 90%;

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
						<p style="cursor:pointer;" onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</p>
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
							<p style="cursor:pointer;" onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</p>
						<br>
					</c:if>
				</c:forEach>
			</c:if>
		</c:forEach>
	<h2>종료된 프로젝트</h2>
		<c:forEach items="${pastProject }" var="past">
			<p style="cursor:pointer;" onclick="location.href='gantt?pNum=${past.pNum }'">${past.pName }</p>
			<br>
		</c:forEach>
	</div>

	<!-- The Modal -->
	<div class="modal" id="addProject">
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

          console.log(data);

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
  })
</script>

</body>
</html>
