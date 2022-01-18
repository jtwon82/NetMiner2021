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
		
		<script src="https://js.tosspayments.com/v1"></script>
		<script type="text/javascript">
		var Payment=[];
		Payment['tossPayments'] = TossPayments('test_ck_OEP59LybZ8Bdv6A1JxkV6GYo7pRe');
		Payment['amount'] = ${billing.PAY_PRICE};
		Payment['orderId'] = '${billing.ORDER_ID}';
		Payment['orderName'] = '${billing.ORDER_NAME}';
		Payment['customerName'] = '${billing.CUSTOMER_NAME}';
		</script>
</head>
<body>
		<div id="wrap" class="sub subscribe">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Subscribing NetMiner 365</h2>
					</div>
					<div class="content">
						<div class="inner1 inner">
							<p class="title">구독 기간</p>
							<input type="hidden" id="DATE_TYPE" name="DATE_TYPE" value="${billing.DATE_TYPE }"/>
							<ul class="checkBox">
								<li><label><input type="radio" name="sub1" value="month"><em></em>월간 (월 가격 표시)</label></li>
								<li><label><input type="radio" name="sub1" value="year"><em></em>연간 (연 가격 표시)</label><span class="tail obj">Save 20%</span>	</li>
							</ul>
							<script>
							$(document).ready(function() {
								$('input:radio[name=sub1]:input[value="${billing.DATE_TYPE }"]').attr("checked", true);
								$("input[name='sub1']").change(function (){
									var dateType = $("input[name='sub1']:checked").val();
									
									location.href="./goSubscribe?dateType="+dateType;
									
								})
							})
							</script>
						</div>
						<div class="inner2 inner">
							<p class="title">결제 방법</p>
							<ul class="checkBox">
								<li><label><input type="radio" checked="checked" name="sub2" value="CARD"><em></em>신용 / 직불카드</label></li>
								<li><label><input type="radio" name="sub2" value="TRANSFER"><em></em>계좌 이체 / 세금계산서</label></li>
							</ul>
						</div>
						<div class="inner3 inner">
							<p class="title">결제 금액</p>
							<ul>
								<li>
									<p>NetMiner 365 - </p><p>${billing.PAY_CODE}</p>
									<span> &#8361; <em>${billing.PAY_PRICE_VAT}</em></span>
								</li>
								<li>
									<p>부가세</p>
									<span> &#8361; <em>${billing.VAT} </em></span>
								</li>
								<li class="totalCost">
									<p>총 비용</p>
									<span> &#8361; <em>${billing.PAY_PRICE}</em></span>
								</li>
							</ul>
						</div>
						<button class="pay trs">결제</button>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>