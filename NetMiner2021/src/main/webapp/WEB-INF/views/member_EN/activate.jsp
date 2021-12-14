<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
		<title>Sleeper Account | NetMiner365</title>
		<meta name="title" content="" />
		<meta name="description" content="" />
		<meta property="og:title" content="">
		<meta property="og:image" content="">
		<meta property="og:description" content="">
		<meta name="twitter:card" content="summary">
		<meta name="twitter:title" content="">
		<meta name="twitter:image" content="">
		<meta name="twitter:description" content="">
		<link href="/resources/css/style_en.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
		<link href="/resources/css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="/resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="/resources/js/swiper.min.js" type="text/javascript"></script>
		<script src="/resources/js/gnb.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="/resources/js/main_EN.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub activate">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Activate your account</h2>
						<p>Currently, your account is inactivated</p>
					</div>
					<div class="content">
						<p>If you didn't sign into your account for over a year,<br>
your account is currently inactivated.
<br><br>
If you want to restore your account,<br>
click 'Restore and sign-in'.</p>
					
						<button class="actiAccount trs active" onclick="window.location.href='./turnToGeneral'">Restore and sign-in</button>
						<a class="back" href="./login" >Back to sign-in</a>
					</div>
					
				</div>
			</div>
			<%@include file = "../common_EN/memberFooter.jsp" %>
		</div>
		<c:if test="${empty outMemberVo}"> 
		<script> $(function (){ window.location.href="./login";})</script>
	</c:if>
	<script> window.onpopstate= function (event){ window.location.replace("./login");}</script>
	</body>
</html>