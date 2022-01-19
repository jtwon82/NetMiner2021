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
</head>
	<body>
		<div id="wrap" class="sub order">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Thank you for your order</h2>
						<p>입금기한 내에 아래 가상계좌로 입금해 주시면<br>
						<span>${billing.PAY_NAME}</span>을 바로 이용하실 수 있습니다.</p>
					</div>
					<div class="content">
						<ul>
							<li>
								<span>결제금액</span>
								<p>${billing.PAY_PRICE}</p>
							</li>
							<li>
								<span>입금은행</span>
								<p>우리은행</p>
							</li>
							<li>
								<span>계좌번호</span>
								<p>000-000000-00000</p>
							</li>
							<li>
								<span>예금주</span>
								<p>(주)사이람</p>
							</li>
							<li>
								<span>입금기한</span>
								<p><em>YYYY-MM-DD HH:MM</em> 까지</p>
							</li>
							<a class="back" href="./pricing">주문 페이지로 돌아가기 </a>
						</ul>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>