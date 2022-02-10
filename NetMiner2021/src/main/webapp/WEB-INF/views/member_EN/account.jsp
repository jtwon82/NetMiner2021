<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
		<title>Account | NetMiner 365</title>
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
		<div id = "dimmed" style="position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100; opacity: 0.5; background-color: rgb(0, 0, 0); display: none;" ></div>
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
								<c:choose>
								<c:when test="${memberVo.googleYn eq 'Y'}">
									<li>
										<input name="email" value="${memberVo.userId}" disabled="disabled" type="text" id="email" /></li>
								</c:when>
								<c:otherwise>
									<li class="email old">
										<input name="email" value="${memberVo.userId}" disabled="disabled" type="text" id="email"/>
										<button class="authentic trs email emailChangeBtn" style="width: 138px; background-color:#203864;right: -150px;">Change</button>
									</li>
									<li class="email new h">
										<input type="text" id="newemail" onkeyup="changeBtnColor()"/>
										<button class="authentic trs email emailVerifyBtn" style="right: -150px; width:138px;" id="emailVerifyBtn" onClick="changeEmail()">Verify</button>
										<button class="authentic trs email emailCancelBtn" style="right: -300px; width:138px; padding:0 20px; background:white; outline : solid 1px #203864; color:gray; ">Cancel</button>
									</li>
								</c:otherwise>
								</c:choose>
								<c:if test="${memberVo.googleYn eq 'N'}">
									<li class="pwd old"><input placeholder="Please enter your password in order to save changes." type="password" id="pwd" onkeypress="showUpdate()"/>
										<button class="authentic trs email" style="right: -150px; width:138px; background-color:#203864;" onclick="changePwd2BtnChange('${memberVo.userId}');">Change</button>
										<button class="authentic trs email h" style="right: -150px; width:138px; padding:0 20px; background:white; outline : solid 1px #203864; color:gray;" onclick="changePwd2BtnChangeCancel();">Cancel</button>
									</li>
									
									<li class="pwd new h"><input placeholder="New Password" type="password" />
									</li>
									<li class="pwd new h"><input placeholder="New Password" type="password" />
										<button class="authentic trs email" style="right: -150px;width: 138px;" onclick="changePwd2BtnChangeAct('${memberVo.userId}');">Save</button>
									</li>
								</c:if>
								<li><input value="${memberVo.company}" type="text"  id ="company" onkeyup="showUpdate()" placeholder="Organization"/></li>
							</ul>
							<select id="nation" onchange="showUpdate()">
								<option value="" disabled selected hidden>Country</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select><script>$("select").select2();</script>
							<div class="checkBox">
								<p>Account Type</p>
								<ul>
									<li><label><input type="radio" name="c1" onchange="showUpdate()" <c:if test="${memberVo.useCode eq '01'}"> checked="checked"</c:if> value="01"><em></em>Academic</label></li>
									<li ><label><input type="radio" name="c1"  onchange="showUpdate()" <c:if test="${memberVo.useCode eq '02'}"> checked="checked"</c:if> value="02"><em></em>Commercial</label></li>
								</ul>
							</div>
							<label class="newsLetter"><input id="check" type="checkbox" onchange="showUpdate()" name="marketYn" <c:if test="${memberVo.marketYn eq 'Y'}"> checked="checked"</c:if>><em></em><span>I agree to receive informations and commercial offers by e-mail</span></label>
							<div class="update h"  id="update">
								<button class="cancel trs" onClick="clear();">Cancel</button>
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
by e-mail on <em class="date">${nowDate}</em></p>
				
				<button class="close trs">Close</button>
			</div>
		</div>
		
		<!-- 마케팅 정보 수신 _ 거부  -->
		<div id="refuse_popup" class="popup" >
			<div class="wrap">
				<h4>Receive Promotional Information</h4>
				<p>You <span>no longer can receive</span> promotional information<br>
and commercial offers about NetMiner 365<br>
by e-mail since <em class="date">${nowDate}</em></p>
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
		<!-- 220118 추가 -->	
		<!-- 탈퇴 불가 팝업  -->
		<div id="leave_hold_popup" class="popup">
			<div class="wrap">
				<img src="resources/images/leave_hold_popup_ico.png">
				<p>You can't delete your account<br>
					until your plan expires.</p>
				<button class="close trs">Close</button>
			</div>
		</div>
	
	</body>
</html>