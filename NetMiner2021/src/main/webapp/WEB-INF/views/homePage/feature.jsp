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
		<script src="resources/js/main.js" type="text/javascript"></script> 
	</head>
	<body>
		<div id="wrap" class="feature">
			<div id="top">
				<div class="content">
					<div class="wrap">
						<h1 class="obj"><a href="#"><img src="resources/images/main_logo.png" alt="Why NetMiner 365 logo"></a></h1>
						<div class="pc">
							<div class="menu obj">
								<span class="select">Feature</span>
								<ul>
									<li><a href="#">Why NetMiner 365</a></li>
									<li class="active"><a href="#">Feature</a></li>
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
									<li><a href="#">Why NetMiner 365</a></li>
									<li class="active"><a href="#">Feature</a></li>
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
							<h2>빅데이터  분석에 필요한 모든 것</h2>
							<p>언제, 어디에서나, 쉽게 빅데이터 속의 그래프 데이터를<br>
다양한 분석 방법을 통해 이해할 수 있습니다.<br>
NetMiner 365는 당신이 필요한 모든 것을 갖춘 플랫폼 입니다.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>NetMiner 365를 선택해야하는 이유</h3>
					<p>NetMiner 365는 쉽게 그래프 구조를 발견하고, 그래프 및 머신러닝 기술을 적용할 수 있도록<br>
설계된 클라우드 기반의 빅데이터 분석 플랫폼입니다.</p>
					<div class="content">
						<ul>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>빅데이터로부터 그래프 추출</h4>
									<p>빅데이터에 숨겨진 그래프 구조를 쉽고 간단하게 추출할 수
	있도록 도와줍니다. 사용자가 할 일은 단지  관계로 연결하려는
	데이터만 선택하는 것입니다. 그래프 데이터 모델링, 구조화는
	NetMiner 365가 수행합니다.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>그래프 분석 </h4>
									<p>기존 분석 방법의 한계 때문에 최근 ‘관계’에서 가치를 찾으려는
	움직임이 점차 증가하고 있습니다. 그래프 분석은 관계 데이터를
	이해하는데 가장 적합한 기술입니다. NetMiner 365 에서
	제공하는 핵심적인 그래프 네트워크 분석 알고리즘과 그래프
	데이터 처리 및 시각화 등의 기능은 사용자가 그래프에서 가치를 
	찾을 수 있도록 도와줍니다.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>머시러닝 & 딥러닝</h4>
									<p>NetMiner 365는 널리 사용되는 머신러닝 및 딥러닝 알고리즘과
	그래프 자체를 학습할 수 있는 그래프 머신러닝을 모두 제공합니다.
	또한 그래프에서 얻은 관계적 특성을 머신러닝에 활용할 수
	있도록 설계되어, 그래프 분석과 머신러닝의 융복합 분석이
	가능합니다.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>언제, 어디서나, 제약 없이</h4>
									<p>NetMiner 365는 클라우드 기반의 온라인 플랫폼으로, 언제,
어디에서나 웹을 통해 액세스가 가능하기 때문에, 생산성을 극대화
할 수 있습니다. 또한 시스템 및 하드웨어의 제약이 줄어들어
빅데이터 분석에 필요한 시간과 비용을 단축시킬 수 있습니다.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>엔터프라이즈</h4>
									<p>엔터프라이즈에 맞는 서비스를 제공합니다. 기업은 보안, 관리를
위해 프라이빗 클라우드 기반의 온프레미스(On premise) 버전을
사용할 수 있습니다. 또한 섹터별로 다른 요구사항은 범용적
플랫폼으로는 해결할수 없습니다. 커스터마이즈된 NetMiner
365 를 통해 기업 내 다양한 니즈를 쉽게 해결해 보세요.</p>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>모두를 위한 NetMiner 365</h3>
					<p>누구나 쉽게 NetMiner 365 를 활용하여<br>
그래프 분석과 머신러닝이 결합된 특별한 인사이트를 만들어낼 수 있습니다.</p>
					<div class="content">
						<ul>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>네트워크 분석 전문가 </h4>
									<p>NetMiner 365가 제공하는 풍부한 그래프
분석 알고리즘과 기능은 그래프 구조,
특성을 정확히 이해할 수 있도록 돕습니다.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>초급 분석가</h4>
									<p>필요한 건 단지 몇 번의 클릭 입니다.
데이터 업로드, 시각화, 그래프 및 머신러닝
분석까지. 쉽게 데이터를 분석하세요.</p>
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									<h4>고급 분석가</h4>
									<p>그래프 분석, 다변량 통계, 머신러닝을
활용한 융복합 분석을 통해, 기존과  차별화
되는 새로운 인사이트를 얻을 수 있습니다.</p>
								</div>
							</li>
						</ul>
						<div class="bg"></div>
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