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
		<div id="wrap" class="sub authentic">
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>You're almost there..</h2>
					</div>
					<div class="content">
						<p>We've sent a 7 digit code to <span>(입력한 이메일 주소)</span><br>
This code will be valid for 30 minites.</p>
						<div class="input">
							<p>Verification Code</p>
							<input placeholder="" type="text" />
							<p class="sum">Can't find your code? Check your spam folder.<br>Or  <a href="#" class="blue">Resend Code</a></p>
						</div>
						<div class="agree">
								<label><input id="check_all" type="checkbox" name=""><em></em>Agree to all</label>
								<label><input id="check1" class="check" type="checkbox" name=""><em></em><span class="text">I agree to the <a href="#" class="blue">terms and conditions</a> and the <a href="#" class="blue">privacy policy</a> <span class="silver">(required)</span></span></label>
								<label><input id="check2" class="check" type="checkbox" name=""><em></em><span class="text">I confirm that I'm 16 years or older <span class="silver">(required)</span></span></label>
								<label><input id="check2" class="check" type="checkbox" name=""><em></em><span class="text">I agree to receive informations and commercial offers by email <span class="silver">(option)</span></span></label>
							</div>
						<button class="create trs active">Create Account</button>
						<a class="back" href="#" >Back to Register</a>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
</html>