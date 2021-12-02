<%@ page language="java" contentType="text/html; charset=UTF-8 "
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
		<title>Login | NetMiner365</title>
		<meta name="title" content="" />
		<meta name="description" content="" />
		<meta property="og:title" content="">
		<meta property="og:image" content="">
		<meta property="og:description" content="">
		<meta name="twitter:card" content="summary">
		<meta name="twitter:title" content="">
		<meta name="twitter:image" content="">
		<meta name="twitter:description" content="">
		<link href="resources/css/style.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
		<link href="resources/css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="resources/js/swiper.min.js" type="text/javascript"></script>
		<script src="resources/js/gnb.js" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body onload="document.form.email.focus();">
		<div id="wrap" class="sub login">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Welcome to NetMiner 365</h2>
						<p>아직 계정이 없습니까?<a href="javascript:;" id="register" onclick="window.location.href='./register'">등록</a></p>
					</div>
					<div class="content">
						<form name="form" action="./loginUser" method="POST">
						<ul class="input">
							<li><input placeholder="이메일" type="text"  name="email"/></li>
							<li><input placeholder="비밀번호" type="password" name="pwd"/></li>
						</ul>						
						<a class="searchPw blue" href="./findPwd">비밀번호를 잊으셨나요?</a>
						<button class="login trs" type="submit">로그인</button>
						</form>
						<span class="line">또는</span>
						<button class="google trs" onClick="googleLogin();">Sign in with Google</button>
					</div>
					
				</div>
			</div>
		<%@include file = "../common/memberFooter.jsp" %>
		</div>
	
	</body>
</html>