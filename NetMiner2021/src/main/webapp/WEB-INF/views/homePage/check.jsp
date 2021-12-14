<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
		<title>Check | NetMiner 365</title>
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
		<script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub check">
			<div class="checkContainer">
				<h1><img src="resources/images/main_logo2.png" alt="NetMiner365"></h1>
				<p class="txt1"><span>서비스 점검 중 입니다.</span></p>
				<p class="pc">
					보다 안정적인 서비스를 제공하기 위해 서비스 점검을 진행하고 있습니다.<br><br>
					점검 중에는 서비스 이용이 불가능하며,<br>
					점검 시간은 상황에 따라 조기 종료 또는 지연될 수 있습니다.
				</p>
				<p class="mobile">
					보다 안정적인 서비스를 제공하기 위해<br> 서비스 점검을 진행하고 있습니다.<br><br>
					점검 중에는 서비스 이용이 불가능하며,<br>
					점검 시간은 상황에 따라 조기 종료 또는 지연될 수 있습니다.
				</p>
				<div class="box">
					<ul>
						<c:if test="${checkData.DBDOWN!='DBDOWN'}">
							<li><span>점검 시간</span><b>${checkData.START_DATE} ~ <c:if test="${'Y' eq checkData.END_DATE_YN}">미정</c:if>${checkData.END_DATE}</b></li>
						</c:if>
						<li><span>점검 내용</span><b>${checkData.COMMENT_KR}</b></li>
					</ul>
				</div>
				<p class="txt2">
					서비스 이용에 불편을 드린 점 죄송하다는 말씀을 드리며,<br>
					문의사항이 있으시면 netminer@cyram.com 으로 연락 바랍니다.
				</p>
			</div>
		</div>
	
	</body>
</html>