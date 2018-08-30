<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.min.js"></script>  
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		
		$("#keyword").on("keyup",function() {
			var searchMembers = [];			
			$("#keyword").val($.trim($("#keyword").val()));
			var word = $("#keyword").val();
			var searchMemberDiv = $('#searchMemberList');
			// 입력값이 없을땐 조회하지 않는다.(전체조회 막기)
			if(word.length == 0){
				searchMemberDiv.html("");
				return;
			}
			
			$.ajax({	
				url : "memberSearch",
				async : false,
				data : {
					keyword : word
					},
					success : function(data) {
						console.log(data);		
						
						if(data.length == 0){
							searchMemberDiv.html("검색된 회원이 없습니다.");
						}
				
						for (i = 0; i < data.length; i++) {
							searchMembers.push("<p class='member' mNickname="+data[i].mNickname+" mId="+data[i].mId+">"
												+ data[i].mNickname + "("+ data[i].mId+ ")</p>")

					    }
						searchMemberDiv.html(searchMembers);
					}
				});
			});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../mainFrame.jsp" />
	<div id="innerFrame">
		<h1>주소록입니다.</h1> <input type="text" id="keyword" name="keyword"	placeholder="회원검색"> 
		<div id="searchMemberList"></div>
	</div>
</body>
</html>