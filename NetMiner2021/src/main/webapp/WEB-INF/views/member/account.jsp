<%@page import="com.netMiner.app.model.vo.MemberVo"%>
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
		<title>Account | NetMiner365</title>
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
		<script src="resources/js/gnb.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="resources/js/event.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>  
		<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
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
							<p class="profile">프로필</p>
							<ul class="input">
								<c:choose>
								<c:when test="${memberVo.googleYn eq 'Y'}">
									<li>
										<input name="email" value="${memberVo.userId}" disabled="disabled" type="text" id="email" /></li>
								</c:when>
								<c:otherwise>
									<li class="email old">
										<input name="email" value="${memberVo.userId}" disabled="disabled" type="text" id="email"/>
										<button class="authentic trs email emailChangeBtn" style="width: 138px; background-color:#203864;right: -150px;">변경</button>
									</li>
									<li class="email new h">
										<input type="text" id="newemail" onkeyup="changeBtnColor()"/>
										<button class="authentic trs email emailVerifyBtn" style="right: -151px; width:138px;" id="emailVerifyBtn" onClick="changeEmail()">이메일 인증</button>
										<button class="authentic trs email emailCancelBtn" style="right: -300px; width:138px; padding:0 20px; background:white; outline : solid 1px #203864; color:gray;">취소</button>
									</li>
								</c:otherwise>
								</c:choose>
								<c:if test="${memberVo.googleYn eq 'N'}">
									<li class="pwd old"><input placeholder="안전한 프로필 수정을 위해 비밀번호를 입력해주세요" type="password" id="pwd" onkeypress="showUpdate()"/>
										<button class="authentic trs email" style="right: -150px;width:138px; background-color:#203864; " onclick="changePwd2BtnChange('${memberVo.userId}');">변경</button>
										<button class="authentic trs email h" style="right: -150px; width:138px; padding:0 20px; background:white; outline : solid 1px #203864; color:gray;" onclick="changePwd2BtnChangeCancel();">취소</button>
									</li>
									
									<li class="pwd new h"><input placeholder="새 비밀번호" type="password" />
									</li>
									<li class="pwd new h"><input placeholder="새 비밀번호" type="password" />
										<button class="authentic trs email" style="right: -150px;width: 138px; background-color:#203864; " onclick="changePwd2BtnChangeAct('${memberVo.userId}');">저장</button>
									</li>
								</c:if>
								<li><input value="${memberVo.company}" type="text" id ="company" onkeyup="showUpdate()"/></li>
							</ul>
							<select id="nation" onchange="showUpdate()">
								<option value="" disabled selected hidden>국가</option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option>
							</select><script>$("select").select2();</script>
							<div class="checkBox">
								<p>이용용도</p>
								<ul>
									<li><label><input type="radio"  name="c1" onchange="showUpdate()" <c:if test="${memberVo.useCode eq '01'}"> checked="checked"</c:if> value="01"><em></em>학술용</label></li>
									<li ><label><input type="radio"  name="c1"  onchange="showUpdate()" <c:if test="${memberVo.useCode eq '02'}"> checked="checked"</c:if> value="02"><em></em>일반/기업용</label></li>
								</ul>
							</div>
							<label class="newsLetter"><input id="check" type="checkbox" onchange="showUpdate()"  name="marketYn" <c:if test="${memberVo.marketYn eq 'Y'}"> checked="checked"</c:if>><em></em>NetMiner 365 에 대한 정보 , 혜택 안내 등을 위한 뉴스레터를 받고 싶습니다.</label>
							<div class="update h" id="update">
								<button class="cancel trs" onClick="clear();">취소</button>
								<button class="save trs active" onClick="updateUserInfo('${memberVo.googleYn}');">저장</button>
							</div>
						</div>
					</div>
					<div class="content leave">
						<div>
							<p>계정삭제</p>
							<p>계정을 삭제하면, 데이터 및 로그는 영원히 삭제됩니다</p>
							<button class="leave trs" id="leaveBtn">계정삭제</button>
						</div>
					</div>
				</div>
			</div>
		<%@include file = "../common/footer.jsp" %>
		</div>
		<!-- 마케팅 정보 수신 _ 동의  -->
		<div id="agree_popup" class="popup" >
			<div class="wrap">
				<h4>마케팅 정보 수신 동의 변경</h4>
				<p><em class="date">${nowDate}</em>에 NetMiner 365 관련 마케팅 정보를 위한<br>
<span>이메일 수신 동의</span>가 처리되었습니다.</p>
				<button class="close trs">닫기</button>
			</div>
		</div>
		
		<!-- 마케팅 정보 수신 _ 거부  -->
		<div id="refuse_popup" class="popup" >
			<div class="wrap">
				<h4>마케팅 정보 수신 동의 변경</h4>
				<p><em  class="date">${nowDate}</em>에 NetMiner 365 관련 마케팅 정보를 위한<br>
<span>이메일 수신 거부</span>가 처리되었습니다.</p>
				<button class="close trs">닫기</button>
			</div>
		</div>
		
				<!-- 탈퇴 팝업  -->
		<div id="leave_popup" class="popup" >
			<div class="wrap">
				<h4>계정을 삭제하시겠습니까?</h4>
				<p>계정을 삭제하면 계정 정보와 데이터 등<br>
				모든 정보가 영구히 삭제되고 복구할 수 없습니다.<br>
				<span>(단, 이용기록 등 일부 정보는 개인정보처리방침에 따라 분리 보관됩니다)</span><br>
				정말 계정을 삭제하시겠습니까? </p>
				<button class="close trs">취소</button>
				<button class="leave trs" onClick="delteUser()">계정삭제</button>
			</div>
		</div>
			<!-- 220118 추가 -->	
		<!-- 탈퇴 불가 팝업  -->
		<div id="leave_hold_popup" class="popup">
			<div class="wrap">
				<img src="resources/images/leave_hold_popup_ico.png">
				<p>현재 이용 중인 플랜이 있습니다.<br>
플랜이 끝나면 계정을 삭제할 수 있습니다. </p>
				<button class="close trs">닫기</button>
			</div>
		</div>
	<!-- 220118 추가 -->	
	</body>
</html>