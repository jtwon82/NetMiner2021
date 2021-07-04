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
		<div id="wrap" class="whyNetminer">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>Graph Data, A Core Component of Big Data</h2>
							<p>Big data is composed of atypical data and graph data.<br>
Therefore, if graph data is missing in analysis, it leads to considerable data loss.<br>
Graph Analytics and machine learning is the only way to make sure this does not happen.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>A New Paradigm for A New Era</h3>
					<p>We are already in a world of big data.<br>
However, how much do we understand about big data?</p>
					<div class="content">
						<div class="bg"></div>
						<div class="text">In the past, big data referred to the processing of large amounts
of data based on Hadoop, statistics, and machine learning and
ascertaining and predicting data distribution.<br><br>

However, big data is by nature substantially composed of graph
data. Graph data describes the “relationship” between data,
but a new approach is needed to arrive at meaningful insights.</div>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>Graph Analytics, as one of the Top 10 Data and Analytics Technology</h3>
					<p>In 2019, the global research and advisory firm Gartner<br>
named Graph Analytics as one of the top 10 data and analytics technologies.</p>
					<div class="content">
						<div class="text">Graph Analytics and graph machine learning are the only ways to
analyze graph data, and it is slowly gathering more interest (as
displayed by Garter’s designation).<br><br>

NetMiner 365 features rich Graph Analytics algorithms and graph
data analysis functions based on the network analysis software
NetMiner.</div>
						<div class="bg"></div>
					</div>
				</div>
			</div>
			<div id="section3" class="section">
				<div class="wrap">
					<h3>Graph Analytics and Machine Learning</h3>
					<p>Graph Analytics can enhance the accuracy of data prediction and classification.</p>
					<div class="content">
						<div class="bg"></div>
						<div class="text">Graph Analytics is not only the method of understanding
graphs but also a method of increasing the accuracy of machine
learning predictions.
<br><br>
Extracting the “relationship” from the graph structures inside
big data and utilizing them in machine learning leads to a more
detailed understanding and prediction of data. Graph learning
algorithms for graphs can also learn graph data as is and
predict data.</div>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	</body>
</html>