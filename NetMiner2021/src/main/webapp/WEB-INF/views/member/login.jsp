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
		<link href="css/style.css?st=<?=rand()?>" rel="stylesheet" type="text/css"/>
		<link href="css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="js/swiper.min.js" type="text/javascript"></script>
		<script src="js/gnb.js" type="text/javascript"></script>
		<script src="js/main.js" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub login">
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Welcome to NetMiner 365</h2>
						<p>아직 계정이 없습니까?<a href="#">등록</a></p>
					</div>
					<div class="content">
						<ul class="input">
							<li><input placeholder="이메일" type="text" /></li>
							<li><input placeholder="비밀번호" type="password" /></li>
						</ul>
						<a class="searchPw blue" href="#">비밀번호를 잊으셨나요?</a>
						<button class="login trs">로그인</button>
						<span class="line">또는</span>
						<button class="google trs">Sign in with Google</button>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
</html>