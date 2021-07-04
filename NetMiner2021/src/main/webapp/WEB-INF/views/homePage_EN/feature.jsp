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
		<div id="wrap" class="feature">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>Everything for Big Data Analysis</h2>
							<p>Various analysis methods can be used anytime, anywhere<br>
to easily understand the graph data in a big data environment.<br>
NetMiner 365 is a platform that has everything you need.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>Why NetMiner 365?</h3>
					<p>NetMiner 365 is a cloud based big data analysis platform<br>
designed to easily discover graph structures and apply graph and machine learning technology.</p>
					<div class="content">
						<ul>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Graph Extraction from Big Data</h4>
									<p>Use NetMiner 365 to extract the hidden graph structures in
big data easily and quickly. All you have to do is select the
data to be connected via “relationships.”<br>
NetMiner 365 will take care of the graph data modeling and
structuralization.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Graph Analytics</h4>
									<p>Because of the limitations of existing analysis methods, there
has been more interest of late in finding value in “realationship.”
Graph Analytics is the technology most suited to understanding
“relationship” data. The core graph/network analysis algorithms
and features such as graph data processing and visualization
offered by NetMiner 365 help you find value within the graphs.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Machine Learning & Deep Learning</h4>
									<p>NetMiner 365 offers widely used machine learning and
deep learning algorithms and graph machine learning to
learn graphs.<br>
It is designed to also utilize the relational features from
graphs in machine learning, allowing a fused analysis of
Graph Analytics and machine learning.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Anytime, Anywhere, Without Restrictions</h4>
									<p>NetMiner 365 is a cloud based online platform that can be
accessed anytime and anywhere through the web, allowing
you to maximize your productivity.<br>
The fewer system and hardware limitations reduce the time
and costs needed for big data analysis.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Enterprise <span>(Coming Soon)</span></h4>
									<p>NetMiner 365 provides services for enterprise.
Corporations can use a private cloud based on premise version
for security and management.<br>
In addition, each sector’s different requirements can't be handled
by a universal platform. Easily meet the various needs in your
corporation through a customized version of NetMiner 365.</p>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>NetMiner 365 for Everyone</h3>
					<p>Everyone can easily utilize NetMiner 365<br>
to create unique insights that combine Machine Learning and Graph Analytics.</p>
					<div class="content">
						<ul>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Experts of Network Analysis</h4>
									<p>A lot of graph analytics algorithms and
functions of NetMiner 365 help you
understand graph structures and
features accurately.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>For Beginners</h4>
									<p>Handle data uploading, visualization,
and graph/machine learning.<br>
Analyze your data easily.<br>
All it takes is just a few clicks.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>Advanced Analysts</h4>
									<p>A fused analysis utilizing Graph
Analytics, multivariate statistics, and
machine learning can grant new and
differentiated insights.</p>
								</div>
							</li>
						</ul>
						<div class="bg"></div>
					</div>
				</div>
			</div>
			
			
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	</body>
</html>