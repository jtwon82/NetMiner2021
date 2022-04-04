<%@ page language="java" contentType="text/html; charset=UTF-8;"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
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
		<link href="resources/css/style.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
		<link href="resources/css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="resources/js/swiper.min.js" type="text/javascript"></script>
		<script src="resources/js/gnb.js" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="main">
			<%@include file = "../common/top.jsp" %>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>빅데이터를 보는 새로운 패러다임,<br>그래프 머신러닝</h2>
							<p>기존의 쿼리, 단순 통계분석으로는 더 이상 새로운 인사이트를 얻을 수 없습니까?<br>
빅데이터에 숨겨진 그래프 구조를 이해해야 더욱 정교한 예측과 분류가 가능합니다.</p>
						</div>
						
							<c:if test="${empty memberVo}">
							<div class="mypage obj type1" style="">
								<ul>
									<!--  <li class="join"><a href="./login" >Start for free</a></li>-->
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
					<h3>그래프 머신러닝을 위한 플랫폼</h3>
					<p>데이터를 제대로 이해하기 위해서는 그에 맞는 접근방법이 필요합니다.<br>
빅데이터에는 엄청난 그래프(관계) 데이터가 존재하지만, 기존의 데이터 분석 방법은 정보 구조화, 검색, 통계 만으로 데이터를 이해했습니다.<br>
오랜 기간 축적된 그래프 분석 노하우와 그래프 머신 러닝 기술이 접목된 NetMiner 365는 기존과 차별화된 새로운 혁신과 영감을 줄 것입니다.</p>
					<div class="content">
						<div class="bg"></div>
						<a class="more"  href="./whyNetMiner">Learn more  > ></a>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>NetMiner 365가 필요한 이유</h3>
					<p>그래프 분석과 머신러닝의 혁신적인 결합을 바탕으로 비즈니스에 필요한 모든 것을 제공합니다.</p>
					<div class="content">
						<ul class="line1">
							<li>
								<img src="resources/images/main_section2_ico1.png" alt="빅데이터로부터 그래프 추출"> 
								<h4>빅데이터로부터 그래프 추출</h4>
								<p>빅데이터에 숨겨진 그래프 구조를<br>
쉽고 간단하게 추출할 수 있도록<br>
도와줍니다.</p>
							</li>
							<li>
								<img src="resources/images/main_section2_ico2.png" alt="그래프 분석"> 
								<h4>그래프 분석</h4>
								<p>그래프 효과를 이해하기 위한<br>
데이터 구조, 알고리즘, 기능을<br> 제공합니다.</p>
							</li>
							<li>
								<img src="resources/images/main_section2_ico3.png" alt="머신러닝 & 딥러닝"> 
								<h4>머신러닝 & 딥러닝</h4>
								<p>그래프 데이터를 위한 머신러닝과<br>
일반적으로 많이 사용되는 머신러닝<br>
알고리즘을 모두 제공합니다.</p>
							</li>
						</ul>
						<ul class="line2">
							<li>
								<img src="resources/images/main_section2_ico4.png" alt="언제, 어디에서나, 제한 없이"> 
								<h4>언제, 어디에서나, 제한 없이</h4>
								<p>NetMiner 365는 클라우드 기반의<br>
온라인 솔루션으로 언제, 어디에서나<br>
웹을 통해 액세스가 가능합니다.</p>
							</li>
							<li>
								<img src="resources/images/main_section2_ico5.png" alt="엔터프라이즈"> 
								<h4>엔터프라이즈</h4>
								<p>엔터프라이즈를 위한 온프레미스<br>
(On-premise), 커스텀 등이<br>
가능합니다 (향후)</p>
							</li>
						</ul>
						<a class="more"  href="./feature">Learn more  > ></a>
					</div>
				</div>
			</div>
			<div id="section3" class="section">
				<div class="wrap">
					<h3>NetMiner 365가 문제를 해결하는 방법</h3>
					<p>NetMiner 365를 어떻게 사용할 수 있는지, 당신의 비즈니스에 어떻게 도움을 줄 수 있는지 확인해 보십시오 .</p>
					<div class="content">
						<ul>
							<li>인사/조직</li>
							<li>영업/마케팅</li>
							<li>전략/R&D</li>
							<li>컴플라이언스 범죄</li>
							<li>제조/공급망</li>
						</ul>
						<a class="more"  href="./solution">Learn more  > ></a>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
	 
</html>