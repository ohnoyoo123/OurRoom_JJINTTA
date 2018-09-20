<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>OurRoom</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/OurRoom/css/modal.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="js/project.js"></script> -->
<style>
body {
	font: 400 15px Lato, sans-serif;
	line-height: 1.8;
	color: #818181;
}

h2 {
	font-size: 24px;
	text-transform: uppercase;
	color: #303030;
	font-weight: 600;
	margin-bottom: 30px;
}

h4 {
	font-size: 19px;
	line-height: 1.375em;
	/*color: #303030;*/
	font-weight: 400;
	/* margin-bottom: 30px; */
}

.jumbotron {
	background-color: #339933;
	color: #fff;
	padding: 100px 25px;
	font-family: Montserrat, sans-serif;
}

.container-fluid {
	padding: 60px 50px;
}

.bg-grey {
	background-color: #f6f6f6;
}

.logo-small {
	color: #339933;
	font-size: 50px;
}

.logo {
	color: #339933;
	font-size: 200px;
}

.thumbnail {
	padding: 0 0 15px 0;
	border: none;
	border-radius: 0;
}

.thumbnail img {
	width: 100%;
	height: 100%;
	margin-bottom: 10px;
}

.carousel-control.right, .carousel-control.left {
	background-image: none;
	color: #339933;
}

.carousel-indicators li {
	border-color: #339933;
}

.carousel-indicators li.active {
	background-color: #339933;
}

.item h4 {
	font-size: 19px;
	line-height: 1.375em;
	font-weight: 400;
	font-style: italic;
	margin: 70px 0;
}

.item span {
	font-style: normal;
}

.panel {
	border: 1px solid #339933;
	border-radius: 0 !important;
	transition: box-shadow 0.5s;
}

.panel:hover {
	box-shadow: 5px 0px 40px rgba(0, 0, 0, .2);
}

.panel-footer .btn:hover {
	border: 1px solid #f4511e;
	background-color: #fff !important;
	color: #f4511e;
}

.panel-heading {
	color: #fff !important;
	background-color: #f4511e !important;
	padding: 25px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
}

.panel-footer {
	background-color: white !important;
}

.panel-footer h3 {
	font-size: 32px;
}

.panel-footer h4 {
	color: #aaa;
	font-size: 14px;
}

.panel-footer .btn {
	margin: 15px 0;
	background-color: #339933;
	color: #fff;
}

.navbar {
	margin-bottom: 0;
	background-color: #339933;
	z-index: 999;
	border: 0;
	font-size: 12px !important;
	line-height: 1.42857143 !important;
	letter-spacing: 4px;
	border-radius: 0;
	font-family: Montserrat, sans-serif;
}

.navbar li a, .navbar .navbar-brand {
	color: #fff !important;
}

.navbar-nav li a:hover, .navbar-nav li.active a {
	color: #00C996 !important;
	background-color: #fff !important;
}

.navbar-default .navbar-toggle {
	border-color: transparent;
	color: #fff !important;
}

footer .glyphicon {
	font-size: 20px;
	margin-bottom: 20px;
	color: #339933;
}

.slideanim {
	visibility: hidden;
}

.slide {
	animation-name: slide;
	-webkit-animation-name: slide;
	animation-duration: 1s;
	-webkit-animation-duration: 1s;
	visibility: visible;
}

@
keyframes slide { 0% {
	opacity: 0;
	transform: translateY(70%);
}

100%
{
opacity


































































































:


































































































1;
transform


































































































:translateY


































































































(0%);
}
}
@
-webkit-keyframes slide { 0% {
	opacity: 0;
	-webkit-transform: translateY(70%);
}

100%
{
opacity


























































































































:



























































































































1;
-webkit-transform


























































































































:



























































































































translateY


























































































































(0%);
}
}
@media screen and (max-width: 768px) {
	.col-sm-4 {
		text-align: center;
		margin: 25px 0;
	}
	.btn-lg {
		width: 100%;
		margin-bottom: 35px;
	}
}

@media screen and (max-width: 480px) {
	.logo {
		font-size: 150px;
	}
}

.modal-header, #h4_login, .close {
	background-color: royalblue;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

