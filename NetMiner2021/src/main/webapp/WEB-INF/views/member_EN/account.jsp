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
		<script src="js/gnb.js" type="text/javascript"></script>
		<script src="js/main.js" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub account">
			<div id="top">
				<div class="content">
					<div class="wrap">
						<!-- 로그인 후-->
						<div class="mypage obj type2" >
							<p class="me">
								<img src="images/top_me.png" alt="mypage">
							</p>
							<ul>
								<li class="workSpace"><a href="#" class="trs">My Workspace</a></li>
								<li class="account"><a href="#" class="trs">Account</a></li>
								<li class="signOut"><a href="#" class="trs">Sign-Out</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Account</h2>
					</div>
					<div class="content">
						<div>
							<p class="profile">Profile</p>
							<ul class="input">
								<li>
									<input name="email" placeholder="" value="dklsek!@naver.com"  type="text" />
									<button class="authentic trs email">Verify</button>
									<button class="trans trs email active" style="display:none;">Change</button>
								</li>
								<li><input placeholder="" type="password"  value="**"/></li>
								<li><input placeholder="Organization" type="text" /></li>
							</ul>
							<select>
								<option value="" disabled selected hidden>Country</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select>
							<div class="checkBox">
								<p>Acount Type</p>
								<ul>
									<li><label><input type="radio" checked="checked" name="c1"><em></em>Academic</label></li>
									<li ><label><input type="radio" checked="checked" name="c1"><em></em>Commercial</label></li>
								</ul>
							</div>
							<label class="newsLetter"><input id="check" type="checkbox" name=""><em></em><span>I agree to receive informations and commercial offers by e-mail</span></label>
							<div class="update" style="display:none;">
								<button class="cancel trs">Cancel</button>
								<button class="save trs active">Save</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 마케팅 정보 수신 _ 동의  -->
		<div id="agree_popup" class="popup" >
			<div class="wrap">
				<h4>Receive Promotional Information</h4>
				<p>You <span>agree to receive</span> promotional information<br>
and commercial offers about NetMiner 365<br>
by e-mail on <em class="date">(변경 날짜)</em></p>
				
				<button class="close trs">Close</button>
			</div>
		</div>
		
		<!-- 마케팅 정보 수신 _ 거부  -->
		<div id="refuse_popup" class="popup" >
			<div class="wrap">
				<h4>Receive Promotional Information</h4>
				<p>You <span>no longer can receive</span> promotional information<br>
and commercial offers about NetMiner 365<br>
by e-mail since <em class="date">(변경 날짜)</em></p>
				<button class="close trs">Close</button>
			</div>
		</div>
		
		
		
	</body>
</html>