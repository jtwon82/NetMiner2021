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
		<div id="wrap" class="sub register_sns">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Register for NetMiner 365</h2>
						<p>Already have your account? <a href="./login">Sign in</a></p>
					</div>
					<div class="content">
						<div>
							<ul class="input">
								<li><input placeholder="${userInfo.email}" type="text" id="email" value="${userInfo.email}" disabled="disabled"></li>
								<li><input placeholder="Organization" type="text" id="company"></li>
							</ul>
							<select id="nation">
								<option value="" disabled selected hidden>Country</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select>
							<div class="checkBox">
								<p>Account Type</p>
								<ul>
									<li><label><input type="radio" checked="checked" name="useCode" value="01"><em></em>Academic</label></li>
									<li ><label><input type="radio" checked="checked" name="useCode" value="02"><em></em>Commercial</label></li>
								</ul>
							</div>
							<div class="agree">
								<label><input id="check_all" type="checkbox" name=""><em></em>Agree to all</label>
								<label><input id="check1" class="check" type="checkbox" name=""><em></em><span class="text">I agree to the <a href="./TermsOfService" class="blue">terms and conditions</a> and the <a href="./Privacy" class="blue">privacy policy</a> <span class="silver">(required)</span></span></label>
								<label><input id="check2" class="check" type="checkbox" name=""><em></em><span class="text">I confirm that I'm 16 years or older <span class="silver">(required)</span></span></label>
								<label><input id="check2" class="check" type="checkbox" name=""><em></em><span class="text">I agree to receive informations and commercial offers by email <span class="silver">(option)</span></span></label>
							</div>
							<button class="create trs" onClick="registerSns('${userInfo.kid}')">Create Account</button>
						</div>
						<dl>
							<dt>Create NetMiner 365 account,</dt>
							<dd>Start NetMiner 365 for free</dd>
							<dd>Support your inquiry</dd>
							<dd>Get Newsletter about NetMiner 365</dd>
						</dl>
					</div>
					
					
				</div>
			</div>
				<%@include file = "../common_EN/memberFooter.jsp" %>
		</div>
	
	</body>
</html>