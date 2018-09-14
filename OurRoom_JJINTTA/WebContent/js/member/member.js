/**
 * http://usejsdoc.org/
 */

/* Nickname Check */
function chkNickname() {
	var isOk = false;

	$("#mNickname").val($.trim($("#mNickname").val()));
	var strNickname = $("#mNickname").val();
	if (strNickname.length < 2 || strNickname.length > 10) {
		$("#nicknameCheckMsg").css("color", "red");
		$("#nicknameCheckMsg").html("2~10자의 한글, 영문, 숫자만 사용할 수 있습니다.");
		return false;
	}

	var chk = /[0-9]|[a-z]|[A-Z]|[가-힣]/;

	for (var i = 0; i <= strNickname.length - 1; i++) {
		if (!chk.test(strNickname.charAt(i))) {
			$("#nicknameCheckMsg").css("color", "red");
			$("#nicknameCheckMsg").html("2~10자의 한글, 영문, 숫자만 사용할 수 있습니다.");
			return false;
		}
	}

	// NickName 중복체크
	$.ajax({
		url : "nicknameCheck",
		async : false,
		data : {
			mNickname : $("#mNickname").val()
		},
		success : function(result) {
			if (result) {
				$("#nicknameCheckMsg").css("color", "red");
				$("#nicknameCheckMsg").html("이미 사용중인 닉네임입니다.");
				isOk = false;

			} else {
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