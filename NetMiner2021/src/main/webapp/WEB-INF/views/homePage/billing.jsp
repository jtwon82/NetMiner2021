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
		<div id="wrap" class="sub billing">
			<%@include file = "../common/top.jsp" %>
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Billing</h2>
					</div>
					<div class="content">
						<!-- 비구매자 -->
						<div class="inner inner1">
							<p class="title">플랜 및 결제</p>
							<div class="current">
								<span>현재 플랜</span>
								<p>아직 NetMiner 365를 시작하지 않으셨나요?</p>
								<a href="#">무료 체험</a>
							</div>
							<div class="charge">
								<span>결제 내역</span>
								<p>최근 3개월 내 결제 내역이 없습니다.</p>
							</div>
						</div>
						<!-- 구매자 -->
						<div class="inner inner2" style="display:none;" >
							<p class="title">플랜 및 결제</p>
							<div class="current">
								<span>현재 플랜</span>
								<p><em>SMALL</em> <span>YYYY 년 MM월 DD일</span>에 만료됩니다. </p>
								<a href="#">플랜 변경</a>
							</div>
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
										<tr>
											<td>YYYY 년 MM월 DD일</td>
											<td>SMALL</td>
											<td>50</td>
											<td><img src="images/download.png"></td>
										</tr>
										<tr>
											<td>YYYY 년 MM월 DD일</td>
											<td>SMALL</td>
											<td>50</td>
											<td><img src="images/download.png"></td>
										</tr>
										<tr>
											<td>YYYY 년 MM월 DD일</td>
											<td>SMALL</td>
											<td>50</td>
											<td><img src="images/download.png"></td>
										</tr>
									</tbody>
								</table>
								<p class="tail">*최근 3개월의 결제 내역만 확인할 수 있습니다.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>