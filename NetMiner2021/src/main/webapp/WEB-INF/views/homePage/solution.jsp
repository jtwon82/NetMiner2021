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
		<div id="wrap" class="solution">
			<div id="top">
				<div class="content">
					<div class="wrap">
						<h1 class="obj"><a href="#"><img src="resources/images/main_logo.png" alt="Why NetMiner 365 logo"></a></h1>
						<div class="pc">
							<div class="menu obj">
								<span class="select">Solution</span>
								<ul>
									<li><a href="#">Why NetMiner 365</a></li>
									<li><a href="#">Feature</a></li>
									<li><a href="#">Function</a>
									<li class="active"><a href="#">Solution</a>
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
									<li><a href="#">Why NetMiner 365</a></li>
									<li><a href="#">Feature</a></li>
									<li><a href="#">Function</a>
									<li class="active"><a href="#">Solution</a>
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
							<h2>비즈니스 문제를 해결할 수 있는 열쇠</h2>
							<p>NetMiner 365를 어떻게 사용할 수 있는지,<br>
당신의 비즈니스에 어떻게 도움을 줄 수 있는지<br>
우리의 이야기를 통해 배워보십시오.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>인사 / 조직</h4>
							<p>조직 시스템을 구성하는 지식, 업무, 자원, 사람들끼리
발생하는 다양한 층위의 네트워크는 조직의 성과와
발전에 매우 중요한 요소입니다. 조직에서 발생한
실제 커뮤니케이션 패턴을 수집하여 소통의 구조와
효율성을 진단함으로써 기업은 조직의 흐름을 더 잘
이해하고 조직의 성과를 효과적으로 개선할 수 있습니다.</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>영업 / 마케팅</h4>
							<p>새로운 소비의 시대. 온라인에는 고객의 행위 패턴과
관심사를 파악할 수 있는 수많은 데이터가 존재합니다.
마케터는 그래프 분석과 머신러닝 분석을 통해  고객의
행위와 확산 패턴을 분석하고 이를 통해 고객의 프로필과
행동을 예측하여 개인 맞춤형 제안을 할 수 있습니다.</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section3" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>전략 / 연구 개발 </h4>
							<p>정부나 기업이 발전하기 위해서는 목표 달성을 위한
명확한 전략 설정과 이를 위한 연구개발에 대한 투자가
필요합니다. 그래프를 기반으로 한 지식 지도는 방대한
분량의 문헌 데이터에 존재하는 지식의 구조를 시각적으로
이해할 수 있도록 도와주며, 머신러닝은 데이터의 분류 및
예측에 드는 시간과 비용을 크게 줄여줄 수 있습니다.</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section4" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>컴플라이언스 범죄</h4>
							<p>사회 시스템 고도화로 인해, 사기, 공모, 부정행위의
패턴도 점차 복잡해지면서 추적에 많은 시간과 비용이
듭니다. 그래프 분석과 머신러닝을 활용하면 빠르게 이상
패턴을 파악하고, 전체 혐의 그룹의 관계 구조를
이해할 수 있습니다.</p>
						</div>
					</div>
				</div>
			</div>
			<div id="section5" class="section">
				<div class="wrap">
					<div class="content">
						<div class="bg"></div>
						<div class="text">
							<h4>제조 / 공급망 관리</h4>
							<p>생산 과정을 효율화 하고, 제품의 수요와 공급량을
정확하게 예측하고, 물류 경로나 조건을 최적화하면
기업의 수익을 크게 증가시킬 수 있습니다. 그래프 분석은
공정 구조, 다른 기업과의 거래 관계, 물류 이동 패턴 등 을
파악하여 손실을 줄이고, 공급망의 병목을 해소하는 것을
도울 수 있습니다.</p>
						</div>
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