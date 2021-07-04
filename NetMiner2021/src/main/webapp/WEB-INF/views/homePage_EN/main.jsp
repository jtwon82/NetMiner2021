<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<title></title>
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
							<p>Is BigQuery and machine learning granting you no more insights that are new?<br>
It is important to understand the graph structure hidden in big data<br>
to predict and classify more precisely.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>NetMiner 365, A Platform for Graph Machine Learning</h3>
					<p>It is essential to have the right approach to understand data properly.<br><br>
There are immense amounts of graph (relation) data inside big data,<br>
But existing data analysis have only understood data through information structuralization, query, and statistics.<br><br>
NetMiner 365 combines Graph Analytics know how built up over a long period<br>
and graph machine learning, providing different innovation and inspiration.
</p>
					<div class="content">
						<div class="bg"></div>
						<a class="more"  href="#">Learn more  > ></a>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>Why you need NetMiner 365</h3>
					<p>NetMiner 365 provides everything necessary for business<br>
based on the innovative integration of machine learning and Graph Analytics.</p>
					<div class="content">
						<ul class="line1">
							<li>
								<img src="/resources/images/main_section2_ico1.png" alt="Graph Extraction from Big Data"> 
								<h4>Graph Extraction from Big Data</h4>
								<p>NetMiner 365 helps you to extract<br>
graph structure from Big Data</p>
							</li>
							<li>
								<img src="/resources/images/main_section2_ico2.png" alt="Graph Analytics"> 
								<h4>Graph Analytics</h4>
								<p>We provides the data structures,<br>
algorithms, and features needed to<br>
understand graphs.</p>
							</li>
							<li>
								<img src="/resources/images/main_section2_ico3.png" alt="Machine Learning& Deep Learning"> 
								<h4>Machine Learning & Deep Learning</h4>
								<p>Algorithms for both machine learning for<br>
graph data and widely used general<br>
machine learning are provided.</p>
							</li>
						</ul>
						<ul class="line2">
							<li>
								<img src="/resources/images/main_section2_ico4.png" alt="Anytime, Anywhere, FreelyAnytime, Anywhere, Freely"> 
								<h4>Anytime, Anywhere, Freely</h4>
								<p>This cloud based online platform<br>
can be accessed via the web anytime<br>
and from any location.</p>
							</li>
							<li>
								<img src="/resources/images/main_section2_ico5.png" alt="Enterprise"> 
								<h4>Enterprise</h4>
								<p>Onpremise, customized installation,<br>
etc., is available for enterprise uses.<br><span>(Coming Soon)</span></p>
							</li>
						</ul>
						<a class="more"  href="#">Learn more  > ></a>
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
						<a class="more"  href="#">Learn more  > ></a>
					</div>
				</div>
			</div>		
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	
	</body>
</html>