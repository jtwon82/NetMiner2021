<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
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
<body>
		<div id="wrap" class="pricing">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>나에게 딱 맞는 플랜을 선택하세요</h2>
							<p>월 또는 연간 결제를 통해 필요한만큼<br>
NetMiner 365 를 이용하세요.</p>
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
								<li>MEDIUM<p class="recommend obj"><em>권장사항</em></p></li>
								<li>LARGE</li>
							</ul>
						</div>
						<script>
						$(document).ready(function() {
							$(window).bind('scroll', function(e) {
								scrollEvt();
							});
						})
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
									<p>28 days</p>
									<p>NetMiner 365의<br>
										모든 기능을 무료로<br>
										사용해 보세요.
									</p>
								<c:if test="${empty memberVo}">
									<p class="button"><a href="./login">무료체험</a></p>
									</c:if>
									<c:if test="${!empty memberVo}">
									<p class="button"><a href="./goSubscribe?planCode=01">무료체험</a></p>
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
									<c:if test="${empty memberVo}">
									<p class="button"><a href="./login">무료체험</a></p>
									</c:if>
									<c:if test="${!empty memberVo}">
									<p class="button"><a href="./goSubscribe?planCode=01">무료체험</a></p>
									</c:if>
								</div>
							</li>
							<li>
								<div class="top">
									<p>SMALL</p>
									<p class="payment"><em></em> 68,600</p>
									<p>User / month</p>
									<p>NetMiner365 를<br>
								가볍고, 실용적으로<br>
								사용할 수 있습니다.
									</p>
									<p class="button">
										<c:if test="${!empty memberVo}">
										<a href="./goSubscribe?planCode=02">구독하기</a>
										</c:if>
										<c:if test="${empty memberVo}">
										<a href="./login" >구독하기</a>
										</c:if>
									</p>
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
									<p class="button">
									<c:if test="${!empty memberVo}">
									<a href="./goSubscribe?planCode=02">구독하기</a>
									</c:if>
									<c:if test="${empty memberVo}">
									<a href="./login" >구독하기</a>
									</c:if>
									</p>
								</div>
							</li>
							<li>
								<p class="recommend obj">권장사항</p>
								<div class="top">
									<p>MEDIUM</p>
									<p class="payment"><em></em> 138,600</p>
									<p>User / month</p>
									<p>중급 규모의<br>
								데이터를 분석하기에<br>
								가장 적합합니다.
									</p>
									<p class="button">
									<c:if test="${!empty memberVo}">
									<a href="./goSubscribe?planCode=03">현재 플랜</a>
									</c:if>
									<c:if test="${empty memberVo}">
									<a href="./login" >구독하기</a>
									</c:if>
									</p>
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
									<p class="button">
									<c:if test="${!empty memberVo}">
									<a href="./goSubscribe?planCode=03">현재 플랜</a>
									</c:if>
									<c:if test="${empty memberVo}">
									<a href="./login" >구독하기</a>
									</c:if>
									</p>
								</div>
							</li>
							<li>
								<div class="top">
									<p>LARGE</p>
									<p class="payment"><em></em> 278,600</p>
									<p>User / month</p>
									<p>다양한 데이터를 위해<br>
								충분한 공간을<br>
								제공합니다.
									</p>
									<p class="button">
									<c:if test="${!empty memberVo}">
									<a href="./goSubscribe?planCode=04">구독하기</a>
									</c:if>
									<c:if test="${empty memberVo}">
									<a href="./login" >구독하기</a>
									</c:if>
									</p>
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
									<p class="button">
									<c:if test="${!empty memberVo}">
									<a href="./goSubscribe?planCode=04">구독하기</a>
									</c:if>
									<c:if test="${empty memberVo}">
									<a href="./login" >구독하기</a>
									</c:if>
									</p>
								</div>
							</li>
						</ul>
						<p class="help">도움이 필요하십니까? <a href="#">영업팀 문의</a></p>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>자주하는 질문</h3>
					<div class="content">
						<ul>
							<li>
								<div class="question">
									<p>내 결제 옵션에는 무엇이 있나요? 신용카드를 사용하거나 인보이스를 받을 수 있나요?(예시)</p>
									<em></em>
								</div>
								<div class="answer">
									신용카드를 사용해 모든 플랜의 요금을 결제할 수 있습니다. 연간 구독에 가입하고 US$5,000 이상을 사용할 계획이시라면,
									1년 기준으로 인보이스를 받으실 수 있습니다. 자세한 정보를 얻으려면 고객지원센터를 방문하세요.
									이 프로세스를 시작하려면 당사에 문의해주세요.(예시)
								</div>
							</li>
							<li>
								<div class="question">
									<p>팀에 활발하게 사용되지 않는 계정이 여러 개 있으나 이러한 계정을 비활성화하고 싶지는 않습니다.<br>
그래도 해당 계정의 요금을 지불해야 하나요?(예시)</p>
									<em></em>
								</div>
								<div class="answer">
									신용카드를 사용해 모든 플랜의 요금을 결제할 수 있습니다. 연간 구독에 가입하고 US$5,000 이상을 사용할 계획이시라면,
									1년 기준으로 인보이스를 받으실 수 있습니다. 자세한 정보를 얻으려면 고객지원센터를 방문하세요.
									이 프로세스를 시작하려면 당사에 문의해주세요.(예시)
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>