<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<div id="wrap" class="sub register_sns">
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Register for NetMiner 365</h2>
						<p>이미 계정을 가지고 있습니까? <a href="#">로그인</a></p>
					</div>
					<div class="content">
						<div>
							<ul class="input">
								<li><input placeholder="이메일" type="text" disabled="disabled"></li>
								<li><input placeholder="소속기관" type="text"></li>
							</ul>
							<select>
								<option value="" disabled selected hidden>국가</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select>
							<div class="checkBox">
								<p>이용용도</p>
								<ul>
									<li><label><input type="radio" checked="checked" name="c1"><em></em>학술용</label></li>
									<li ><label><input type="radio" checked="checked" name="c1"><em></em>일반/기업용</label></li>
								</ul>
							</div>
							<div class="agree">
								<label><input id="check_all" type="checkbox" name=""><em></em>모두 동의합니다.</label>
								<label><input id="check1" class="check" type="checkbox" name=""><em></em>만 16 세 이상입니다 <span>(필수)</span></label>
								<label><input id="check2" class="check" type="checkbox" name=""><em></em><a href="#" class="blue">이용약관</a>과 <a href="#" class="blue">개인정보처리방침</a> 에 동의합니다 <span>(필수)</span></label>
								<label><input id="check2" class="check" type="checkbox" name=""><em></em>유용한 정보 , 혜택 안내 등을 위한 이메일 수신에 동의합니다 <span>(필수)</span></label>
							</div>
							<button class="create trs">계정생성</button>
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