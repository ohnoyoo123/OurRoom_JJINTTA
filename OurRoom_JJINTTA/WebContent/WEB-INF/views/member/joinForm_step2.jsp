<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입-step2  페이지</h1>
	<form action="joinForm_step3"  method="post">
		<input type="hidden" id="mId" name="mId" value="${member.mId}">
		<input type="hidden" id="mPw" name="mPw" value="${member.mPw}">
		<input type="hidden" id="mNickname" name="mNickname"
			value="${member.mNickname}"> <input type="hidden"
			id="mQuestion" name="mQuestion" value="${member.mQuestion}">
		<input type="hidden" id="mAnswer" name="mAnswer"
			value="${member.mAnswer}">

		<script>
			$(document).ready(function() {
				$("#profileImg").click(function() {
					$("#input_img").click();
				})
			})
		</script>


		<script>
			var sel_file;

			$(document).ready(function() {
				$("#img").on("change", fileChange);
			});

			function fileChange(e) {
				e.preventDefault();

				var files = e.target.files;
				var filesArr = Array.prototype.slice.call(files);

				filesArr.forEach(function(f) {
					if (!f.type.match("image.*")) {
						alert("확장자는 이미지 확장자만 가능합니다.");
						return;
					}

					sel_file = f;

					var reader = new FileReader();
					reader.onload = function(e) {
						$("#profileImg").attr("src", e.target.result);
						$("#profileImg").css("height", "100px")
					}
					reader.readAsDataURL(f);
				});

				var file = files[0]
				console.log(file)
				var formData = new FormData();

				formData.append("file", file);
				$.ajax({
					url : 'uploadAjax.do',
					data : formData,
					dataType : 'text',
					processData : false,
					contentType : false,
					type : 'POST',
					success : function(data) {

						alert("프로필 이미지가 변경 되었습니다.")

					},
					error : function(data) {
						alert("에러에러!!")
					}
				})

				function checkImageType(fileName) {
					var pattern = /jpg$|gif$|png$|jpeg$/i;
					return fileName.match(pattern);
				}

				function getOriginalName(fileName) {
					if (checkImageType(fileName)) {
						return;
					}

					var idx = fileName.indexOf("_") + 1;
					return fileName.substr(idx);

				}

				function getImageLink(fileName) {

					if (!checkImageType(fileName)) {
						return;
					}
					var front = fileName.substr(0, 12);
					var end = fileName.substr(14);

					return front + end;

				}

			}
		</script>

		<c:choose>
			<c:when test="${empty userImage }">
				<div>
					<img id="profileImg" src="/displayFile?fileName=/lion.gif"
						style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<img id="profileImg" src="/displayFile?fileName=${userImage }"
						style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
				</div>
			</c:otherwise>
		</c:choose>

		<input type="file" id="img" name="img" size="30"><br>
		<input type="button" onclick="history.go(-1)" value="취소">
		<input type="submit" value="다음">


	</form>
</body>
</html>