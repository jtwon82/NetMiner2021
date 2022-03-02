<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<script src="resources/js/gnb.js" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="pricing">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>Plan and Pricing</h2>
							<p>Simple plans. Simple prices.<br>
Compare our subscription plans and find yours.</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<div class="content">
						<div class="paymentList_header">
							<ul>
								<li>TRIAL</li>
								<li>SMALL</li>
								<li>MEDIUM<p class="recommend obj"><em>Recommended</em></p></li>
								<li>LARGE</li>
							</ul>
						</div>
						<script>
							$(window).bind('scroll', function(e) {
								scrollEvt();
							});
							function scrollEvt() {
								if ($(document).scrollTop() > $('#section1').offset().top+80 && $(document).scrollTop() < $('#section2').offset().top-400) {
									$(".paymentList_header").addClass("show");
								}else{
									$(".paymentList_header").removeClass("show");
								}
							}
						</script>
						<ul class="paymentList">
							<li>
								<div class="top"></div>
								<div class="bottom">
									<p class="data">Data</p>
									<p class="feature">Feature</p>
								</div>
							</li>
							<li>
								<div class="top">
									<p>TRIAL</p>
									<p class="payment">Free</p>
									<p>1 month</p>
									<p>Enjoy<br>
										NetMiner 365<br>
										for free.
									</p>
										<c:if test="${!empty memberVo}">										
										<c:if test="${memberVo.planType == 1}"> 
										<p class="button active">
											<a href="javascript:void(0)">Current Plan</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType < 1}"> 
											<c:if test ="${memberVo.planType == 0}">
											<p class="button">
												<a href="./goSubscribe?planCode=01">Try for free</a>
											</p>
											</c:if>
											<c:if test ="${memberVo.planType == -1}">
											<p class="button">
												<a href="avascript:alert('Sorry, your free trial has expired.')">Try for free</a>
											</p>
											</c:if>
										</c:if>
										<c:if test="${memberVo.planType > 1}"> 
												<p class="button active">
													<a href="javascript:void(0)">Try for free</a>
												</p>
											</c:if>
									</c:if>
									<c:if test="${empty memberVo}">
									<p class="button">
										<a href="./login">Try for free</a>
									</p>
									</c:if>
								</div>
								<div class="bottom">
									<ul class="data">
										<li><em></em>3 workspace</li>
										<li><em></em>5 Tabular & Nodeset</li>
										<li><em></em>10 Networks</li>
									</ul>
									<ul class="feature">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<c:if test="${!empty memberVo}">										
										<c:if test="${memberVo.planType == 1}"> 
										<p class="button active">
											<a href="javascript:void(0)">Current Plan</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType < 1}"> 
											<c:if test ="${memberVo.planType == 0}">
											<p class="button">
												<a href="./goSubscribe?planCode=01">Try for free</a>
											</p>
											</c:if>
											<c:if test ="${memberVo.planType == -1}">
											<p class="button">
												<a href="avascript:alert('Sorry, your free trial has expired.')">Try for free</a>
											</p>
											</c:if>
										</c:if>
										<c:if test="${memberVo.planType > 1}"> 
												<p class="button active">
													<a href="javascript:void(0)">Try for free</a>
												</p>
											</c:if>
									</c:if>
									<c:if test="${empty memberVo}">
									<p class="button">
										<a href="./login">Try for free</a>
									</p>
									</c:if>
								</div>
							</li>
							<li>
								<div class="top">
									<p>SMALL</p>
									<p class="payment"><em></em> 99</p>
									<p>User / month</p>
									<p>Practical and<br>
									Great 'Test Drive'<br>
									for small project.
									</p>
									<c:if test="${!empty memberVo}">
											<c:if test="${memberVo.planType == 2}"> 
											<p class="button active">
												<a href="javascript:void(0);">Current Plan</a>
											</p>
											</c:if>
											<c:if test="${memberVo.planType < 2}"> 
												<p class="button">
													<a href="./goSubscribe?planCode=02">Get Started</a>
												</p>
											</c:if>
											<c:if test="${memberVo.planType > 2}"> 
												<p class="button active">
													<a href="javascript:void(0)">Get Started</a>
												</p>
											</c:if>
										</c:if>
										<c:if test="${empty memberVo}">
											<p class="button">
												<a href="./login" >Get Started</a>
											</p>
										</c:if>
								</div>
								<div class="bottom">
									<ul class="data">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<ul class="feature">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<c:if test="${!empty memberVo}">
											<c:if test="${memberVo.planType == 2}"> 
											<p class="button active">
												<a href="javascript:void(0);">Current Plan</a>
											</p>
											</c:if>
											<c:if test="${memberVo.planType < 2}"> 
												<p class="button">
													<a href="./goSubscribe?planCode=02">Get Started</a>
												</p>
											</c:if>
											<c:if test="${memberVo.planType > 2}"> 
												<p class="button active">
													<a href="javascript:void(0)">Get Started</a>
												</p>
											</c:if>
										</c:if>
										<c:if test="${empty memberVo}">
											<p class="button">
												<a href="./login" >Get Started</a>
											</p>
										</c:if>
								</div>
							</li>
							<li>
								<p class="recommend obj">RECOMMENDED</p>
								<div class="top">
									<p>MEDIUM</p>
									<p class="payment"><em></em> 199</p>
									<p>User / month</p>
									<p>Best plan<br>
										for medium-size<br>
										project.
									</p>
									<c:if test="${!empty memberVo}">										
										<c:if test="${memberVo.planType == 3}"> 
										<p class="button active">
											<a href="javascript:void(0);">Current Plan</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType < 3}"> 
										<p class="button">
											<a href="./goSubscribe?planCode=03">Get Started</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType > 3}"> 
												<p class="button active">
													<a href="javascript:void(0)">Get Started</a>
												</p>
											</c:if>
									</c:if>
									<c:if test="${empty memberVo}">
									<p class="button">
										<a href="./goSubscribe?planCode=03">Get Started</a>
									</p>
									</c:if>
								</div>
								<div class="bottom">
									<ul class="data">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<ul class="feature">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<c:if test="${!empty memberVo}">										
										<c:if test="${memberVo.planType == 3}"> 
										<p class="button active">
											<a href="javascript:void(0);">Current Plan</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType < 3}"> 
										<p class="button">
											<a href="./goSubscribe?planCode=03">Get Started</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType > 3}"> 
												<p class="button active">
													<a href="javascript:void(0)">Get Started</a>
												</p>
											</c:if>
									</c:if>
									<c:if test="${empty memberVo}">
									<p class="button">
										<a href="./goSubscribe?planCode=03">Get Started</a>
									</p>
									</c:if>
								</div>
							</li>
							<li>
								<div class="top">
									<p>LARGE</p>
									<p class="payment"><em></em> 299</p>
									<p>User / month</p>
									<p>Professional use<br>
										with large and<br>
										complex data.
									</p>
									<c:if test="${!empty memberVo}">										
										<c:if test="${memberVo.planType == 4}"> 
										<p class="button active">
											<a href="javascript:void(0);">Current Plan</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType < 4}"> 
										<p class="button">
											<a href="./goSubscribe?planCode=04">Get Started</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType > 4}"> 
												<p class="button active">
													<a href="javascript:void(0)">Get Started</a>
												</p>
											</c:if>
									</c:if>
									<c:if test="${empty memberVo}">
									<p class="button">
										<a href="./goSubscribe?planCode=04">Get Started</a>
									</p>
									</c:if>
								</div>
								<div class="bottom">
									<ul class="data">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<ul class="feature">
										<!-- <li><em></em></li>
										<li><em></em></li>
										<li><em></em></li> -->
									</ul>
									<c:if test="${!empty memberVo}">										
										<c:if test="${memberVo.planType == 4}"> 
										<p class="button active">
											<a href="javascript:void(0);">Current Plan</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType < 4}"> 
										<p class="button">
											<a href="./goSubscribe?planCode=04">Get Started</a>
										</p>
										</c:if>
										<c:if test="${memberVo.planType > 4}"> 
												<p class="button active">
													<a href="javascript:void(0)">Get Started</a>
												</p>
											</c:if>
									</c:if>
									<c:if test="${empty memberVo}">
									<p class="button">
										<a href="./goSubscribe?planCode=04">Get Started</a>
									</p>
									</c:if>
								</div>
							</li>
						</ul>
						<p class="help">Need Help with our plan? <a href="mailto:netminer@cyram.com">Contact Sales</a></p>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>Frequently asked questions</h3>
					<div class="content">
						<ul>
							<c:forEach var="faqList" items="${faqList}" varStatus="status">
							<li>
								<div class="question">
									<p><c:out value='${faqList.TITLE}'/></p>
									<em></em>
								</div>
								<div class="answer">
									<c:out value='${faqList.CONTENT}'/>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	
	</body>
</html>