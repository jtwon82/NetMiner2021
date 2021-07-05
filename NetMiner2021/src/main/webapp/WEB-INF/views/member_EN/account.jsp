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
		<link href="/resources/css/style_en.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
		<link href="/resources/css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="/resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="/resources/js/swiper.min.js" type="text/javascript"></script>
		<script src="/resources/js/gnb.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="/resources/js/main_EN.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="/resources/js/event_EN.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub account">
			<%@include file = "../common/top.jsp" %>
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
									<c:if test="${empty userId}">
									<input name="email" value="${memberVo.userId}" type="text" id="email"/>
									<c:if test="${memberVo.googleYn eq 'N'}">
									<button class="authentic trs email" onClick="changeEmail('${memberVo.userId}')" id="checkEmailBtn" disabled="false">Verify</button>
									</c:if>
									</c:if>
									<c:if test="${!empty userId}">
									<input name="email" value="${userId}" type="text" id="email"/>
									<button class="trans trs email active"  onClick="chageUserId();">Change</button>
									</c:if>
								</li>
								<c:if test="${memberVo.googleYn eq 'N'}">
								<li><input placeholder="" type="password" id ="pwd" onchange="showUpdate()"/></li>
								</c:if>
								<li><input placeholder="Organization" type="text" value="${memberVo.company}"  id ="company" onchange="showUpdate()"/></li>
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
									<li><label><input type="radio" checked="checked" name="c1" <c:if test="${memberVo.useCode eq '01'}"> checked="checked"</c:if> value="01"><em></em>Academic</label></li>
									<li ><label><input type="radio" checked="checked" name="c1" <c:if test="${memberVo.useCode eq '02'}"> checked="checked"</c:if> value="01"><em></em>Commercial</label></li>
								</ul>
							</div>
							<label class="newsLetter"><input id="check" type="checkbox" name="marketYn" <c:if test="${memberVo.marketYn eq 'Y'}"> checked="checked"</c:if>><em></em><span>I agree to receive informations and commercial offers by e-mail</span></label>
							<div class="update" style="display:none;">
								<button class="cancel trs">Cancel</button>
								<button class="save trs active" onClick="updateUserInfo('${memberVo.googleYn}');">Save</button>
							</div>
						</div>
					</div>
					<div class="content leave">
						<div>
							<p>Delete account</p>
							<p>Once you delete your account, your information, logs, and data will be gone.</p>
							<button class="leave trs"  id="leaveBtn">Delete account</button>
						</div>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/memberFooter.jsp" %>
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
		
		<!-- 탈퇴 팝업  -->
		<div id="leave_popup" class="popup" >
			<div class="wrap">
				<h4>Permanently delete your account?</h4>
				<p>We have now permanently deleted your account and your data.<br>
					This action can't be undone.<br>
					<span>(Some information can be stored seperately according to Privacy Policy)</span><br>
					Are you sure you want to delete your account?
				</p>
				<button class="close trs">Cancle</button>
				<button class="leave trs" onClick="delteUser()">Delete</button>
			</div>
		</div>
		
	</body>
</html>