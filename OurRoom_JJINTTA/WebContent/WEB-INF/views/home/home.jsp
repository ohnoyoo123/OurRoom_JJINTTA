<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<style type="text/css">
#innerFrame {
	display: inline-block;
	width: 90%;
}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$('#memberSearch')
								.on(
										'keyup',
										function() {
											var searchMembers = []
											var word = $("#memberSearch").val();

											if (word.length == 0) {
												$('#searchedMember').html("");
												return;
											}

											$
													.ajax({
														url : 'project/memberSearch',
														data : {
															mId : $(
																	'#memberSearch')
																	.val()
														},
														type : "post",

														success : function(data) {

															console.log(data);

															if (data.length == 0) {
																$(
																		'#searchedMember')
																		.html(
																				"검색된 회원이 없습니다.");
																return;
															}

															for (var i = 0; i < data.length; i++) {
																if ('${loginUser.mId}' != data[i].mId) {
																	//members.push("<p class='member' mId="+data[i].mId+" mNickname="+data[i].mNickname+">"+data[i].mNickname+"</p>")
																	searchMembers
																			.push("<p class='member' mNickname="+data[i].mNickname+" mId="+data[i].mId+">"
																					+ data[i].mNickname
																					+ "("
																					+ data[i].mId
																					+ ")</p>")
																}
															}
															$('#searchedMember')
																	.html(
																			searchMembers)
														}
													})
										})

						var invitedId = []
						var invitedNickname = []

						$(document).on('click', '.member', function() {
							var mNickname = $(this).attr('mNickname')
							var mId = $(this).attr('mId')
							if (!invitedId.includes(mId)) {
								invitedId.push(mId)
								invitedNickname.push(mNickname)
							}

							var temp = ''
							for (var i = 0; i < invitedId.length; i++) {
								temp += invitedNickname[i]
								temp += '('
								temp += invitedId[i]
								temp += ')'
								temp += '<br/>'
							}
							$('#projectMember').val(invitedId)
							$('#invitedMember').html(temp)

						})

						$('#newProject')
								.on(
										'click',
										function() {
											$
													.ajax({
														url : "project/newProject",
														data : {
															pName : $('#pName')
																	.val(),
															owner : 'hong123@gmail.com',
															members : invitedId
														},
														type : "post",
														success : function(data) {
															location.href = 'project/gantt?pNum='
																	+ data
														}
													})
										})
					})
</script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<c:choose>
			<c:when test="${empty projectList  }">
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#addProject">프로젝트 추가</button>

				<!-- The Modal -->
				<div class="modal" id="addProject">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">
									프로젝트명: <input type="hidden" name="owner"
										value="hong123@gmail.com">
									<%-- ${세션에 있는 아이디 mId} --%>
									<input type="text" placeholder="enter project name" id="pName">
								</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								팀원 초대: <input type="text" placeholder="enter email or nickname"
									id="memberSearch">
								<!-- 	<input type="button" class='btn' value="검색" id="memberSearchBtn"> -->
								<br> ===검색 결과 멤버 ===
								<p id="searchedMember"></p>
								=== 초대된 멤버 ===
								<p id="invitedMember"></p>
								<br /> 배경화면 선택: API..

							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-success" id="newProject">생성</button>
								<button type="button" class="btn btn-danger"
									data-dismiss="modal">Close</button>
							</div>

						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<!-- 2018. 8. 31. 시작 -->
				<h1>Home</h1>
				<br>
				<h2>프로젝트리스트</h2>
				<div>
					<table border="1">
						<tr>
							<th>pNum</th>
							<th>pName</th>
							<th>pStartDate</th>
							<th>pEndDate</th>
						</tr>
						<c:forEach var="project" items="${projectList }">
							<tr>
								<td>${project.pNum }</td>
								<td><a href="project/gantt?pNum=${project.pNum }">${project.pName }</a></td>
								<td><fmt:formatDate value="${project.pStartDate }"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${project.pEndDate }"
										pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>

				<br>
				<h2>프로젝트 멤버 리스트</h2>
				<br>
				<div>
					<table border="1">
						<tr>
							<th>pNum</th>
							<th>mId</th>
							<th>pmIsAdmin</th>
							<th>pmIsAuth</th>
							<th>pmFav</th>
						</tr>
						<c:forEach var="projectMember" items="${projectMemberList }">
							<tr>
								<td>${projectMember.pNum }</td>
								<td>${projectMember.mId }</td>
								<td>${projectMember.pmIsAdmin }</td>
								<td>${projectMember.pmIsAuth }</td>
								<td>${projectMember.pmFav }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<h2>공지존재하는 태스크 리스트</h2>
				<br>
				<div></div>
				<h2>로그정보</h2>
				<br>
				<script>
					$(function() {
	
						$.ajax({
							url : "getProjectLog",
							data : {
								pNum : "17"
							},
							type : "post",
							success : function(data){
								console.log(data);
							}
						});
					});
					
				</script>
				<div id="log_div">
					<table border="1">
						<tr>
							<th>pNum</th>
							<th>mId</th>
							<th>lNum</th>
							<th>lCat</th>
							<th>lTime</th>
							<th>lName</th>
						</tr>
						<c:forEach var="projectLog" items="${projectLogList }">
							<tr>
								<td>${projectLog.pNum }</td>
								<td>${projectLog.mId }</td>
								<td>${projectLog.lNum }</td>
								<td>${projectLog.lCat }</td>
								<td>${projectLog.lTime }</td>
								<td>${projectLog.lName }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>