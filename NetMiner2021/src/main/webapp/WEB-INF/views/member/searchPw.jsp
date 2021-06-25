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
	<div id="top"></div>
		<div id="wrap" class="sub searchPw">
			<div id="section">
				<div class="wrap">
					<!-- step1 비밀번호 재설정 요청 -->
					<c:if test="${empty userId}">
					<div class="step1">
						<div class="title">
							<h2>Do you forgot your password?</h2>
							<p>비밀번호를 재설정 하시겠습니까?</p>
						</div>
						<div class="content">
							<p>가입했던 이메일 주소를 입력하고, 비밀번호 재설정을 요청하세요.</p>
							<div class="input">
								<p>이메일</p>
								<input placeholder="" type="text" id="email" />
								<p class="sum">비밀번호 재설정은 30 분 간 유효합니다.<br>
	메일을 찾을 수 없다면, 스팸 폴더를 확인해 보십시오.</p>
							</div>
							<button class="requestPw trs active" onClick="requestSetPwd();">비밀번호 재설정 요청</button>
							<a class="back" href="./login" >로그인으로 돌아가기 </a>
						</div>
					</div>
					</c:if>
					
					<!-- step2 비밀번호 재설정 -->
					<c:if test="${!empty userId}">
					<div class="step2" style="display:none;">
						<div class="title">
							<h2>Reset you password</h2>
							<p>비밀번호를 재설정</p>
						</div>
						<div class="content">
							<p>새 비밀번호를 입력하고 비밀번호를 확인하세요.</p>
							<div class="input">
								<ul>
									<li>
										<p>새 비밀번호</p>
										<input placeholder="" type="password" />
									</li>
									<li>
										<p>비밀번호 확인</p>
										<input placeholder="" type="password" />
									</li>
								</ul>
							</div>
							<button class="changePw trs active" onClick="changePwd()">비밀번호 재설정 및 로그인</button>
							<a class="back" href="#" >로그인으로 돌아가기 </a>
						</div>
					</div>
					</c:if>
				</div>
			</div>
		</div>
	
	</body>
</html>