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
		<div id="wrap" class="sub register">
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Register for NetMiner 365</h2>
						<p>이미 계정을 가지고 있습니까? <a href="./login">로그인</a></p>
					</div>
					<div class="content">
						<div>	
											
							<ul class="input">
								<li><input placeholder="이메일" type="text" name="email" id ="email"/></li>
								<li><input placeholder="비밀번호" type="password" name="pwd" id="pwd"/><span class="sum">영문, 숫자 조합 6~20 글자</span></li>
								<li><input placeholder="소속기관" type="text" name="company" id="company"/></li>
							</ul>
							<select name="nation" id="nation">
								<option value="" disabled selected hidden >국가</option>
								<option value="korea">한국</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select>
							<div class="checkBox">
								<p>이용용도</p>
								<ul>
									<li><label><input type="radio" checked="checked" name="useCode" value="01"><em></em>학술용</label></li>
									<li ><label><input type="radio" checked="checked" name="useCode" value="02"><em></em>일반/기업용</label></li>
								</ul>
							</div>
							<button class="authentic trs" onClick="checkEmail()">이메일 인증</button>							
							<span class="line">또는</span>
							<button class="google trs" onClick="googleRegister();">Continue in with Google</button>
						</div>
						<dl>
							<dt>NetMiner 365에 회원으로 가입하면,</dt>
							<dd>14 일 간 서비스 무료 체험이 가능</dd>
							<dd>지속적이고 끊김이 없는 지원</dd>
							<dd>최신 소식 , 혜택을 뉴스레터로 수신</dd>
						</dl>
					</div>
					
					
				</div>
			</div>
		</div>
	
	</body>
</html>