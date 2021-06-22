<%@ page language="java" contentType="text/html; charset=UTF-8"
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
		<script src="resources/js/gnb.js" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="whyNetminer">
			<div id="top">
				<div class="content">
					<div class="wrap">
						<h1 class="obj"><a href="#"><img src="resources/images/main_logo.png" alt="Why NetMiner 365 logo"></a></h1>
						<div class="pc">
							<div class="menu obj">
								<span class="select">Why NetMiner 365</span>
								<ul>
									<li class="active"><a href="#">Why NetMiner 365</a></li>
									<li><a href="#">Feature</a></li>
									<li><a href="#">Function</a>
									<li><a href="#">Solution</a>
								</ul>
							</div>
							<!-- 로그인 전-->
							<div class="mypage obj type1" >
								<ul>
									<li class="join"><a href="#" >Start for free</a></li>
									<li class="login"><a href="#" >Sign in</a></li>
								</ul>
							</div>
							<!-- 로그인 후-->
							<div class="mypage obj type2" style="display:none;">
								<p class="me">
									<img src="resources/images/top_me.png" alt="mypage">
								</p>
								<ul>
									<li class="workSpace active"><a href="#" class="trs">My Workspace</a></li>
									<li class="account"><a href="#" class="trs">Account</a></li>
									<li class="signOut"><a href="#" class="trs">Sign-Out</a></li>
								</ul>
							</div>
						</div>
					<div id="navBtn" class="mobile obj"><img src="resources/images/navBtn.png"></div>
					<div id="navOn" class="mobile">
						<div id="nav" class="obj">
							<div class="navClose obj"><img src="resources/images/nav_close.png" alt="닫기"></div>
							<div class="container">
								
								<!-- 로그인 전-->
								<div class="mypage type1" >
									<ul>
										<li class="join"><a href="#" >Start for free</a></li>
										<li class="login"><a href="#" >Sign in</a></li>
									</ul>
								</div>
								
								<!-- 로그인 후-->
								<div class="mypage type2" style="display:none;">
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
									<li class="active"><a href="#">Why NetMiner 365</a></li>
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
							<h2>빅데이터의 한 축, 그래프 데이터</h2>
							<p>빅데이터는 비정형 데이터와 그래프 데이터로 구성되어 있습니다.<br>
즉, 그래프 데이터를 놓치면 상당한 데이터의 손실이 발생합니다.<br>
유일한 방법은 바로 그래프 분석 및 머신러닝 입니다.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>새로운 시대를 위한 새로운 패러다임</h3>
					<p>우리는 이미 빅데이터의 세상 속에 있습니다.<br>
그러나 과연 빅데이터를 얼마나 제대로 이해하고 있을까요?</p>
					<div class="content">
						<div class="bg"></div>
						<div class="text">과거에 빅데이터 분석은 하둡과 통계, 머신러닝을 바탕으로
대용량 데이터를 처리하고, 데이터의 분포를 파악하고 예측하는
것을 의미했습니다.<br><br>

하지만, 빅데이터의 상당 부분은 본질적으로 그래프 데이터입니다.
안타깝게도 그래프 데이터는 과거의 분석 방법으로는 다룰 수 없는
데이터 간 관계를 담고 있기 때문에, 의미 있는 인사이트를 얻기
위해서는 새로운 접근 방법이 필요합니다.</div>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>가트너가 선정한 10대 분석 기술, 그래프 분석</h3>
					<p>2019년 시장조사기관 가트너(Gartner)는 그래프 분석을 10대 데이터 분석 기술로 선정했습니다.</p>
					<div class="content">
						<div class="text">그래프 분석과 그래프 머신러닝은 그래프 데이터를 분석할 수 있는
유일한 방법으로, 가트너에서 10 대 데이터 분석 기술로 선정할만큼
점차 주목 받고 있습니다.<br><br>

NetMiner 365는 네트워크 분석 소프트웨어 NetMiner 를 바탕으로한
풍부한 그래프 분석 알고리즘과 그래프 데이터 분석을 위한 기능들을
갖추고 있습니다.</div>
						<div class="bg"></div>
					</div>
				</div>
			</div>
			<div id="section3" class="section">
				<div class="wrap">
					<h3>그래프 분석과 머신러닝의 만남</h3>
					<p>그래프 분석을 통해 얻은 그래프 효과는 데이터 예측과 분류의 정확도를 높일 수 있습니다.</p>
					<div class="content">
						<div class="bg"></div>
						<div class="text">그래프 분석은 그래프를 이해하는 유일한 방법일 뿐만 아니라,
머신러닝을 통한 예측의 정확도를 높여줄 수 있는 방법입니다.
<br><br>
빅데이터에 내재된 그래프 구조에서 관계 적 특성을 추출하여
머신러닝에 활용하면, 더욱 정교하게 데이터를 이해하고 예측할 수
있습니다. 또한 그래프 전용 머신러닝 알고리즘은 그래프 데이터를
그대로 학습하여 데이터를 예측할 수 있습니다.</div>
					</div>
				</div>
			</div>
			<div id="footer" >
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
									<li><a href="http://www.netminer.com/" target="_blank">netminer</a></li>
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