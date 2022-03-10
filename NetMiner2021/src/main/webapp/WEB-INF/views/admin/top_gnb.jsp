<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
			<div id="top">
				<button class="navy" onClick="window.open('https://www.netminer365.com/');">웹사이트</button>
				<c:if test="${ADMIN_SESSION.ADMIN_ID!='' }">
				<button><a href="logout">로그아웃</a></button>
				</c:if>
			</div>
			<div id="nav">
				<div class="wrap">
					<h1><a href="/admin/administrator">NetMiner 365</a></h1>
					<div>
						<div class="menu menu1">
							<span class="on">이용자 관리</span>
							<ul class="on">
								<li><a href="administrator">관리자</a></li>
								<li><a href="user">이용자</a></li>
								<li><a href="quit">휴면/탈퇴</a></li>
							</ul>
						</div>
						<div class="menu menu2">
							<span class="on">판매 관리</span>
							<ul class="on">
								<li><a href="order">주문 관리</a></li>
							</ul>
						</div>
						<div class="menu menu3">
							<span class="on">게시판 관리</span>
							<ul class="on">
								<li><a href="email">자동 이메일</a></li>
								<li><a href="faq">FAQ</a></li>
							</ul>
						</div>
						<div class="menu menu4">
							<span class="on">서비스 관리</span>
							<ul class="on">
								<li><a href="check">점검 설정</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
