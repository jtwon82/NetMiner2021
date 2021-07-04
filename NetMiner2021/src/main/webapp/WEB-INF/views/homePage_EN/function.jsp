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
		<link href="resources/css/style.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
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
							<p>Various data analysis algorithms for Graph Analytics, machine learning, statistics,<br>
and other methods, visualization algorithms to help you understand data intuitively,<br>
and features to allow you to process and handle data freely are offered.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>Data Management</h3>
					<div class="content">
						<div class="bg"></div>
						<div class="text">Large amounts of saved data in databases or files can be quickly
uploaded, and relational data can be easily extracted from such
big data. Various preprocessing methods are provided for data
that’s already been fetched as well. For instance, the query feature
that allows you to extract conditionally and process data using
graphs is a powerful one that enables you to process and handle
big data.</div>
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
									Graph Analytics algorithms are offered that help you
understand graph structures precisely. Measure the
centrality of nodes in a graph and cluster them based on
their relationships (cohesive groups, equivalence clusters).<br>
You can also quantitatively understand graph structures.
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									Machine learning and deep learning algorithms for data
prediction and classification are offered. Machine learning
such as Naïve Bayes, SVM, and CART and deep learning
(MLP) and statistics are available. In addition, graph machine
learning such as GCN and Node 2 Vec that learn from graph
data and predict relational features of nodes are also offered.
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
								<div class="text">Use various charts to understand your
data intuitively. Not only are there basic
charts, but also charts for high level data
such as parallel coordinates.</div>
							</li>
							<li>
								<div class="bg"><img src="/resources/images/function_section3_ico2.png"></div>
								<div class="text">Visualize relational data and see the
overall relational structure within
a visualization. Use the styling feature
to display the information you need in
a graph image.</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	</body>
</html>