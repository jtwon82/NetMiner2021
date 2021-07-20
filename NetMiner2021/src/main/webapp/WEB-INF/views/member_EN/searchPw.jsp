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
		<title>Password | NetMiner 365</title>
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
		<script src="/resources/js/event_EN.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id = "dimmed" style="position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100; opacity: 0.5; background-color: rgb(0, 0, 0); display: none;" ></div>
		<div id="wrap" class="sub searchPw">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<!-- step1 비밀번호 재설정 요청 -->
					<c:if test="${empty userId}">
					<div class="step1">
						<div class="title">
							<h2>Do you forget your password?</h2>
							<p>Reset your password</p>
						</div>
						<div class="content">
							<p>Enter the email address and click 'Request password reset'.</p>
							<div class="input">
								<p>E-mail</p>
								<input placeholder="" type="text" id="email"  />
								<p class="sum">Please check your mailbox. This email will be valid for 30 minutes.<br>
	Can't find your email? Check your spam folder..</p>
							</div>
							<button class="requestPw trs active" onClick="requestSetPwd();">Request password reset</button>
							<a class="back" href="./login" >Back to Sign-in</a>
						</div>
					</div>
					</c:if>
					<!-- step2 비밀번호 재설정 -->
					<c:if test="${!empty userId}">
						<c:if test="${'N' eq DATE_CHECK}">
							<script>alert("This link is no longer vaild. Please try resetting your password again."); location.href='./';</script>
						</c:if>
					<div class="step2" >
						<div class="title">
							<h2>Reset your password</h2>
							<p>Reset your password</p>
						</div>
						<div class="content">
							<p>Enter the email address and click 'Request password reset'.</p>
							<div class="input">
								<ul>
									<li>
										<p>New password</p>
										<input placeholder="" type="password" id="newPwd" />
									</li>
									<li>
										<p>Confirm password</p>
										<input placeholder="" type="password" id="newPwd2"/>
									</li>
								</ul>
							</div>
							<button class="changePw trs active" onClick="changePwd('${userId}')">Reset password and sign-in</button>
							<a class="back" href="./login" style="cursor:pointer; ">Back to Sign-in </a>
						</div>
					</div>
					</c:if>
				</div>
			</div>
			<%@include file = "../common_EN/memberFooter.jsp" %>
		</div>
	
	</body>
</html>