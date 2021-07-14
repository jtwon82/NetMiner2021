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
		<title>Function | NetMiner 365</title>
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
							<h2>NetMiner 365 의 특별한 기능</h2>
							<p>그래프 분석 및 머신러닝, 통계 등 다양한 방법의 데이터 분석 알고리즘,<br>
데이터를 직관적으로 이해할 수 있는 시각화 알고리즘,<br>
그리고 빅데이터에서 그래프를 뽑아내고 처리할 수 있는 기능을 제공합니다.</p>
						</div>
						
					</div>
				</div>
			</div>
			<div id="section1" class="section">
				<div class="wrap">
					<h3>데이터 관리</h3>
					<div class="content">
						<div class="bg"></div>
						<div class="text">DB 또는 파일로 저장된 대용량의 데이터를 빠르게 업로드 할 수
있고 빅데이터에서 쉽게 관계형 데이터를 뽑아낼 수 있습니다.
<br><br>
또한 이미 가져온 데이터에 대해서도 다양한 전처리 방법을 제공
합니다. 예를 들어 조건에 따라 그래프 기반으로 데이터를 추출 및
가공할 수 있는 쿼리(Query) 기능은 당신이 빅데이터를 가공하고
처리할 수 있도록 도와주는 강력한 기능입니다.</div>
					</div>
				</div>
			</div>
			<div id="section2" class="section">
				<div class="wrap">
					<h3>데이터 분석</h3>
					<div class="content">
						<ul>
							<li>
								<div class="bg"></div>
								<div class="text">
									그래프 구조를 정확히 이해할 수 있는 그래프 분석 알고리즘을
제공합니다. 그래프에서 노드(개체)의 중요도(Centrality)를
측정하고 노드 간 관계를 기반으로 클러스터링 (Cohesive Group,
Equivalence Cluster)을 할 수 있습니다. 또한 그래프의 구조도
계량적으로 이해 할 수 있습니다.
								</div>
							</li>
							<li>
								<div class="bg"></div>
								<div class="text">
									데이터를 예측하고 분류하기 위한 머신러닝 및 딥러닝 알고리즘을
제공합니다. Naïve Bayes, SVM, CART, k means 등 범용적인
머신러닝 알고리즘과 딥러닝 알고리즘(MLP), 통계 기능을
제공합니다. 또한 GCN, Node 2 Vec 등 그래프 데이터를 학습할 
 있는 그래프 머신러닝도 제공합니다.
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div id="section3" class="section">
				<div class="wrap">
					<h3>데이터 시각화</h3>
					<div class="content">
						<ul>
							<li>
								<div class="bg"><img src="resources/images/function_section3_ico1.png"></div>
								<div class="text">다양한 차트를 통해 데이터를 직관적으로
이해할 수 있습니다. 기본적인 차트 뿐만
아니라 Parallel Coordinates, Treemap
등 복잡한 데이터를 위한 차트도
제공합니다.	</div>
							</li>
							<li>
								<div class="bg"><img src="resources/images/function_section3_ico2.png"></div>
								<div class="text">그래프데이터를 시각화하면 전체적 으로
그래프의 구조가 어떤지를 시각적으로
확인할 수 있습니다. 또한 스타일링 기능을
통해 필요한 정보를 그래프 이미지에 표현해
줄 수 있습니다.</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	</body>
</html>