<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
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
		<link href="css/style_en.css?st=<?=rand()?>" rel="stylesheet" type="text/css"/>
		<link href="css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="js/swiper.min.js" type="text/javascript"></script>
		<script src="js/main.js" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub searchPw">
			<div id="section">
				<div class="wrap">
					<!-- step1 비밀번호 재설정 요청 -->
					<div class="step1">
						<div class="title">
							<h2>Do you forgot your password?</h2>
							<p>Reset your password</p>
						</div>
						<div class="content">
							<p>Enter the email address and click 'Request password reset'.</p>
							<div class="input">
								<p>E-mail</p>
								<input placeholder="" type="text" />
								<p class="sum">Please check your mailbox. This email will be valid for 30 minutes.<br>
	Can't find your email? Check your spam folder..</p>
							</div>
							<button class="requestPw trs active">Request password reset</button>
							<a class="back" href="#" >Back to Sign-in</a>
						</div>
					</div>
					
					<!-- step2 비밀번호 재설정 -->
					<div class="step2" style="display:none;">
						<div class="title">
							<h2>Reset you password</h2>
							<p>Reset your password</p>
						</div>
						<div class="content">
							<p>Enter the email address and click 'Request password reset'.</p>
							<div class="input">
								<ul>
									<li>
										<p>New password</p>
										<input placeholder="" type="password" />
									</li>
									<li>
										<p>Confirm password</p>
										<input placeholder="" type="password" />
									</li>
								</ul>
							</div>
							<button class="changePw trs active">Reset password and sign-in</button>
							<a class="back" href="#" >Back to Sign-in </a>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
</html>