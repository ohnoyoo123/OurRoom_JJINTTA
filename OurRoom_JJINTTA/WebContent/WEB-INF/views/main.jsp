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
	margin-bottom: 30px;
}

.jumbotron {
	background-color: #f4511e;
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
	color: #f4511e;
	font-size: 50px;
}

.logo {
	color: #f4511e;
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
	color: #f4511e;
}

.carousel-indicators li {
	border-color: #f4511e;
}

.carousel-indicators li.active {
	background-color: #f4511e;
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
	border: 1px solid #f4511e;
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
	background-color: #f4511e;
	color: #fff;
}

.navbar {
	margin-bottom: 0;
	background-color: #f4511e;
	z-index: 9999;
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
	color: #f4511e !important;
	background-color: #fff !important;
}

.navbar-default .navbar-toggle {
	border-color: transparent;
	color: #fff !important;
}

footer .glyphicon {
	font-size: 20px;
	margin-bottom: 20px;
	color: #f4511e;
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
	background-color: #5cb85c;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
}

body {
	padding: 0 !important
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
				<a class="navbar-brand" href="#myPage">OurRoom</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<!-- <li><a href="#about">ABOUT</a></li>
					<li><a href="#services">SERVICES</a></li>
					<li><a href="#portfolio">PORTFOLIO</a></li>
					<li><a href="#pricing">PRICING</a></li>
					<li><a href="#contact">CONTACT</a></li> -->
					<li><a id="login">LOGIN</a></li>
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
	<div id="about" class="container-fluid">
		<div class="row">
			<div class="col-sm-8">
				<h2>About Company Page</h2>
				<br>
				<h4>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
					sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
					Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.</h4>
				<br>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Excepteur sint occaecat
					cupidatat non proident, sunt in culpa qui officia deserunt mollit
					anim id est laborum consectetur adipiscing elit, sed do eiusmod
					tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
					minim veniam, quis nostrud exercitation ullamco laboris nisi ut
					aliquip ex ea commodo consequat.</p>
				<br>
				<button class="btn btn-default btn-lg">Get in Touch</button>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-signal logo"></span>
			</div>
		</div>
	</div>

	<div class="container-fluid bg-grey">
		<div class="row">
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-globe logo slideanim"></span>
			</div>
			<div class="col-sm-8">
				<h2>Our Values</h2>
				<br>
				<h4>
					<strong>MISSION:</strong> Our mission lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
					labore et dolore magna aliqua. Ut enim ad minim veniam, quis
					nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
					consequat.
				</h4>
				<br>
				<p>
					<strong>VISION:</strong> Our vision Lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
					labore et dolore magna aliqua. Ut enim ad minim veniam, quis
					nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
					consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
					sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
					Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.
				</p>
			</div>
		</div>
	</div>

	<!-- Container (Services Section) -->
	<div id="services" class="container-fluid text-center">
		<h2>SERVICES</h2>
		<h4>What we offer</h4>
		<br>
		<div class="row slideanim">
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-off logo-small"></span>
				<h4>POWER</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-heart logo-small"></span>
				<h4>LOVE</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-lock logo-small"></span>
				<h4>JOB DONE</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
		</div>
		<br> <br>
		<div class="row slideanim">
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-leaf logo-small"></span>
				<h4>GREEN</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-certificate logo-small"></span>
				<h4>CERTIFIED</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-wrench logo-small"></span>
				<h4 style="color: #303030;">HARD WORK</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
		</div>
	</div>

	<!-- Container (Portfolio Section) -->
	<div id="portfolio" class="container-fluid text-center bg-grey">
		<h2>Portfolio</h2>
		<br>
		<h4>What we have created</h4>
		<div class="row text-center slideanim">
			<div class="col-sm-4">
				<div class="thumbnail">
					<img src="img/paris.jpg" alt="Paris" width="400" height="300">
					<p>
						<strong>Paris</strong>
					</p>
					<p>Yes, we built Paris</p>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="thumbnail">
					<img src="img/newyork.jpg" alt="New York" width="400" height="300">
					<p>
						<strong>New York</strong>
					</p>
					<p>We built New York</p>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="thumbnail">
					<img src="img/sanfran.jpg" alt="San Francisco" width="400"
						height="300">
					<p>
						<strong>San Francisco</strong>
					</p>
					<p>Yes, San Fran is ours</p>
				</div>
			</div>
		</div>
		<br>

		<h2>What our customers say</h2>
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
						"This company is the best. I am so happy with the result!"<br>
						<span>Michael Roe, Vice President, Comment Box</span>
					</h4>
				</div>
				<div class="item">
					<h4>
						"One word... WOW!!"<br> <span>John Doe, Salesman, Rep
							Inc</span>
					</h4>
				</div>
				<div class="item">
					<h4>
						"Could I... BE any more happy with this company?"<br> <span>Chandler
							Bing, Actor, FriendsAlot</span>
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

	<!-- Add Google Maps -->
	<!--<div id="googleMap" style="height: 400px; width: 100%;"></div>
	<script>
		function myMap() {
			var myCenter = new google.maps.LatLng(41.878114, -87.629798);
			var mapProp = {
				center : myCenter,
				zoom : 12,
				scrollwheel : false,
				draggable : false,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			};
			var map = new google.maps.Map(document.getElementById("googleMap"),
					mapProp);
			var marker = new google.maps.Marker({
				position : myCenter
			});
			marker.setMap(map);
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBu-916DdpKAjTmJNIgngS6HL_kDIKU0aU&callback=myMap"></script>
-->
	<!--
To use this code on your website, get a free API key from Google.
Read more at: https://www.w3schools.com/graphics/google_maps_basic.asp
-->



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
							$("form").submit();
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
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="padding: 20px 20px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock" id="h4_login"></span> Login
					</h4>
				</div>
				<div class="modal-body" style="padding: 20px 20px;">
					<form role="form" action="home" method="post">
						<div class="form-group">
							<label for="usrname"><span
								class="glyphicon glyphicon-user"></span> Username</label> <input
								type="text" class="form-control" id="mId" name="mId"
								placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="psw"><span
								class="glyphicon glyphicon-eye-open"></span> Password</label> <input
								type="password" class="form-control" id="mPw" name="mPw"
								placeholder="Enter password"><br>
							<p id="memberCheckMsg"></p>
						</div>
						<button type="button" id="loginBtn"
							class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> Login
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> Cancel
					</button>
					<p>
						Not a member? <a id="signUp_a">Sign Up</a>
					</p>
					<p>
						Forgot <a id="findPw">Password?</a>
					</p>
				</div>
			</div>

		</div>
	</div>

	<!-- 회원가입 -->
	<!-- Modal -->
	<div class="modal fade" id="signUpModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="padding: 20px 5px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock" id="h4_login"></span> Sign
						Up
					</h4>
				</div>
				<div class="modal-body" style="padding: 20px 20px;">
					<form role="form" id="signForm" action="join" method="post">
						<div class="form-group">
							<label for="sign_mId"><span
								class="glyphicon glyphicon-user"></span> Email</label> <input
								type="text" class="form-control" id="sign_mId" name="mId"
								placeholder="email">
							<p id="idCheckMsg"></p>
						</div>
						<div class="form-group">
							<label for="sign_mPw"><span
								class="glyphicon glyphicon-eye-open"></span> Password</label> <input
								type="password" class="form-control" id="sign_mPw" name="mPw"
								placeholder="password">
							<p id="pwCheckMsg"></p>
						</div>
						<div class="form-group">
							<label for="sign_mPw2"><span
								class="glyphicon glyphicon-eye-open"></span> Check Password </label> <input
								type="password" class="form-control" id="sign_mPw2"
								name="sign_mPw2" placeholder="Check password">
							<p id="pw2CheckMsg"></p>
						</div>
						<div class="form-group">
							<label for="sign_mNickname"><span
								class="glyphicon glyphicon-font"></span> Nickname </label> <input
								type="text" class="form-control" id="sign_mNickname"
								name="mNickname" placeholder="Nickname">
							<p id="nicknameCheckMsg"></p>
						</div>
						<div class="form-group">
							<label for="sign_mQuestion"><span
								class="glyphicon glyphicon-question-sign"></span> Question </label> <select
								id="sign_mQuestion" name="mQuestion" class="form-control">
								<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
								<option value="2">졸업한 초등학교 이름은?</option>
								<option value="3">어머니 성함은?</option>
								<option value="4">아버지 성함은?</option>
							</select>
						</div>
						<div class="form-group">
							<label for="sign_mAnswer"><span
								class="glyphicon glyphicon-comment"></span> Answer </label> <input
								type="text" class="form-control" id=sign_mAnswer name="mAnswer"
								placeholder="mAnswer">
							<p id="answerCheckMsg"></p>
						</div>
						<button type="button" id="signUpBtn"
							class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> Sign Up
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> Cancel
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
						<span class="glyphicon glyphicon-lock" id="h4_login"></span> Login
					</h4>
				</div>
				<div class="modal-body" style="padding: 20px 20px;">
					<form role="form" action="home" method="post">
						<div class="form-group">
							<label for="pwQ_mId"><span
								class="glyphicon glyphicon-user"></span> Email </label> <input
								type="text" class="form-control" id="pwQ_mId" name="mId"
								placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="pwQ_mQuestion"><span
								class="glyphicon glyphicon-eye-open"></span> question </label> <select
								id="pwQ_mQuestion" name="mQuestion">
								<option value="1" selected="selected">가장 아끼는 보물 1호는?</option>
								<option value="2">졸업한 초등학교 이름은?</option>
								<option value="3">어머니 성함은?</option>
								<option value="4">아버지 성함은?</option>
							</select><br>
						</div>
						<div class="form-group">
							<label for="pwQ_mAnswer"><span
								class="glyphicon glyphicon-user"></span> Answer </label> <input
								type="text" class="form-control" id="pwQ_mAnswer" name="mAnswer"
								placeholder="Answer">
						</div>
					
						<button type="button" id="loginBtn"
							class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> Check
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" id="findPwCancelBtn" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> Cancel
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
		<p>Copyright © 2018 OURROOM ZZINDDA. All rights reserved.</p>
	</footer>
</body>
</html>