<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<style type="text/css">
#innerFrame {
	display: inline-block;
	width: 95%;
	position: absolute;
	margin: 10px;
}
#addressList {
	float: left;
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
<script>
	$(function() {

		$("#keyword")
				.on(
						"keyup",
						function() {
							var searchMembers = [];
							$("#keyword").val($.trim($("#keyword").val()));
							var word = $("#keyword").val();
							var searchMemberDiv = $('#searchMemberList');
							// 입력값이 없을땐 조회하지 않는다.(전체조회 막기)
							if (word.length == 0) {
								searchMemberDiv.html("");
								return;
							}

							$
									.ajax({
										url : "memberSearch",
										async : false,
										data : {
											keyword : word
										},
										success : function(data) {
											console.log(data);

											if (data.length == 0) {
												searchMemberDiv
														.html("검색된 회원이 없습니다.");
											}

											for (i = 0; i < data.length; i++) {

												if ('${loginUser.mId}' != data[i].mId) {

													searchMembers
															.push("<p class='member' mNickname="+data[i].mNickname+" mId="+data[i].mId+">"
																	+ data[i].mNickname
																	+ "("
																	+ data[i].mId
																	+ ")</p>")

												}
											}
											searchMemberDiv.html(searchMembers);
										}
									});
						});

		/* 조회된 회원목록 클릭 이벤트 */
		$(document).on('click', '.member', function() {
			// 클릭된 회원의 아이디를 가져와 컨트롤러에 넘기고, 로그인유저의 주소록에 추가
			// 등록안된 회원 : 주소록에 등록 후 true값 리턴하여 클라이언트에서 "추가되었습니다." 메시지 출력
			// 등록된 회원    : 추가하지않고, false값 리턴하여 클라이언트에서 "주소록에 존재하는 회원입니다." 메시지 출력

			$.ajax({
				url : "addAddress",
				async : false,
				data : {
					aId : $(this).attr('mId')
				},
				success : function(result) {
					console.log("주소록 추가결과 : " + result);

					if (result) {
						alert("추가되었습니다.");
						location.reload();
					} else {
						alert("주소록에 존재하는 회원입니다.");
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		});
		/* 주소록 회원 삭제 클릭 이벤트 */
		$(document).on('click', '.deleteBtn', function() {
			// 클릭된 회원의 아이디를 가져와 컨트롤러에 넘기고, 로그인유저의 주소록에 추가
			// 등록안된 회원 : 주소록에 등록 후 true값 리턴하여 클라이언트에서 "추가되었습니다." 메시지 출력
			// 등록된 회원    : 추가하지않고, false값 리턴하여 클라이언트에서 "주소록에 존재하는 회원입니다." 메시지 출력
			$.ajax({
				url : "deleteAddress",
				async : false,
				data : {
					aId : $(this).siblings('input').val()
				},
				success : function(result) {
					console.log("주소록 추가결과 : " + result);

					if (result) {
						alert("삭제되었습니다.");
						location.reload();
					} else {

					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		});
	});
</script>
<script type="text/javascript">
	$(function(){
		
		$(".addressProject_tr").on("click",function(){
			//var pNum = $(this).children().first().text();
			//console.log(pNum);
			var searchProjectMembers = [];
			var addressProjectMemberList_div = $("#addressProjectMemberList_div");
			
			$.ajax({
				url:"addressProjectMemberList",
				data:{
					pNum : $(this).children().first().text()
				},
				success: function(data){
					console.log(data);
					for (i = 0; i < data.length; i++) {

						if ('${loginUser.mId}' != data[i].mId) {

							searchProjectMembers
									.push("<p class='member' mId="+data[i].mId+">"			
											+ data[i].mId+"</p>")

						}
					}
					addressProjectMemberList_div.html(searchProjectMembers);
				},
				error: function(e){
					console.log(e);
				}
				
				
			});
		});
		
	});
</script>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../mainFrame.jsp"></jsp:include>
<div id="innerFrame">
	<div class="container">
		<%-- <jsp:include page="../mainFrame.jsp" />--%>
		<div id="addressList" style="width: 400px; height: 300px">
			<h2>주소록회원리스트</h2>
			<hr>
			<c:forEach var="addressMember" items="${addressList }">
				<div>
					<b>${addressMember.mId }</b>
					<button class="deleteBtn btn btn-info btn-lg-1">삭제</button>
					<input type="hidden" id="aId" value="${addressMember.mId }">
					<br>
				</div>
			</c:forEach>
		</div>

		<div id="search_div" style="height: 300px">
			<h2>회원검색</h2>
			<input type="text" id="keyword" name="keyword" placeholder="회원검색">
			<div id="searchMemberList"></div>
		</div>

		<div>
			<h2>프로젝트 리스트</h2>
			<table border="1">
				<tr>
					<th>num</th>
					<th>name</th>
					<th>startDate</th>
					<th>endDate</th>

				</tr>
				<c:forEach var="addressProject" items="${projectList }">
					<tr class="addressProject_tr">
						<td class="pNum_td">${addressProject.pNum }</td>
						<td>${addressProject.pName }</td>
						<td><fmt:formatDate value="${addressProject.pStartDate }"
								pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${addressProject.pEndDate }"
								pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</table>
			<div>
				<h2>프로젝트의 포함된 회원 리스트</h2>
				<div id="addressProjectMemberList_div"></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>