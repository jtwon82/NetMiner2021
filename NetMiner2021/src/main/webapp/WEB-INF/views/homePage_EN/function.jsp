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
		<title>Function | NetMiner 365</title>
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
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="function">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>The Unique Features of NetMiner 365</h2>
							<p>NetMiner 365 provides you with various data analysis algorithms including graph analytics,<br>
machine learning, statistics, and more, visualization algorithms to help you understand data intuitively, <br>
and features to allow you to process data the way you want.
</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>Data Management</h3>
					<div class="content">
						<div class="bg"></div>
						<div class="text">NetMiner 365 helps you upload large amounts of data in databases or files quickly and extract relational data easily from big data. In addition, it provides you with various preprocessing methods for data that’s already been imported as well. For example, the query feature that allows you to extract conditionally and process data is a powerful one that enables you to process and handle big data. 
</div>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>Data Analytics</h3>
					<div class="content">
						<ul>
							<li>
								<div class="bg"></div>
								<div class="text">
									NetMiner 365 gives you graph analytics that helps you understand graph structures precisely. For example, you can measure the centrality of nodes in a graph and cluster them based on their relationships (cohesive groups, equivalence clusters). You can also quantitatively understand graph structures.

								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									NetMiner 365 provides you with machine learning and deep learning algorithms for data prediction and classification. The most popular machine learning algorithms such as Naïve Bayes, SVM, CART, and deep learning (MLP) are available. In addition, it offers graph machine learning algorithms such as GCN and Node2Vec that learn from graph data and predict relational features of nodes.

								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div id="section3" class="section">
				<div class="wrap">
					<h3>Data Visualization</h3>
					<div class="content">
						<ul>
							<li>
								<div class="bg"><img src="/resources/images/function_section3_ico1.png"></div>
								<div class="text">NetMiner 365 helps you use various charts to understand your data intuitively. Not only are there basic charts, but also advanced charts such as parallel coordinates. 
</div>
							</li>
							<li>
								<div class="bg"><img src="/resources/images/function_section3_ico2.png"></div>
								<div class="text">NetMiner 365 helps you visualize graph data and see the overall graph structure. It also displays some information about nodes and relationships in a graph image with graph styling.
</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	</body>
</html>