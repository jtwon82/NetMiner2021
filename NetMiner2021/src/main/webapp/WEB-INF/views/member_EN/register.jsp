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
		<title>Register | NetMiner365</title>
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
		<div id="wrap" class="sub register">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
				<form name="form">
					<div class="title">
						<h2>Register for NetMiner 365</h2>
						<p>Already have your account? <a href="./login">Sign in</a></p>
					</div>
					<div class="content">
						<div>
							<ul class="input">
								<li><input placeholder="E-mail" type="text"   name="userId" id ="email"/></li>
								<li><input placeholder="Password" type="password" name="userPwd" id="pwd" /><span class="sum">8~16 characters (A-Z, a-z), numbers</span></li>
								<li><input placeholder="Organization" type="text" name="company" id="company"/></li>
							</ul>
							<select name="nation" id="nation">
								<option value="" disabled selected hidden>Country</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select><script>$("select").select2();</script>
							<div class="checkBox">
								<p>Account Type</p>
								<ul>
									<li><label><input type="radio" checked="checked" name="useCode"  value="01"><em></em>Academic</label></li>
									<li ><label><input type="radio" checked="checked" name="useCode" value="02"><em></em>Commercial</label></li>
								</ul>
							</div>
							<button class="authentic trs" onClick="checkEmail();">Verify e-mail</button>
							<span class="line">or</span>
							<button class="google trs" onClick="googleLogin();">Continue in with Google</button>
						</div>
						<dl>
							<dt>Create NetMiner 365 account,</dt>
							<dd>Start NetMiner 365 for free</dd>
							<dd>Support your inquiry</dd>
							<dd>Get Newsletter about NetMiner 365</dd>
						</dl>
					</div>
				</form>
				</div>
			</div>
		<%@include file = "../common_EN/memberFooter.jsp" %>
		</div>
	
	</body>
</html>