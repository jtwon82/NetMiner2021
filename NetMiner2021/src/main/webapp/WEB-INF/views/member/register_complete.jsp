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
		<title>register | NetMiner365</title>
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
		<div id="wrap" class="sub register_complete">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Hello!</h2>
						<p>NetMiner 365의 회원이 된 것을 축하드립니다.<br>
NetMiner 365를 통해 무한한 가능성을 탐색해보세요.</p>
					</div>
					<div class="content">
						<ul>
							<li>
								<h3>Features</h3>
								<p>NetMiner 365는 그래프 분석과
머신러닝을 결합하여 예측의 정확도를
높이고, 시간과 비용을 줄일 
있도록 설계된 클라우드 기반의
빅데이터 분석 플랫폼입니다.</p>
								<a href="./feature">더 보기</a>
							</li>
							<li>
								<h3>Support</h3>
								<p>NetMiner 365 영업팀과의
자세한 상담이 필요하십니까?
<br><br>
그렇다면 도움을 요청하세요.</p>
								<a href="mailto:netminer@cyram.com">문의하기</a>
								
							</li>
							<li>
								<h3>Start NetMiner 365</h3>
								<p>NetMiner 365를 통해 비즈니스에서
발생하는 다양한 문제들을
해결할 수 있습니다.
<br><br>
NetMiner 365를 시작해보세요.</p>
								<!--  <a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}">시작하기</a>-->
								<a href="./pricing">시작하기</a>
							</li>
						</ul>
						
				</div>
			</div>
		</div>
			<%@include file = "../common/memberFooter.jsp" %>
	</div>
	
	</body>
</html>