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
		<link href="resources/css/style.css?st=<%= Math.floor(Math.random() *100)%>" rel="stylesheet" type="text/css"/>
		<link href="resources/css/swiper.min.css" rel="stylesheet" type="text/css"/>
		<script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="resources/js/swiper.min.js" type="text/javascript"></script>
		<script src="resources/js/gnb.js" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<script type="text/javascript">
			function pay(){
				var pagemoveflag = true;
				var date = new Date();
				var url = "https://sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&";
				params = "business=sb-1mesd13290912@business.example.com"
					+"&return="+ URL +"/payment_paypal"
					+"&notify_url="+ URL +"/payment_paypal"
					+"&cancel_return="+ URL +"/"
					+"&quantity=1"
					+"&item_number="+date.getTime()
					+"&amount=<c:out value='${billing.PAY_PRICE}'/>"
					+"&item_name=<c:out value='${billing.PLAN_NAME}'/>"
					+"&no_shipping=1"
					+"&no_note=0"
					+"&currency_code=USD";
				if(pagemoveflag) {
					var path=url + params;
					window.location.href= path;
				}
			}
		</script>
		<div id="wrap" class="sub subscribe">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Subscribing NetMiner 365</h2>
					</div>
					<div class="content">
						<div class="inner1 inner">
							<p class="title">Service Period</p>
							<c:if test="${'upgradePlan' == billing.type}">
							 	<p>Your plan will expire on <fmt:formatDate value="${billing.EXITS_DATE}" pattern="yyyy/ MM/ dd/ "/> </p>
							 	<p>(If you change plans, your subscription will remain)</p>
							 </c:if>
							<input type="hidden" id="DATE_TYPE" name="DATE_TYPE" value="${billing.DATE_TYPE }"/>
							<c:if test="${'upgradePlan' != billing.type}">
								<c:if test="${'year' == billing.DATE_TYPE }">	
									<ul class="checkBox">
										<li><label><input type="radio" name="sub1" value="month"><em></em>Monthly</label></li>
										<li><label><input type="radio" checked="checked" name="sub1" value="year"><em></em>Yearly </label><span class="tail obj">Save 20%</span>	</li>
									</ul>
								</c:if>
								<c:if test="${'year' != billing.DATE_TYPE }">	
									<ul class="checkBox">
										<li><label><input type="radio" checked="checked" name="sub1" value="month"><em></em>Monthly</label></li>
										<li><label><input type="radio" name="sub1" value="year"><em></em>Yearly</label><span class="tail obj">Save 20%</span>	</li>
									</ul>
								</c:if>
							</c:if>
						</div>
						<div class="inner2 inner">
							<p class="title">Payment Method</p>
							<ul class="checkBox">
								<li><label><input type="radio" name="sub2"><em></em>Credit Card (PayPal)</label></li>
								<li><label><input type="radio" checked="checked" name="sub2"><em></em>Bank Transfer</label></li>
							</ul>
						</div>
						<div class="inner3 inner">
							<p class="title">Amount</p>
							<ul>
								<li>
									<p>NetMiner 365 - ${billing.PLAN_NAME}</p>
									<span>$ <em><fmt:formatNumber value='${billing.PAY_PRICE_VAT}' pattern='#,###,###'/></em></span>
								</li>
								<li>
									<p>Tax</p>
									<span>$ <em><fmt:formatNumber value='${billing.VAT}' pattern='#,###,###'/></em></span>
								</li>
								<li class="totalCost">
									<p>Total</p>
									<span>$ <em><fmt:formatNumber value='${billing.PAY_PRICE}' pattern='#,###,###'/></em></span>
								</li>
							</ul>
						</div>
						<button class="pay trs" onClick="pay();" data-payplatform='paypal'>Continue</button>
					</div>
				</div>
			</div>
			<script>
							$(document).ready(function() {
								$('input:radio[name=sub1]:input[value="${billing.DATE_TYPE }"]').attr("checked", true);									
																
								$("input[name='sub1']").change(function (){
									var dateType= $("input[name='sub1']:checked").val();
									location.href="./goSubscribe?dateType="+dateType+"&planCode=${billing.PLAN_CODE }";									
								})
							})
			</script>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	
	</body>
</html>