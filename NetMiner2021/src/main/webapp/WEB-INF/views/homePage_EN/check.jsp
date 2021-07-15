<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<link rel="shortcut icon" type="image/x-icon" href="https://www.netminer365.com/resources/images/favicon.ico" />
		<title>Check | NetMiner 365</title>
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
		<script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub check">
			<div class="checkContainer">
				<h1><img src="resources/images/main_logo2.png" alt="NetMiner365"></h1>
				<p class="txt1"><span>Server Maintenance</span></p>
				<p class="pc">
					We're currently performing system maintenance in order to improve service quality.<br>
					You won't be able to access NetMiner 365 during the maintenance.<br>
					Please be patient if it takes loger than expected.
				</p>
				<p class="mobile">
					We're currently performing system maintenance<br> in order to improve service quality.<br>
					You won't be able to access NetMiner 365 during the maintenance.<br>
					Please be patient if it takes loger than expected.
				</p>
				<div class="box">
					<ul>
						<li><span>Schedule</span><b>${checkData.START_DATE } ~ ${checkData.END_DATE} (UTC)</b></li>
						<li><span>Details</span><b>${checkData.COMMENT_EN}</b></li>
					</ul>
				</div>
				<p class="txt2">
					We apologize for the inconvenience this may cause.<br>
					If you have any question, please feel free to contact us at<br> netminer@cyram.com
				</p>
			</div>
		</div>
	
	</body>
</html>