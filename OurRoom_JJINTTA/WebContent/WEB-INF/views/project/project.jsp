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
		background-color: yellow;
		display: inline-block;
		width: 90%;

	}
</style>
</head>
<body>
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
						<a onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</a>
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
						<a onclick="location.href='gantt?pNum=${pm.pNum }'">${pList.pName }</a>
					</c:if>
					<br>
				</c:forEach>
			</c:if>
		</c:forEach>
	<h2>종료된 프로젝트</h2>
		<c:forEach items="${pastProject }" var="past">
			<a onclick="location.href='gantt?pNum=${past.pNum }'">${past.pName }</a>
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
            <form class="" action="project/newProject" method="post">

	        	<input type="text" placeholder="enter project name" name="pName">
	        </h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>

	      <!-- Modal body -->
	      <div class="modal-body">
	        	팀원 초대:
	        	<input type="text" placeholder="enter email or nickname" id="memberSearch" name="mId">
	        	<input type="button" class='btn' value="검색" id="memberSearchBtn">
            <p id="searchedMember">===검색 결과 멤버 ===</p>
            <br/>
            배경화면 선택: API..

	      </div>

	      <!-- Modal footer -->
	      <div class="modal-footer">
          <input type="submit" class="btn btn-success" value="생성">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
          </form>
	      </div>

	    </div>
	  </div>
	</div>

<script type="text/javascript">
  $(document).ready(function () {
		
		var selectedMembers = []

    $('#memberSearchBtn').on('click',function () {
      var members = []
      $.ajax({
        url:'../project/memberSearch',
        data: {
          mId: $('#memberSearch').val()
        },
        type: "post",

        success: function (data) {
          console.log(data);
          for(var i=0; i<data.length; i++){
            members.push(data[i].mNickname)
          }
          $('#searchedMember').append(members)
        }
      })
    })

  })
</script>

</body>
</html>
