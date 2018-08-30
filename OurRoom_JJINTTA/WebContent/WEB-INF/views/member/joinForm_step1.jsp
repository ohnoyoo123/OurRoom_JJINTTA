<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		/* 회원가입 아이디 중복체크 */
		$("#mId").blur(function() {
			chkId();
		});
		
		/* 회원가입 패스워드 체크 */
		$("#mPw").blur(function(){
			chkPw(); 
		});
		
		/* 회원가입 패스워드 확인 체크 */
		$("#mPw2").blur(function(){
			chkPw2(); 
		});
		
		/* 회원가입 닉네임 체크 */
		$("#mNickname").blur(function(){
			chkNickname(); 
		});
		
		/* 회원가입 답변 체크 */
		$("#mAnswer").blur(function(){
			chkAnswer();
		});
		
		/* 취소버튼 클릭 시 */
		$("#cancelBtn").on("click",function(){
			
			var isCancel = window.confirm("취소하시겠습니까?");
			if(isCancel){
				location.href="loginForm";
			}
		});
		
		/* ID, PW, Nickname, 답변 유효성 체크 및 submit */
		$("#nextBtn").on("click",function(){
			if(chkId()&chkPw()&chkNickname()&chkAnswer()&chkPw2()){
				$("#form").submit();
			}
			return false;
		});
		
	});
	/* ID Check */
	function chkId(){
		var isOk;
		$("#mId").val($.trim($("#mId").val()));
		var strId = $("#mId").val(); 
		var pattern = /^([\w]{1,})+[\w\.\-\_]+([\w]{1,})+@(?:[\w\-]{2,}\.)+[a-zA-Z]{2,}$/;
		var bChecked = pattern.test(strId);
		
		// 좌우 공백 제거
		//$("#mId").val($.trim($("#mId").val()));
	
		//ar strId = $("#mId").val();
		
		// ID 이메일형식 체크
		if(!bChecked){
			$("#idCheckMsg").css("color", "red");
			$("#idCheckMsg").html("이메일 형식으로 입력해주세요.");
			return false;
		}
		
		// ID 중복체크 
		$.ajax({
			url : "idCheck",
			async: false,
			data : {
				mId : $("#mId").val()
			},
			success : function(result) {
				if (result) {
					$("#idCheckMsg").css("color", "red");
					$("#idCheckMsg").html("이미 사용중인 아이디입니다.");
					isOk = false;
					
				}else{ 
					$("#idCheckMsg").css("color", "green");
					$("#idCheckMsg").html("사용 가능한 아이디입니다.");
					isOk = true;
				}  
			},
			error : function(result) {    
				$("#idCheckMsg").html("에러..." + result);
				isOk = false;
			}
		});
		return isOk;
	}
	
	/* PW Check */
	function chkPw(){
		
		$("#mPw").val($.trim($("#mPw").val()));
		 var strPw = $("#mPw").val()+'';
		 var num = strPw.search(/[0-9]/g);
		 var eng = strPw.search(/[a-z]/ig);
		 var spe = strPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		 // 비밀번호확인 텍스트 초기화
		 $("#pw2CheckMsg").html("");
		 
		 if(strPw.length < 8 || strPw.length > 20){

			$("#pwCheckMsg").css("color", "red"); 
			$("#pwCheckMsg").html("8자 이상, 20자 이하로 입력하세요");
			return false;
		 }
		 if(strPw.search(/₩s/) != -1){
			$("#pwCheckMsg").css("color", "red");
			$("#pwCheckMsg").html("비밀번호는 공백없이 입력해주세요.");
			return false;
		 } 
		 if(num < 0 || eng < 0 || spe < 0 ){
			$("#pwCheckMsg").css("color", "red");
			$("#pwCheckMsg").html("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
			return false;
		 }

		$("#pwCheckMsg").css("color", "green");
		$("#pwCheckMsg").html("사용 가능합니다.");
			
		return true;

	}
	// mPw와 mPw2가 같은지 비교
	 function chkPw2() {
        var pw = $("#mPw").val();
        var pw2 = $("#mPw2").val();
 
        if(!chkPw()){
			$("#pw2CheckMsg").html("");
        	return false;
        }
        
        if (pw != pw2) {
        	$("#pw2CheckMsg").css("color", "red");
			$("#pw2CheckMsg").html("비밀번호가 다릅니다.");
            return false;
        }else{
        	$("#pw2CheckMsg").css("color", "green");
			$("#pw2CheckMsg").html("사용 가능합니다.");
            return true;
        }
	}

	
	/* Nickname Check */
	function chkNickname(){
		var isOk = false;
		
		$("#mNickname").val($.trim($("#mNickname").val()));
		var strNickname = $("#mNickname").val();
		if(strNickname.length < 2 || strNickname.length > 10) {
			$("#nicknameCheckMsg").css("color", "red");
		  	$("#nicknameCheckMsg").html("2~10자의 한글, 영문, 숫자만 사용할 수 있습니다.");
		   	return false;
		}

		var chk = /[0-9]|[a-z]|[A-Z]|[가-힣]/;

		for( var i = 0; i <= strNickname.length -1 ; i++ ){
		  if(!chk.test(strNickname.charAt(i))){
			  $("#nicknameCheckMsg").css("color", "red");
			  $("#nicknameCheckMsg").html("2~10자의 한글, 영문, 숫자만 사용할 수 있습니다.");
		   return false;
		  }
		}
		
		// NickName 중복체크 
		$.ajax({
			url : "nicknameCheck",
			async: false,
			data : {
				mNickname : $("#mNickname").val()
			},
			success : function(result) {
				if (result) {
					$("#nicknameCheckMsg").css("color", "red");
					$("#nicknameCheckMsg").html("이미 사용중인 닉네임입니다.");
					isOk = false;
					
				}else{
					$("#nicknameCheckMsg").css("color", "green");
					$("#nicknameCheckMsg").html("사용 가능한 닉네임입니다.");
					isOk = true;
				}
			},
			error : function(result) {
				$("#nicknameCheckMsg").html("에러..." + result);
				isOk = false;
			}
		});
	 	
		return isOk;
	}

	// Answer Check
	function chkAnswer(){
		$("#mAnswer").val($.trim($("#mAnswer").val()));
		var strAnswer = $("#mAnswer").val();

		if(strAnswer.length < 2 || strAnswer.length > 20) {
			$("#answerCheckMsg").css("color", "red");
		  	$("#answerCheckMsg").html("2~20자의 한글, 영문, 숫자만 사용할 수 있습니다.");
		   	return false;
		}

		var chk = /[0-9]|[a-z]|[A-Z]|[가-힣]/;

		for( var i = 0; i <= strAnswer.length -1 ; i++ ){
		  if(!chk.test(strAnswer.charAt(i))){
			  $("#answerCheckMsg").css("color", "red");
			  $("#answerCheckMsg").html("2~20자의 한글, 영문, 숫자만 사용할 수 있습니다.");
		   return false;
		  }
		}
		
		$("#answerCheckMsg").css("color", "green");
		$("#answerCheckMsg").html("사용 가능합니다.");
		return true;
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입-step1 페이지</h1>
	<form id="form" action="joinForm_step2" method="post">
		<b>아이디(E-mail)</b> <br> <input type="text" id="mId" name="mId">
		<b id="idCheckMsg"></b> <br> <b>비밀번호</b><br> <input
			type="password" id="mPw" name="mPw"> <b id="pwCheckMsg"></b><br>
		<b>비밀번호 확인</b><br> <input type="password" id="mPw2" name="mPw2">
		<b id="pw2CheckMsg"></b><br> <b>닉네임</b><br> <input
			type="text" id="mNickname" name="mNickname"> <b
			id="nicknameCheckMsg"></b> <br> <b>질문</b><br> <select
			id="mQuestion" name="mQuestion">
			<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
			<option value="2">졸업한 초등학교 이름은?</option>
			<option value="3">어머니 성함은?</option>
			<option value="4">아버지 성함은?</option>
		</select> <br> <b>답변</b><br> <input type="text" id="mAnswer"
			name="mAnswer"> <b id="answerCheckMsg"></b> <br> <br>
		<input type="button" id="cancelBtn" value="취소"> <input
			type="button" id="nextBtn" value="다음">
	</form>
</body>
</html>