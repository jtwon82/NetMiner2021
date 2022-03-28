<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
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

</head>
<body>
		<div id="wrap" class="sub billing">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Billing</h2>
					</div>
					<div class="content">
						<c:if test = "${nowPlan == 'none'}" > 
						<!-- 비구매자 -->
						<div class="inner inner1">
							<p class="title">플랜 및 결제</p>
							<div class="current">
								<span>현재 플랜</span>
								<p>아직 NetMiner 365를 시작하지 않으셨나요?</p>
								<a href="./pricing">무료 체험</a>
							</div>
							<c:if test="${billingList != 'none'}">
							<div class="charge">
								<span>결제 내역</span>
								<table>
									<colgroup><col width="*"><col width="25%"><col width="28%"><col width="10%"></colgroup>
									<thead>
										<th>날짜</th>
										<th>플랜</th>
										<th>결제 금액 </th>
										<th></th>
									</thead>
									<tbody>
										<c:forEach var="billingList" items="${billingList}" varStatus="status">
										<c:set var="payPrice" value="${billingList.PAY_PRICE}"/>
										<c:set var="regDate" value="${billingList.REG_DATE}"/>	
											<tr>
												<td><fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd"/></td>
												<td><c:out value="${billingList.PLAN_NAME}"/></td>
												<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${payPrice}"/></td>
												<td><a href="./invoice?no=${billingList.NO}" onclick="window.open(this.href); return false;" ><img src="resources/images/download.png"></a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<p class="tail">*최근 3개월의 결제 내역만 확인할 수 있습니다.</p>
							</div>
							</c:if>
							<c:if test="${billingList == 'none'}" >	
							<div class="charge">
								<span>결제 내역</span>
								<p>최근 3개월 내 결제 내역이 없습니다.</p>
							</div>
							</c:if>
						</div>
						</c:if>
						<!-- 구매자 -->
						<c:if test = "${nowPlan != 'none'}" > 
						<div class="inner inner2" >
							<p class="title">플랜 및 결제</p>
							<div class="current">
								<span>현재 플랜</span>
								
								<c:if test="${nowPlan.PLAN_CODE == '01' && diffDays <= 0}">
								<p>Trial 이 만료되었습니다. 계속 이용하시겠습니까? </p>
								<a href="./pricing">구독하기</a>
								</c:if>
								<c:if test="${nowPlan.PLAN_CODE == '01' && diffDays > 0}">
								<p><em>${nowPlan.PLAN_NAME}</em> <span><fmt:formatDate value='${nowPlan.EXITS_DATE}' pattern="yyyy-MM-dd"/></span>에 만료됩니다. </p>
								<a href="./pricing">구독하기</a>
								</c:if>
								<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays >= 0 && diffDays < 7}">
								<p><em>${nowPlan.PLAN_NAME}</em> <span><fmt:formatDate value='${nowPlan.EXITS_DATE}' pattern="yyyy-MM-dd"/></span>에 만료됩니다. </p>
								<a href="./goSubscribe?payNo=${nowPlan.NO}" >플랜연장</a>
								</c:if>
								
								<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays < 0 && diffDays >= -6}">
								<p>이용 중인 플랜이 만료되었습니다. <br> 계속 이용하시겠습니까?</p>
								<a href="./goSubscribe?payNo=${nowPlan.NO}" >플랜연장</a>
								<a href="./pricing?type='changePlan'">플랜변경</a>
								</c:if>
								
								<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays < -6}">
								<p>현재 이용 중인 플랜이 없습니다. </p>
								<a href="./pricing">구독하기</a>
								</c:if>
								
								<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays >= 7}">
								<p><em>${nowPlan.PLAN_NAME}</em> <span><fmt:formatDate value='${nowPlan.EXITS_DATE}' pattern="yyyy-MM-dd"/></span> 에 만료됩니다. </p>
								<a href="./pricing?type='upgradePlan'">업그레이드</a>
								</c:if>
							</div>
							<c:if test="${billingList != 'none'}">
							<div class="charge">
								<span>결제 내역</span>
								<table>
									<colgroup><col width="*"><col width="25%"><col width="28%"><col width="10%"></colgroup>
									<thead>
										<th>날짜</th>
										<th>플랜</th>
										<th>결제 금액 </th>
										<th></th>
									</thead>
									<tbody>
										<c:forEach var="billingList" items="${billingList}" varStatus="status">
										<c:set var="payPrice" value="${billingList.PAY_PRICE}"/>
										<c:set var="regDate" value="${billingList.REG_DATE}"/>
											<tr>
												<td><fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd"/></td>
												<td><c:out value="${billingList.PLAN_NAME}"/></td>
												<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${payPrice}"/></td>
												<td>
													<a href= "./invoice?no=${billingList.NO}" onclick="window.open(this.href); return false;" >
														<img src="resources/images/download.png" style="display: block; margin: 0 auto;">
													</a>
												</td>
												
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<p class="tail">*최근 3개월의 결제 내역만 확인할 수 있습니다.</p>
							</div>
							</c:if>										
							<c:if test="${billingList == 'none'}" >
								<div class="charge">
									<span>결제 내역</span>
									<p>최근 3개월 내 결제 내역이 없습니다.</p>
								</div>
							</c:if>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>