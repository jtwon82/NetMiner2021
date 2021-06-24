<%@ page language="java" contentType="text/html; charset=UTF-8;"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
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
		<script src="resources/js/gnb.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="main">
			<div id="top">
				<div class="content">
					<div class="wrap">
						<h1 class="obj"><a href="#"><img src="resources/resources/images/main_logo.png" alt="Why NetMiner 365 logo"></a></h1>
						<div class="pc">
							<div class="menu obj">
								<span class="select">Why NetMiner 365</span>
								<ul>
									<li><a href="#">Why NetMiner 365</a></li>
									<li><a href="#">Feature</a></li>
									<li><a href="#">Function</a>
									<li><a href="#">Solution</a>
								</ul>
							</div>
							
							<!-- 로그인 전-->
							<c:if test="${empty memberVo}">
							<div class="mypage obj type1" >
								<ul>
									<li class="join"><a href="#" >Start for free</a></li>
									<li class="login"><a href="./login" >Sign in</a></li>
								</ul>
							</div>
							</c:if>
							<!-- 로그인 후-->
							<c:if test="${!empty memberVo}">	
							<div class="mypage obj type2" >
								<p class="me">
									<img src="resources/images/top_me.png" alt="mypage">
								</p>
								<ul>
									<li class="workSpace active"><a href="#" class="trs">My Workspace</a></li>
									<li class="account"><a href="./account" class="trs">Account</a></li>
									<li class="signOut"><a href="./logOut" class="trs">Sign-Out</a></li>
								</ul>
							</div>
							</c:if>
						</div>
					<div id="navBtn" class="mobile obj"><img src="resources/images/navBtn.png"></div>
					<div id="navOn" class="mobile">
						<div id="nav" class="obj">
							<div class="navClose obj"><img src="resources/images/nav_close.png" alt="닫기"></div>
							<div class="container">
															
								<!-- 로그인 전-->
								<div class="mypage type1" style="display:none;">
									<ul>
										<li class="join"><a href="#" >Start for free</a></li>
										<li class="login"><a href="#" >Sign in</a></li>
									</ul>
								</div>
								
								<!-- 로그인 후-->
								<div class="mypage type2"  style="display:none;">
									<p class="me">
										<img src="resources/images/top_me.png" alt="mypage">
									</p>
									<ul>
										<li class="workSpace active"><a href="#" class="trs">My Workspace</a></li>
										<li class="account"><a href="#" class="trs">Account</a></li>
										<li class="signOut"><a href="#" class="trs">Sign-Out</a></li>
									</ul>
								</div>
								
								<ul class="menu">
									<li><a href="#">Why NetMiner 365</a></li>
									<li><a href="#">Feature</a></li>
									<li><a href="#">Function</a>
									<li><a href="#">Solution</a>
								</ul>
							</div>
						</div>
						<div class="bg"></div>
					</div>
			
			
					</div>
				</div>
			</div>
			<div id="main">
				<div class="wrap">
					<div class="slider">
						<div class="text">
							<h2>빅데이터를 보는 새로운 패러다임,<br>그래프 머신러닝</h2>
							<p>기존의 빅쿼리, 머신러닝으로는 더 이상 새로운 인사이트를 얻을 수 없습니까?<br>
빅데이터에 숨겨진 그래프 구조를 이해해야 더욱 정교한 예측과 분류가 가능합니다.</p>
						</div>
						
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
						<a class="more"  href="#">Learn more  > ></a>
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
						<a class="more"  href="#">Learn more  > ></a>
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
						<a class="more"  href="#">Learn more  > ></a>
					</div>
				</div>
			</div>
			<div id="footer">
				<div class="wrap">
					<div class="content content1">
						<div>
							<h4>NM 365 무료로 시작</h4>
							<a hrefe="">Start for free</a>
						</div>
					</div>
					<div class="content content2">
						<div>
							<ul class="terms obj">
								<li><a href="">이용약관</a></li>
								<li><a href="">개인정보처리방침</a></li>
							</ul>
							<div class="lang obj">
								<p>KOREAN<span></span></p>
								<ul>
									<li style="display:none;"><a href="">KOREAN</a></li>
									<li><a href="">ENGLISH</a></li>
								</ul>
							</div>
							<div class="family obj">
								<p>패밀리사이트<span></span></p>
								<ul>
									<li class="active"><a href="http://www.netminer.com/" target="_blank">netminer</a></li>
									<li><a href="http://www.cyram.com/" target="_blank">cyram</a></li>
									<li><a href="http://edu.cyram.com" target="_blank">edu.cyram</a></li>
								</ul>
							</div>
							<ul class="sns kr obj">
								<li class="fb"><a href="https://www.facebook.com/CyramInc" target="_blank"><img src="resources/images/footer_fb.png" alt="페이스북"></a></li>
								<li class="ins"><a href="https://twitter.com/cyraminc" target="_blank"><img src="resources/images/footer_ins.png" alt="인스타그램"></a></li>
								<li class="blog"><a href="https://cyram.tistory.com" target="_blank"><img src="resources/images/footer_blog.png" alt="블로그"></a></li>
								<li class="yt"><a href="https://www.youtube.com/channel/UCEyZjvgAc4uEIuHKRI5Jk0w/" target="_blank"><img src="resources/images/footer_yt.png" alt="유튜브"></a></li>
							</ul>
							<ul class="sns en obj" style="display:none;">
								<li class="fb"><a href="https://www.facebook.com/cyramnetminer" target="_blank"><img src="resources/images/footer_fb.png" alt="facebook"></a></li>
								<li class="ins"><a href="https://twitter.com/netminer" target="_blank"><img src="resources/images/footer_ins.png" alt="instagram"></a></li>
								<li class="yt"><a href="https://www.youtube.com/channel/UCEyZjvgAc4uEIuHKRI5Jk0w/" target="_blank"><img src="resources/images/footer_yt.png" alt="youtube"></a></li>
							</ul>
							<p class="cr obj">© CYRAM Inc. ALL RIGHTS RESERVED</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</body>
</html>