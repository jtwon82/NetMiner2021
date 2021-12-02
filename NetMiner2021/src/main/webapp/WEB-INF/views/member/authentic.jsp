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
		<title>Code | NetMiner365</title>
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
	<div id = "dimmed" style="position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100; opacity: 0.5; background-color: rgb(0, 0, 0); display: none;" ></div>
		<div id="wrap" class="sub authentic">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>You're almost there..</h2>
					</div>
					<div class="content">
						<p>7글자의 인증 코드를 ${userId} 로 발송했습니다.<br>
인증코드는 30 분간 유효합니다.</p>
						<div class="input">
							<p>인증코드</p>
							<input placeholder="" type="text" id="code"/>
							<p class="sum">메일을 찾을 수 없다면, 스팸 폴더를 확인해 보십시오.<br>또는 <a href="javascript:;" class="blue" onClick="newRandomNumber('${userId}');">인증코드 재발송</a></p>
						</div>
						<c:if test="${empty memberVo}">
						<div class="agree">
							<label><input id="check_all" type="checkbox"><em></em>모두 동의합니다.</label>
							<label><input id="check1" class="check" type="checkbox" name="age"><em></em>만 16 세 이상입니다 <span>(필수)</span></label>
							<label><input id="check2" class="check" type="checkbox" name="using"><em></em><a href='javascript:;' onClick="window.open('./TermsOfService')" class="blue">이용약관</a>과 <a href='javascript:;' onClick="window.open('./Privacy')" class="blue">개인정보처리방침</a> 에 동의합니다 <span>(필수)</span></label>
							<label><input id="check3" class="check" type="checkbox" name="marketYn" value="Y"><em></em>유용한 정보 , 혜택 안내 등을 위한 이메일 수신에 동의합니다 <span>(선택)</span></label>
						</div>
						</c:if>
						<c:if test="${empty memberVo}">
						<button class="create trs active" onClick="register('${userId}')">계정 생성</button>
						</c:if>
						<c:if test="${!empty memberVo}">
						<button class="create trs active" onClick="registerCheckEmail('${userId}')">이메일 인증</button>
						</c:if>
						<a class="back" id="authentic" style="cursor:pointer; ">전 단계로 돌아가기</a>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>