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
		<title>Code | NetMiner 365</title>
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
		<div id = "dimmed" style="position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100; opacity: 0.5; background-color: rgb(0, 0, 0); display: none;" ></div>
		<div id="wrap" class="sub authentic">
		<input type="hidden" id="END_DATE" value="${authData.END_DATE}">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>You're almost there..</h2>
					</div>
					<div class="content">
						<p>We've sent a 7 digit code to <span>${userId}</span><br>
This code will be valid for 30 minutes.</p>
						<div class="input">
							<p>Verification Code</p>
							<input placeholder="" type="text" id="code"/>
							<p class="sum">Can't find your code? Check your spam folder.<br>Or  <a href="javascript:;" class="blue"  onClick="newRandomNumber('${userId}');">Resend Code</a></p>
						</div>
						<c:if test="${empty memberVo}">
						<div class="agree">
								<label><input id="check_all" type="checkbox" name=""><em></em>Agree to all</label>
								<label><input id="check1" class="check" type="checkbox" name="age"><em></em><span class="text">I agree to the <a href='javascript:;' onClick="window.open('./TermsOfService')" class="blue">terms and conditions</a> and the <a href='javascript:;' onClick="window.open('./Privacy')" class="blue">privacy policy</a> <span class="silver">(required)</span></span></label>
								<label><input id="check2" class="check" type="checkbox" name="using"><em></em><span class="text">I confirm that I'm 16 years or older <span class="silver">(required)</span></span></label>
								<label><input id="check3" class="check" type="checkbox" name="marketYn"  value="Y"><em></em><span class="text">I agree to receive informations and commercial offers by email <span class="silver">(option)</span></span></label>
						</div>
						</c:if>
						<c:if test="${empty memberVo}">
						<button class="create trs active" onClick="register('${userId}')">Create Account</button>
						</c:if>
						<c:if test="${!empty memberVo}">
						<button class="create trs active" onClick="registerCheckEmail('${userId}')">Email Authentication</button>
						</c:if>
						<a class="back" id="authentic" style="cursor:pointer; ">Back to Register</a>
					</div>
					
				</div>
			</div>
			<%@include file = "../common_EN/memberFooter.jsp" %>
		</div>
	
	</body>
</html>