<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<link href="resources/css/style_en.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
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
						<!-- 비구매자 -->
						<c:if test = "${nowPlan == 'none'}" > 
						<div class="inner inner1">
							<p class="title">Plan & Paymnet</p>
							<div class="current">
								<span>Current Plan</span>
								<p>Haven't you started NetMiner 365 yet?</p>
								<a href="./pricing">Try for free</a>
							</div>							
							<c:if test="${billingList != 'none'}">
								<div class="charge">
								<span>Invoice</span>
								<table>
									<colgroup><col width="*"><col width="25%"><col width="28%"><col width="10%"></colgroup>
									<thead>
										<th>Date</th>
										<th>Plan</th>
										<th>Amount</th>
										<th></th>
									</thead>
									<tbody>
										<c:forEach var="billingList" items="${billingList}" varStatus="status">
										<c:set var="payPrice" value="${billingList.PAY_PRICE}"/>
										<c:set var="regDate" value="${billingList.REG_DATE}"/>
											<tr>
												<td><fmt:formatDate value="${regDate}" pattern="MM/dd/yyyy"/></td>
												<td><c:out value="${billingList.PLAN_NAME}"/></td>
												<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${payPrice}"/></td>
												<td><a href="./invoice?no=${billingList.NO}" onclick="window.open(this.href); return false;" ><img src="resources/images/download.png"></a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<p class="tail">* Invoices in the last three months are displayed.</p>
							</div>	
							</c:if>
							<c:if test="${billingList == 'none'}">
							<div class="charge">
								<span>Invoice</span>
								<p>No invoices found in the last three months.</p>
							</div>
							</c:if>
						</div>
						</c:if>
						<!-- 구매자 -->						
							<c:if test = "${nowPlan != 'none'}" >
							<div class="inner inner2" >
								<p class="title">Plan & Paymnet</p>
								<div class="current">
									<span>Current Plan</span>
									
									<c:if test="${nowPlan.PLAN_CODE == '01' && diffDays <= 0}">
									<p>Trial has expired. Would you like to continue? </p>
									<a href="./pricing">Subscribe</a>
									</c:if>
									<c:if test="${nowPlan.PLAN_CODE == '01' && diffDays > 0}">
									<p><em>${nowPlan.PLAN_NAME}</em> <span> Your plan will expire on <fmt:formatDate value='${nowPlan.EXITS_DATE}' pattern="MM/dd/yyyy"/></span></p>
									<a href="./pricing">Subscribe</a>
									</c:if>
									
									<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays >= 0 && diffDays < 7}">
									<p><em>${nowPlan.PLAN_NAME}</em> <span> Your plan will expire on <fmt:formatDate value='${nowPlan.EXITS_DATE}' pattern="MM/dd/yyyy"/></span></p>
									<a href="./goSubscribe?payNo=${nowPlan.NO}" >Renew</a>
									</c:if>
									
									<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays < 0 && diffDays >= -6}">
									<p>Your plan has expired. Continue to use?</p>
									<a href="./goSubscribe?payNo=${nowPlan.NO}" >Renew</a>
									<a href="./pricing?type='changePlan'">Change Plan</a>
									</c:if>
									
									<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays < -6}">
									<p>There are currently no plans in use.</p>
									<a href="./pricing">Subscribe</a>
									</c:if>
									
									<c:if test="${nowPlan.PLAN_CODE != '01' && diffDays >= 7}">
									<p><em>${nowPlan.PLAN_NAME}</em> <span> Your plan will expire on <fmt:formatDate value='${nowPlan.EXITS_DATE}' pattern="MM/dd/yyyy"/></span> </p>
									<a href="./pricing?type='upgradePlan'">Upgrade</a>
									</c:if>
								</div>
							
							<c:if test="${billingList != 'none'}">
								<div class="charge">
								<span>Invoice</span>
								<table>
									<colgroup><col width="*"><col width="25%"><col width="28%"><col width="10%"></colgroup>
									<thead>
										<th>Date</th>
										<th>Plan</th>
										<th>Amount</th>
										<th></th>
									</thead>
									<tbody>
										<c:forEach var="billingList" items="${billingList}" varStatus="status">
										<c:set var="payPrice" value="${billingList.PAY_PRICE}"/>
										<c:set var="regDate" value="${billingList.REG_DATE}"/>
											<tr>
												<td><fmt:formatDate value="${regDate}" pattern="MM/dd/yyyy"/></td>
												<td><c:out value="${billingList.PLAN_NAME}"/></td>
												<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${payPrice}"/></td>
												<td>
													<a href="./invoice?no=${billingList.NO}" onclick="window.open(this.href); return false;" >
														<img src="resources/images/download.png" style="display: block; margin: 0 auto;">
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<p class="tail">* Invoices in the last three months are displayed.</p>
							</div>	
							</c:if>
							<c:if test="${billingList == 'none'}">
							<div class="charge">
								<span>Invoice</span>
								<p>No invoices found in the last three months.</p>
							</div>
							</c:if>
						</div>
						</c:if>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	
	</body>
</html>