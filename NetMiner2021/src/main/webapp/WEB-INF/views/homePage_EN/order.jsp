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
		<div id="wrap" class="sub order">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Thank you for your order</h2>
						<p class="pc">Please make a bank transfer to CYRAM Inc. for <span>${billing.PLAN_NAME}</span><br>An international bank transfer would take around 1 to 3 working days.</p>
						<p class="mobile">Please make a bank transfer to CYRAM Inc. for <span>${billing.PLAN_NAME}</span><br>An international bank transfer would take around<br>1 to 3 working days.</p>
					</div>
					<div class="content">
						<ul>
							<li>
								<span>Amount</span>
								<p>&#36;  ${billing.PAY_PRICE}</p>
							</li>
							<li>
								<span>Bank Name</span>
								<p>WOORI BANK</p>
							</li>
							<li>
								<span>Account Number</span>
								<p>570-276494-13-005</p>
							</li>
							<li>
								<span>SWIFT Code</span>
								<p>HVBKKRSEXXX</p>
							</li>
							<li>
								<span>Payee Name</span>
								<p>Cyram Inc.</p>
							</li>
							<a class="back" href="./pricing">Back to Order </a>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common_EN/footer.jsp" %>
		</div>
	
	</body>
</html>