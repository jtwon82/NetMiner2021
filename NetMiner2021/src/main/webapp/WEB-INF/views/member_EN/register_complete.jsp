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
		<title>Register | NetMiner 365</title>
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
		<div id="wrap" class="sub register_complete">
				<%@include file = "../common/top.jsp" %>
				<div id="section">
					<div class="wrap">
						<div class="title">
							<h2>Hello!</h2>
							<p>Let's get started with NetMiner 365.<br>
	NetMiner 365 gives you a lot of insights and findings from graph.</p>
						</div>
						<div class="content">
							<ul>
								<li>
									<h3>Features</h3>
									<p>NetMiner 365 is a big data analysis
	platform capable of extracting graph
	data from inside big data and
	performing analysis combining
	Graph Analytics and machine learning</p>
									<a href="./feature">Learn more</a>
								</li>
								<li>
									<h3>Support</h3>
									<p>Need to talk to our team
	about NetMiner 365?
	<br><br>
	Don't hesitate to contact us.</p>
									<a href="mailto:netminer@cyram.com">Contact us</a>
								</li>
								<li>
									<h3>Start NetMiner 365</h3>
									<p>NetMiner 365 helps you to solve
	problems in your business.
	<br><br>
	Let's get started with NetMiner 365<br>
	for Free !</p>
									<a href="./pricing">Start now</a>
								</li>
							</ul>
							
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	</body>
</html>