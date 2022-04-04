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
		<title> NetMiner 365 | Graph Machine Learning Platform</title>
		<meta name="title" content="" />
		<meta name="description" content="" />
		<meta property="og:title" content="">
		<meta property="og:image" content="">
		<meta property="og:description" content="">
		<meta name="twitter:card" content="summary">
		<meta name="twitter:title" content="">
		<meta name="twitter:image" content="">
		<meta name="twitter:description" content="">
		<link href="resources/css/style_en.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
		<link href="resources/css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="resources/js/swiper.min.js" type="text/javascript"></script>
		<script src="resources/js/gnb.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="main">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>Graph Machine Learning,<br>
New Paradigm for Big Data</h2>
							<p>Are Query and Statistics granting you no more new insights?<br>
It is important to understand the graph structure hidden in big data<br>
to predict and classify more precisely.</p>
						</div>
						
							<c:if test="${empty memberVo}">
							<div class="mypage obj type1" style="">
								<ul>
									<!-- <li class="join"><a href="./login" >Start for free</a></li> -->
									<li class="join"><a href="./pricing" >Start for free</a></li>
								</ul>
							</div>
							</c:if>
							<c:if test="${!empty memberVo}">
							<div class="mypage obj type1" style="">
								<ul>
									<!--  <li class="join"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" >Start for free</a></li>-->
									<li class="join"><a href="./pricing" >Start for free</a></li>
								</ul>
							</div>
							</c:if>
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>NetMiner 365, A Platform for Graph Machine Learning</h3>
					<p>It is essential to have the right approach to understand data properly.<br><br>
There are large amounts of graph/relation data inside big data, <br>
But existing data analysis have only understood data through information structuralization, query, and statistics.<br><br>
NetMiner 365 combines graph/network analytics know-how built up 
over a long period and machine learning algorithms. <br>
So, it provides different innovations and inspiration.

					</p>
					<div class="content">
						<div class="bg"></div>
						<a class="more"  href="./whyNetMiner">Learn more  > ></a>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>Why you need NetMiner 365</h3>
					<p>NetMiner 365 provides everything necessary for business<br>
based on the innovative integration of machine learning and graph analytics.</p>
					<div class="content">
						<ul class="line1">
							<li>
								<img src="/resources/images/main_section2_ico1.png" alt="Graph Extraction from Big Data"> 
								<h4>Graph Extraction from Big Data</h4>
								<p>NetMiner 365 helps you extract <br>the hidden graph structures in <br>big data easily and quickly. 
								</p>
							</li>
							<li>
								<img src="/resources/images/main_section2_ico2.png" alt="Graph Analytics"> 
								<h4>Graph Analytics</h4>
								<p>NetMiner 365 gives the data structures, <br>algorithms, and features to help you <br>understand the graph.
								</p>
							</li>
							<li>
								<img src="/resources/images/main_section2_ico3.png" alt="Machine Learning& Deep Learning"> 
								<h4>Machine Learning & Deep Learning</h4>
								<p>NetMiner 365 provides algorithms for <br>both graph machine learning and <br>widely used machine learning.
								</p>
							</li>
						</ul>
						<ul class="line2">
							<li>
								<img src="/resources/images/main_section2_ico4.png" alt="Anytime, Anywhere, FreelyAnytime, Anywhere, Freely"> 
								<h4>Anytime, Anywhere, Freely</h4>
								<p>NetMiner 365 is a cloud-based <br>online platform that can be accessed <br>via the web anytime, anywhere.
								</p>
							</li>
							<li>
								<img src="/resources/images/main_section2_ico5.png" alt="Enterprise"> 
								<h4>Enterprise</h4>
								<p>NetMiner 365 can provide enterprise <br>with on-premise, customization, <br>and etc .<span>(later)</span></p>
							</li>
						</ul>
						<a class="more"  href="./feature">Learn more  > ></a>
					</div>
				</div>
			</div>
			<div id="section3" class="section">
				<div class="wrap">
					<h3>How NetMiner 365 Solves Problems</h3>
					<p>Find out how you can use NetMiner 365 and how it can help your business.</p>
					<div class="content">
						<ul>
							<li></li>
							<li></li>
							<li></li>
							<li></li>
							<li></li>
						</ul>
						<a class="more"  href="./solution">Learn more  > ></a>
					</div>
				</div>
			</div>		
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	
	</body>
</html>