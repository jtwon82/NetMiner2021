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
		<title>Solution | NetMiner 365</title>
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
		<script src="resources/js/gnb.js" type="text/javascript"></script>
		<script src="resources/js/main_EN.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="solution">
				<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>Key to Address Your Business Problems</h2>
							<p>Find out how you can use NetMiner 365<br>
and how it can help your business<br>
through our stories.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>Human Resources / Organization</h4>
							<p>A variety of networks among the data, tasks, resources, and people in an organization are important elements to an organization’s performance and development. 
 Communication patterns that occur in the
organization are collected to diagnose the efficiency and
structure of communication, allowing the corporation to
understand the organization's processes better and
effectively improve the organization's performance.</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>Sales / Marketing</h4>
							<p>A new era of spending. There’s a large amount of data available online that allows you to understand customers’ behavioral patterns and interests. Using graph analytics and machine learning to analyze customer behavior and diffusion patterns, marketers can predict customer profiles and actions to make personalized suggestions.
</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section3" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>Strategy / R&D</h4>
							<p>For a government agency or corporation to develop, it needs a clear strategy and corresponding R&D investment plan to achieve its goals. 
A graph-based knowledge map facilitates a visual understanding of knowledge structures in vast amounts of documents. At the same time, machine learning can significantly reduce the amount of time and expense incurred in data classification and prediction. 
</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section4" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>Compliance / Crime</h4>
							<p>With the advancement of social systems, patterns of
fraud, conspiracy, and fraudulent actions are becoming
more complex; tracking them down involves a lot of
time and high costs. NetMiner 365 allows you to quickly find abnormal patterns and understand the graph structure in entire suspect groups using graph analytics and machine learning.
</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section5" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>Manufacturing / Supply Chain Management</h4>
							<p>NetMiner 365 can help you significantly increase corporate profits by making production processes more efficient, accurately predicting the supply and demand of products, and optimizing logistics routes. In addition, graph analytics allows you to understand process structures, business transactions with other companies, logistics patterns, etc., to reduce loss and eliminate bottlenecks in the supply chain network. 
</p>
						</div>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
			</div>
		
		</div>
	</body>
</html>