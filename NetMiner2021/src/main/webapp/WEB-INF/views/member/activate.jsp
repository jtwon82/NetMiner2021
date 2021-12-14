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
		<title>Dormate | NetMiner 365</title>
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
		<div id="wrap" class="sub activate">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Activate your account</h2>
						<p>계정이 휴면 상태입니다</p>
					</div>
					<div class="content">
						<p>1년 이상 NetMiner 365 를 이용하지 않아서<br> 
계정이 휴면 상태로 전환되었습니다.
<br><br>
서비스를 다시 이용하고 싶은 경우에는 <br> 
아래 ‘휴면 계정 해제하고 로그인’을 클릭해 주세요.</p>
					
						<button class="actiAccount trs active" onClick="window.location.href='./turnToGeneral'">휴면 계정 해제하고 로그인</button>
						<a class="back" href="./login" >로그인으로 돌아가기 </a>
					</div>
					
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	<c:if test="${empty outMemberVo}"> 
		<script> $(function (){ window.location.href="./login";})</script>
	</c:if>
	<script> window.onpopstate= function (event){ window.location.replace("./login");}</script>
	</body>
</html>