body {
	padding: 0 !important
}

.login {
	top: 100px;
}

.form-group {
	margin-bottom: 0;
}
</style>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar"
	data-offset="60">

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#myPage"><b>ourRoom</b></a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a id="login"><b style="font-size: 15px;">LOGIN</b></a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="jumbotron text-center">
		<!-- <h1>OurRoom</h1> -->
		<h2 style="color: white;">
			OurRoom lets you work more <br> <br> collaboratively and
			get more done.
		</h2>
		<form></form>
	</div>

	<!-- Container (About Section) -->
	<%-- <div id="about" class="container-fluid text-center">
		<div class="row">
			<div class="col-lg-12">
				<img class="img-rounded" src="/OurRoom/img/localImage.png">
			</div>
		</div>
	</div> --%>

	<%-- <div class="container-fluid bg-grey text-center">
		<div class="row">
			<div class="col-lg-12">
				<img class="img-rounded" src="/OurRoom/img/localImage.png">
			</div>
		</div>
	</div> --%>

	<!-- Container (Services Section) -->
	<%-- <div class="container-fluid text-center">
		<div class="row">
			<div class="col-lg-12">
				<img class="img-rounded" src="/OurRoom/img/localImage.png">
			</div>
		</div>
	</div> --%>

	<!-- Container (Portfolio Section) -->
	<div id="portfolio" class="container-fluid text-center bg-grey">
		<h2>Portfolio</h2>
		<br>
		<h4>What we have created</h4>
		<div class="row text-center slideanim">
			<div class="col-sm-4">
				<div class="thumbnail">
					<img src="img/gantt.jpg" alt="Paris" width="400" height="300">
					<p>
						<strong>Paris</strong>
					</p>
					<p>Yes, we built Paris</p>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="thumbnail">
					<img src="img/kanban.jpg" alt="New York" width="400" height="300">
					<p>
						<strong>New York</strong>
					</p>
					<p>We built New York</p>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="thumbnail">
					<img src="img/chart.jpg" alt="San Francisco" width="400"
						height="300">
					<p>
						<strong>San Francisco</strong>
					</p>
					<p>Yes, San Fran is ours</p>
				</div>
			</div>
		</div>
		<br>

		<h2>사용후기</h2>
		<div id="myCarousel" class="carousel slide text-center"
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<h4>
						"프로젝트를 진행할 때, 칸반으로 짜놓은 계획을 간트차트롤 만드려면 다른 프로그램에 일일이 옮겨적었는데 <br>
						이 사이트를 만난 이후로는 그럴 필요가 없어졌어요!"<br> <span> &lt; Juli
							&gt; </span>
					</h4>
				</div>
				<div class="item">
					<h4>
						"인원별로 업무처리를 한눈에 볼 수 있어서 누가 일 안하고 놀았는지 파악하기 쉬워졌어요."<br> "너무
						좋아요!!!"<br> <span> &lt; nice100sj &gt; </span>
					</h4>
				</div>
				<div class="item">
					<h4>
						프로젝트 뿐 아니라 개인 일정관리에도 너무 탁월합니다.<br> 강추 강추!!<br> <span>
							&lt; 101^ &gt; </span>
					</h4>
				</div>
			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>

	<script>
		$(document).ready(
				function() {
					// Add smooth scrolling to all links in navbar + footer link
					$(".navbar a, footer a[href='#myPage']").on('click',
							function(event) {
								// Make sure this.hash has a value before overriding default behavior
								if (this.hash !== "") {
									// Prevent default anchor click behavior
									event.preventDefault();

									// Store hash
									var hash = this.hash;

									// Using jQuery's animate() method to add smooth page scroll
									// The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
									$('html, body').animate({
										scrollTop : $(hash).offset().top
									}, 900, function() {

										// Add hash (#) to URL when done scrolling (default click behavior)
										window.location.hash = hash;
									});
								} // End if
							});

					$(window).scroll(function() {
						$(".slideanim").each(function() {
							var pos = $(this).offset().top;

							var winTop = $(window).scrollTop();
							if (pos < winTop + 600) {
								$(this).addClass("slide");
							}
						});
					});
				})
	</script>
	<script>
		$(function() {
			$("#loginBtn").on("click", function() {
				// 회원 여부 체크
				$.ajax({
					url : "loginMemberCheck",
					async : false,
					data : {
						mId : $("#mId").val(),
						mPw : $("#mPw").val()
					},
					success : function(result) {
						if (result) {
							$("#form").submit();
						} else {
							$("#memberCheckMsg").css("color", "red");
							$("#memberCheckMsg").html("회원정보를 잘못 입력하셨습니다.");
						}
					},
					error : function(result) {
						$("#memberCheckMsg").html("에러..." + result);
					}
				});
			});

		});
	</script>
	<script>
	$(function() {
		/* 회원가입 아이디 중복체크 */
		$("#sign_mId").blur(function() {
			chkId();
		});

		/* 회원가입 패스워드 체크 */
		$("#sign_mPw").blur(function(){
			chkPw();
		});

		/* 회원가입 패스워드 확인 체크 */
		$("#sign_mPw2").blur(function(){
			chkPw2();
		});

		/* 회원가입 닉네임 체크 */
		$("#sign_mNickname").blur(function(){
			chkNickname();
		});

		/* 회원가입 답변 체크 */
		$("#sign_mAnswer").blur(function(){
			chkAnswer();
		});

		/* 취소버튼 클릭 시 */
		//$("#cancelBtn").on("click",function(){
		//
		//	var isCancel = window.confirm("취소하시겠습니까?");
		//	if(isCancel){
		//		location.href="loginForm";
		//	}
		//});

		/* ID, PW, Nickname, 답변 유효성 체크 및 submit */
		$("#signUpBtn").on("click",function(){
			console.log("signUpBtn click");
			if(chkId()&chkPw()&chkNickname()&chkAnswer()&chkPw2()){
				$("#signForm").submit();
			}
			return false;
		});

	});
	/* ID Check */
	function chkId(){
		var isOk;
		$("#sign_mId").val($.trim($("#sign_mId").val()));
		var strId = $("#sign_mId").val();
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
				mId : $("#sign_mId").val()
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

		$("#sign_mPw").val($.trim($("#sign_mPw").val()));
		 var strPw = $("#sign_mPw").val()+'';
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
        var pw = $("#sign_mPw").val();
        var pw2 = $("#sign_mPw2").val();

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

		$("#sign_mNickname").val($.trim($("#sign_mNickname").val()));
		var strNickname = $("#sign_mNickname").val();
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
				mNickname : $("#sign_mNickname").val()
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
		$("#sign_mAnswer").val($.trim($("#sign_mAnswer").val()));
		var strAnswer = $("#sign_mAnswer").val();

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

	<!-- 로그인 -->
	<!-- Modal -->
	<div class="modal fade" id="loginModal" role="dialog">
		<div class="login modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 style="">
						<span class="glyphicon glyphicon-lock" id="h4_login"></span> 로그인
					</h4>
				</div>
				<div class="modal-body" style="padding: 20px 20px;">
					<form id="form" role="form" action="project/pList" method="post">
						<div class="form-group">
							<label for="usrname"><span
								class="glyphicon glyphicon-user"></span> 이메일</label> <input type="text"
								class="form-control" id="mId" name="mId"
								placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="mPw"><span
								class="glyphicon glyphicon-eye-open"></span> 비밀번호</label> <input
								type="password" class="form-control" id="mPw" name="mPw"
								placeholder="Enter password"><br>
							<p id="memberCheckMsg"></p>
						</div>
						<button type="button" id="loginBtn"
							class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> 로그인
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<p>
						<a id="signUp_a" style="cursor: pointer;">회원이 아닌가요?</a> <br>
						<a id="findPw" style="cursor: pointer;"> 비밀번호를 모르겠어요.</a>
					</p>
				</div>
			</div>

		</div>
	</div>

	<!-- 회원가입 -->
	<!-- Modal -->
	<div class="modal signUp fade" id="signUpModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>회원가입</h4>
				</div>
				<div class="modal-body">
					<form role="form" id="signForm" action="join" method="post">
						<div class="form-group">
							<label for="sign_mId"><span
								class="glyphicon glyphicon-user"></span> 이메일</label> <input type="text"
								class="form-control" id="sign_mId" name="mId"
								placeholder="email"> <span id="idCheckMsg"></span>
						</div>
						<div class="form-group">
							<label for="sign_mPw"><span
								class="glyphicon glyphicon-eye-open"></span> 비밀번호</label> <input
								type="password" class="form-control" id="sign_mPw" name="mPw"
								placeholder="password"> <span id="pwCheckMsg"></span>
						</div>
						<div class="form-group">
							<label for="sign_mPw2"><span
								class="glyphicon glyphicon-eye-open"></span> 비밀번호 확인 </label> <input
								type="password" class="form-control" id="sign_mPw2"
								name="sign_mPw2" placeholder="Check password"> <span
								id="pw2CheckMsg"></span>
						</div>
						<div class="form-group">
							<label for="sign_mNickname"><span
								class="glyphicon glyphicon-font"></span> 닉네임 </label> <input type="text"
								class="form-control" id="sign_mNickname" name="mNickname"
								placeholder="Nickname"> <span id="nicknameCheckMsg"></span>
						</div>
						<div class="form-group">
							<label for="sign_mQuestion"><span
								class="glyphicon glyphicon-question-sign"></span> 질문 </label> <select
								id="sign_mQuestion" name="mQuestion" class="form-control">
								<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
								<option value="2">졸업한 초등학교 이름은?</option>
								<option value="3">어머니 성함은?</option>
								<option value="4">아버지 성함은?</option>
							</select>
						</div>
						<div class="form-group">
							<label for="sign_mAnswer"><span
								class="glyphicon glyphicon-comment"></span> 답변 </label> <input
								type="text" class="form-control" id=sign_mAnswer name="mAnswer"
								placeholder="mAnswer"> <span id="answerCheckMsg"></span>
						</div>
						<button type="button" id="signUpBtn"
							class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> 회원가입
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> 취소
					</button>
				</div>
			</div>

		</div>
	</div>

	<!-- 비밀번호 찾기 -->
	<!-- Modal -->
	<div class="modal fade" id="findPwModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="padding: 20px 20px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<i class="fas fa-key"></i> 비밀번호 찾기
					</h4>
				</div>
				<div class="modal-body" style="padding: 20px 20px;">
					<form role="form" action="home" method="post">
						<div class="form-group">
							<label for="pwQ_mId"><span
								class="glyphicon glyphicon-user"></span> 이메일 </label> <input type="text"
								class="form-control" id="pwQ_mId" name="mId"
								placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="pwQ_mQuestion"><span
								class="glyphicon glyphicon-question-sign"></span> 질문 </label> <select
								id="pwQ_mQuestion" name="mQuestion">
								<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
								<option value="2">졸업한 초등학교 이름은?</option>
								<option value="3">어머니 성함은?</option>
								<option value="4">아버지 성함은?</option>
							</select><br>
						</div>
						<div class="form-group">
							<label for="pwQ_mAnswer"><span
								class="glyphicon glyphicon-comment"></span> 답변 </label> <input
								type="text" class="form-control" id="pwQ_mAnswer" name="mAnswer"
								placeholder="Answer">
						</div>

						<button type="button" id=ForgetPwBtn
							class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> 확인
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" id="findPwCancelBtn"
						class="btn btn-danger btn-default pull-left" data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> 취소
					</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#login").click(function() {
				$("#loginModal").modal('toggle');
				//$("#signUpModal").modal('hide');
			});

			$("#signUp_a").click(function() {
				$("#signUpModal").modal('show');
				$("#loginModal").modal('hide');
			});
			$("#findPw").click(function() {
				$("#findPwModal").modal('show');
				$("#loginModal").modal('hide');
			});
			$("#findPwCancelBtn").click(function(){
				$("#loginModal").modal('show');
			});

		});


	</script>
	<footer class="container-fluid text-center">
		<a href="#myPage" title="To Top"> <span
			class="glyphicon glyphicon-chevron-up"></span>
		</a>
		<p>Copyright © 2018 OURROOM 101^. All rights reserved.</p>
	</footer>
</body>
</html>
