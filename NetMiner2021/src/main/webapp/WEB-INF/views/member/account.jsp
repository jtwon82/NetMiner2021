<%@page import="com.netMiner.app.model.vo.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
MemberVo vo = (MemberVo) session.getAttribute("memberVo");
%>
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
		<script src="resources/js/event.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>  
	</head>
	<body>
		<div id="wrap" class="sub account">
			<div id="top">
				<div class="content">
					<div class="wrap">
						<!-- 로그인 후-->
						<div class="mypage obj type2" >
							<p class="me">
								<img src="resources/images/top_me.png" alt="mypage">
							</p>
							<ul>
								<li class="workSpace active"><a href="#" class="trs">My Workspace</a></li> 
								<li class="account"><a href="./account" class="trs">Account</a></li>
								<li class="signOut"><a href="./logOut" class="trs">Sign-Out</a></li>
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
							<p class="profile">프로필</p>
							<ul class="input">
								<li>
									<input name="email" placeholder="${vo.getUserId()}" value="${vo.getUserId()}" type="text" disabled="disabled" />
									<button class="authentic trs email" >이메일 인증</button>
									<button class="trans trs email active" style="display:none;">변경</button>
								</li>
								<li><input placeholder="비밀번호" type="password" /></li>
								<li><input placeholder="소속기관" type="text" /></li>
							</ul>
							<select id="nation">
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
							<label class="newsLetter"><input id="check" type="checkbox" name=""><em></em>NetMiner 365 에 대한 정보 , 혜택 안내 등을 위한 뉴스레터를 받고 싶습니다.</label>
							<div class="update" style="display:none;">
								<button class="cancel trs">취소</button>
								<button class="save trs active">저장</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 마케팅 정보 수신 _ 동의  -->
		<div id="agree_popup" class="popup" >
			<div class="wrap">
				<h4>마케팅 정보 수신 동의 변경</h4>
				<p><em class="date">2021년 6월 12일</em>에 NetMiner 365 관련 마케팅 정보를 위한<br>
<span>이메일 수신 동의</span>가 처리되었습니다.</p>
				<button class="close trs">닫기</button>
			</div>
		</div>
		
		<!-- 마케팅 정보 수신 _ 거부  -->
		<div id="refuse_popup" class="popup" >
			<div class="wrap">
				<h4>마케팅 정보 수신 동의 변경</h4>
				<p><em  class="date">2021년 6월 12일</em>에 NetMiner 365 관련 마케팅 정보를 위한<br>
<span>이메일 수신 거부</span>가 처리되었습니다.</p>
				<button class="close trs">닫기</button>
			</div>
		</div>
		
		
		
	</body>
</html>