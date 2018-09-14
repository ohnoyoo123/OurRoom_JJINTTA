<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style>
#file {
	width: 0;
	height: 0;
}
</style>
<meta content="charset=UTF-8">
<script type="text/javascript" src="/OurRoom/js/member/member.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../mainFrame.jsp" />
	<div class="container" align="center">
		<div class="row">
			<div class="col-sm-3">
				<div class="form-group">
					<p>
						<input type="text" class="myInfo form-control"
							value="${member.mId }" placeholder="Enter Email"
							readonly="readonly">
					</p>
					<p>
						<input type="text" class="myInfo form-control"
							value="${member.mNickname }" placeholder="Enter Email"
							readonly="readonly">
					</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-5">
				<div class="form-group">
					<c:forEach var="myLog" items="${myLogList }" begin="0" end="4">
						<p>${myLog.lCat}:${myLog.lName}:${myLog.lTime }}</p>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-5">
				<div class="form-group">
					<div>
						<h2>정보수정</h2>
						<label for="mNickname">Nickname</label> <input id="mNickname"
							type="text" class="form-control" value="${member.mNickname }"
							placeholder="Enter Nickname" readonly="readonly"> <span
							id="nicknameCheckMsg"></span><br> <label for="nic">Password</label>
						<input id="mPw" type="password" class="form-control"
							placeholder="Enter Password" readonly="readonly"><br>
						<span id="pwCheckMsg"></span> <input id="mPw2" type="password"
							class="form-control" placeholder="Check Password"
							readonly="readonly">


						<button id="dropMember">회원탈퇴</button>


					</div>
				</div>
			</div>
		</div>
		<%-- ${myLogList } --%>
	</div>

	<script>
		$(function() {
			/* 닉네임 변경 버튼클릭 */
			$("#mNickname").on("dblclick", function() {

				console.log("updateNic클릭");
				$(this).removeAttr("readonly");
			});
			/* 닉네임 변경 후 enter클릭 */
			$("#mNickname").on("keyup", function(event) {
				chkNickname();
				// 변경요청
				if (event.keyCode === 13) {
					console.log("닉네임 변경하고 엔터를 눌렀다.");
					$(this).trigger('blur');
				} else if (event.keyCode === 27) { // 취소
					console.log("닉네임 변경 취소함 (esc)");
					// 기존 닉네임으로 초기화
					$(this).val('${member.mNickname}');
					// 체크메시지 초기화
					$("#nicknameCheckMsg").html('');
					// 읽기전용으로 만들기
					$(this).attr('readonly', 'readonly');
					// 포커스 잃음
					$(this).blur();
				}
			});

			/* 닉네임변경 후 blur시 r*/
			$("#mNickname").on("blur", function() {
				// 입력된 닉네임
				var mNic_input = $(this).val();
				// 입력닉네임과 기존닉네임이 같으면 취소
				if (mNic_input == '${member.mNickname}') {
					$(this).attr('readonly', 'readonly');
					// 체크메시지초기화
					$("#nicknameCheckMsg").html('');
					return false;
				}
				console.log("닉네임 변경하고 포커스를 잃었다.");
				//닉네임 검증 체크
				if (chkNickname()) { //성공

					// DB에 저장
					$.ajax({
						url : "updateNickname",
						data : {
							mId : '${member.mId}',
							mNickname : mNic_input
						},
						success : function(result) {
							console.log("저장 성공(" + result + ")");
							//새로고침하여 정보가져오기
							location.reload();
						}
					});
					$(this).attr('readonly', 'readonly');
				} else { // 실패
					$(this).val("");
					$(this).focus();
				}
			});

			/*  */
			$("#mPw").on("dblclick", function() {
				console.log("#mPw더블클릭");

				$(this).removeAttr("readonly");
				$("#mPw2").removeAttr("readonly");
			});

			/* mPw 변경후 enter 클릭*/
			$("#mPw").on("keyup", function(event) {
				console.log();

				// 변경할 비밀번호 정상입력
				if (chkPw()) {

					$(this).val('');
					$(this).focus();
					return false;

				}

				if (event.keyCode === 13) {
					console.log("비밀번호1을 변경하고 엔터눌렀다.");
					//비밀번호 검증 체크

					//검증이 완료되면 포커스 넘기기

					$("#mPw2").focus();
				}
			});

			/* mPw 변경후 enter 클릭*/
			$("#mPw2").on("keyup", function(event) {
				event.preventDefault();

				if (event.keyCode === 13) {
					console.log("비밀번호2을 변경하고 엔터눌렀다.");
					//비밀번호 검증 체크

					//검증이 완료되면 ajax로 비밀번호 변경 처리 

					//검증이 완료되면 readonly로 변경하고 텍스트를 지운다.

					$("#mPw").attr("readonly", "readonly");
					$("#mPw2").attr("readonly", "readonly");

					$("#mPw").val("");
					$("#mPw2").val("");
				}
			});
		});
	</script>
	<img id="profile" alt="" src="/OurRoom/img/default_profile.png"
		width="300px" height="300px">
	<input type='file' id='file' name='file' accept="image/*" />
	<script>
		$(function() {
			/* */
			$('#profile').click(function(e) {
				var file = $("#file");

				e.preventDefault();
				file.click();
				
				
				/* 	$.ajax({
						url : "uploadProfile",
						enctype : "multipart/form-data",
						data : formData,
						dataType : 'text',
						processData : false,
						contentType : false,
						type : 'POST',
						success : function(data) {
							alert(data);
						}
					}); */

			});

			$("#file").on("change", function() {
				
				var file = $("#file");
				console.log(file);
				var formData = new FormData();

				formData.append("profile", file);
				
				console.log(formData);
			
				$.ajax({
					url : "uploadProfile",
					type : 'POST',
					data : formData,
					dataType : 'text',
					processData : false,
					contentType : false,
					success : function(data) {
						alert(data);
					}
				});
			});

		});
	</script>

</body>
</html>