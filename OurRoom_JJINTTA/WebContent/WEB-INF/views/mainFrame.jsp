<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.min.js"></script>  
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
    jQuery.browser = {};
    (function () {
        jQuery.browser.msie = false;
        jQuery.browser.version = 0;
        if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
            jQuery.browser.msie = true;
            jQuery.browser.version = RegExp.$1;
        }
    })();
</script>
<title>Insert title here</title>
<style type="text/css">
html, body{
	height: 96%;
}
#top{
	width: 100%;
	height: 50px;
	background-color: black;
	color : white;
	display: inline-block;
}

#left{
	width: 50px;
	background-color: black;
	height: 100%;
	padding-top: 50px;
	color : white;
	display: inline-block;

}

.topIcon{
	width: 50px;
	height: 50px;
	float: right;
	background-color: black;
	margin-right: 50px;
	font-size : 45px;
	color : white;
}

.topHome{
	width: 50px;
	height: 50px;
	background-color: black;
	margin : 0 auto;
	font-size : 45px;
	color : white;

}

.leftIcon{
	width: 50px;
	height: 50px;
	background-color: black;
	margin-bottom : 50px;
	font-size : 45px;
	color : white;
}
</style>
</head>
<body>
	<div id = "top">
		<div class="topIcon"><span class="glyphicon glyphicon-log-out"></span></div>
		<div class="topIcon"><span class="glyphicon glyphicon-bell"></span></div>
		<div class="topIcon"><span class="glyphicon glyphicon-comment"></span></div>
		<div class="topHome"><span class="glyphicon glyphicon-home"></span></div>
	</div>
	<div id = "left">
		<div class="leftIcon" onclick="location.href='/OurRoom/home'"><span class="glyphicon glyphicon-home"></span></div>
		<div class="leftIcon" onclick="location.href='/OurRoom/project/pList'"><span class="glyphicon glyphicon-briefcase"></span></div>
		<div class="leftIcon" onclick="location.href='/OurRoom/address'"><span class="glyphicon glyphicon-phone-alt"></span></div>
		<div class="leftIcon" onclick="location.href='/OurRoom/myPage'"><span class="glyphicon glyphicon-user"></span></div>
	</div>
</body>
</html>