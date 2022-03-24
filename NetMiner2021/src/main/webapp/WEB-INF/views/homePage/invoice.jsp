<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
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
	</head>
	<body>
		<style>
			@import url(https://fonts.googleapis.com/earlyaccess/notosanskr.css);
			body{background-color:#f4f4f4; height: 100%; font-size: 20px; font-weight: 400; color:#090909; font-family: 'Noto Sans KR', sans-serif; letter-spacing:-1px; text-align: left; word-break: break-all; }
			html {height: 100%; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%;}
			body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, form, fieldset, p, button, input { margin: 0;padding: 0}
			ul, ol, dl {list-style: none}
			ul {list-style: none; padding: 0; margin: 0}
			img, fieldset, iframe {border: 0}
			img {vertical-align:top}
			input, select, button {font-family: 'Noto Sans KR', sans-serif; vertical-align: middle;}
			input {-moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; border-radius: 0;}
			textarea:focus, input:focus{outline: none;}
			textarea{font-family: 'Noto Sans KR', sans-serif; -webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;}
			button, input{position: relative; border:none;}
			button{cursor:pointer; outline: none; border:none;}
			em, address {font-style: normal}
			a {text-decoration: none; color: inherit; display: block; position: relative;}
			.clear {clear: both;}
			input[type=number]::-webkit-inner-spin-button, 
			input[type=number]::-webkit-outer-spin-button {-webkit-appearance: none; margin: 0; }
			*{-webkit-tap-highlight-color:transparent}
			img.map, map area{outline: none;}
			
			img, canvas {
			-webkit-user-select: none;
			-khtml-user-select: none;
			-moz-user-select: none;
			-o-user-select: none;
			user-select: none;
			}
			img::-moz-selection { background-color: transparent; color: #000;}
			img::selection {background-color: transparent; color: #000;}
	
			.relative{position: relative;}
			.blind {font:0/0 a; height: 0; overflow: hidden; position: absolute; width: 0;}
			.btn{position: absolute; z-index: 2; cursor:pointer;}
			.pc{display: block;}
			.mobile{display: none }
			.obj{position: absolute; z-index: 99;}
			.trs{-webkit-transition: all .4s ease-out; -moz-transition: all .4s ease-out; -ms-transition: all .4s ease-out; -o-transition: all .4s ease-out; transition: all .4s ease-out;}
			.tCenter{text-align: center;}
			.tLeft{text-align: left;}
			.tRight{text-align: right;}
			select { border:0;  -webkit-appearance:none;-moz-appearance:none; appearance:none;}
			select::-ms-expand{display:none;/*for IE10,11*/}
	
			#wrap{min-width:1200px; position:relative; }
			#wrap .wrap{min-width: 1200px; margin: 0px auto; position: relative;}
			#wrap .section{margin: 0 auto; background-repeat: no-repeat; background-position-x: center; position: relative; }
			#wrap .section .wrap{padding:140px 0 150px; max-width: 1200px; text-align: center;}
			#wrap .section .wrap>h3{font-size:38px; font-weight:700;}
			#wrap .section .wrap>p{font-size:22px; padding-top: 40px; letter-spacing: -1.5px; }
			#wrap .section .wrap .more{font-size:22px; color:#1551c3; position: absolute; right: 0; padding: 10px; bottom: 70px;}
			#wrap .section .wrap .content{padding-top:110px;}
			
			#wrap #top{position: absolute; width: 100%;  transition: all 0.3s; border-bottom:1px solid #d7d7d7; z-index: 9999;}
			#wrap #top h1{margin-top:-14px;}
			#wrap #top h1 .logo2{display: none;}
			#wrap #top.sticky h1 .logo1{display: none;}
			#wrap #top.sticky h1 .logo2{display: block;}
			#wrap #top .price{color:#fff;font-size:22px;font-weight:500;left: 555px;}
			
			#wrap.sub #top h1 .logo1{display: none;}
			#wrap.sub #top h1 .logo2{display: block;}
			#wrap.sub #top.sticky h1 .logo1{display: none;}
			#wrap.sub #top.sticky h1 .logo2{display: block;}
			
			
			#wrap #top .menu{left:320px;}
			#wrap #top .menu span{font-size:22px; color:#fff; cursor: pointer;}
			#wrap #top .menu span.active::after{ -webkit-transform: rotate(180deg); -moz-transform: rotate(180deg); -ms-transform: rotate(180deg); -o-transform: rotate(180deg); transform: rotate(180deg);}
			#wrap #top .menu span::after{content:""; width:11px; height:7px; display:inline-block; background:url(resources/images/top_arrow.png); vertical-align: 5px; margin-left: 10px;}
			#wrap #top .menu li{font-size:18px; color:#090909;}
			#wrap #top .menu li:hover{color:#3462c7;}
			#wrap #top .menu li.active{font-weight:700;}
			#wrap #top .menu li a{padding: 5px;}
			#wrap #top .menu ul{display:none; margin-top: 15px; border-radius: 10px; padding: 20px;background-color: #fff; box-shadow: 0px 0px 11px #424242;}
			#wrap #top .me{ float: right; cursor:pointer;}
			#wrap #top .content{height:98px; position: relative; padding: 27px 90px 0; box-sizing: border-box;}
			#wrap #top .content .mypage.type1{right:0;}
			#wrap #top .content .mypage.type1 li{display: inline-block; color:#fff; font-size:20px; }
			#wrap #top .content .mypage.type1 li.join{border:1px solid #fff; width:148px; text-align:center; line-height:42px;  height:42px; }
			#wrap #top .content .mypage.type1 li.join a{width:100%; height:100%;} 
			#wrap #top .content .mypage.type1 li.login a{padding:5px 5px 5px 20px; color:#fff; }
			#wrap #top .content .mypage.type2{right:0; top: -5px;}
			#wrap #top .content .mypage.type2 ul{display:none; margin-top: 63px; border-radius: 10px; padding:20px; background-color:#fff; box-shadow: 0px 0px 11px #424242;}
			#wrap #top .content .mypage.type2 li{font-size:18px;}
			#wrap #top .content .mypage.type2 li.active a{color:#d10000;}
			#wrap #top .content .mypage.type2 li.active:first-child::after{color:#d10000;}
			#wrap #top .content .mypage.type2 li a{padding:5px;}
			#wrap #top .content .mypage.type2 li:first-child a{display:inline-block;}
			#wrap #top .content .mypage.type2 li:first-child::after{content:"↗"; display: inline-block;}
			#wrap #top.sticky { position: fixed; top: 0; background-color:#fff; z-index:9999;}
			#wrap #top.sticky .menu li:hover{color:#3462c7;}
			#wrap #top.sticky .menu span{color:#090909;}
			#wrap #top.sticky .content .mypage.type1 li.join{background-color:#203864;}
			#wrap #top.sticky .content .mypage.type1 li.login a{color:#090909;}
			#wrap #top.sticky .menu span::after{background:url(resources/images/top_arrow2.png); }
			#wrap #top.sticky .menu ul{box-shadow:none; border-radius:0; margin-top: 39px;}
			#wrap #top.sticky .price{color:#090909;}
			#wrap #top.sticky .menu{}
			#wrap #top.sticky .menu ul::before{width:100px; height:4px; background:#3462c7; display:block; content:""; position: absolute; left: calc(50% - 50px); top: 26%;}
			#wrap #top.sticky .content{padding: 27px 90px 0;}
			
			#wrap #footer .wrap{max-width: 100%; padding: 0;}
			#wrap #footer .wrap .content{background-color:#282828; }
			#wrap #footer .wrap .content>div{height: 300px; padding-top: 45px; box-sizing: border-box;}
			#wrap #footer .wrap .content>div{position: relative; color:#fff; max-width:1200px; margin: 0 auto; text-align: center;}
			#wrap #footer{background-color:#7c7c7c;}
			#wrap #footer .terms{left: -2.4%;}
			#wrap #footer .terms li{font-size: 22px; display:inline-block; position:relative;}
			#wrap #footer .terms li:first-child::after{content:"";width: 1px; height: 20px;background-color: #fff;  display: inline-block;  position: absolute;right: -3px; top: 20px;}
			#wrap #footer .terms li a{padding: 12px 30px;}
			#wrap #footer .sns{right:-1%;}
			#wrap #footer .sns li{display:inline-block;}
			#wrap #footer .sns li a{padding: 12px;}
			#wrap #footer .lang{text-align: left; cursor: pointer;width: 175px;border: 1px solid #fff; left: 42%;}
			#wrap #footer .lang p{height: 56px;line-height: 56px;  position: relative; padding-left: 15px;}
			#wrap #footer .lang p span{background: url(resources/images/footer_arrow.png); width:11px; height:7px; display:inline-block; position:absolute;right: 7%;top: 43%;}
			#wrap #footer .lang ul{display:none;}
			#wrap #footer .lang.active ul{display:block;}
			#wrap #footer .lang.active p span{ -webkit-transform: rotate(180deg); -moz-transform: rotate(180deg); -ms-transform: rotate(180deg); -o-transform: rotate(180deg); transform: rotate(180deg);}
			#wrap #footer .lang li{height: 56px;line-height: 56px; background:#fff; color:#282828; padding-left: 15px;}
			#wrap #footer .lang li:hover{color:#d10000;}
			#wrap #footer .family{text-align: left; cursor: pointer;width: 175px;border: 1px solid #fff; left: 61%; }
			#wrap #footer .family p{height: 56px;line-height: 56px;  position: relative; padding-left: 15px;}
			#wrap #footer .family p span{background: url(resources/images/footer_arrow.png); width:11px; height:7px; display:inline-block; position:absolute;right: 7%;top: 43%;}
			#wrap #footer .family ul{display:none; }
			#wrap #footer .family.active ul{display:block;}
			#wrap #footer .family.active p span{ -webkit-transform: rotate(180deg); -moz-transform: rotate(180deg); -ms-transform: rotate(180deg); -o-transform: rotate(180deg); transform: rotate(180deg);}
			#wrap #footer .family li{height: 56px;line-height: 56px; background:#fff; color:#282828; padding-left: 15px;}
			#wrap #footer .family li:hover{color:#d10000;}
			#wrap #footer .cr{top: 45%; color:#9b9b9b; font-size:18px;}
	
			#wrap.sub{background: url(resources/images/sub_bg.jpg); color: #090909; font-size:20px; background-size: cover; background-position: center;}
			#wrap.sub #section .wrap{padding-top: 200px; padding-bottom: 200px;}
			#wrap.sub .title{text-align: center; padding-bottom: 50px; }
			#wrap.sub .title h2{font-size:38px; font-weight:700;}
			#wrap.sub .title p{font-size:22px;margin-top: 15px; }
			#wrap.sub .title p a{color:#114fbf; display:inline-block; padding-left:22px; }
			#wrap.sub input{border:1px solid #9d9d9d; font-size:20px; color:#606060;}
			#wrap.sub select{font-size:20px; color:#606060; border:1px solid #9d9d9d;  background:url("resources/images/select_arrow.png") no-repeat 98% 50%/15px auto;}
			#wrap.sub .blue{color:#114fbf; font-size:18px; }
			#wrap.sub #top .menu{display:none;}
			#wrap.sub #top .price{display:none;}
			#wrap.sub #top .content .mypage.type1 li.join{background-color:#203864;}
			#wrap.sub #top .content .mypage.type1 li.login a{color:#090909;}
			#wrap.invoice{}
			#wrap.invoice .title h2 span{color:#606060; margin-left:20px;}
			#wrap.invoice #section .content{background-color:#fff;width: 720px;margin: 0 auto;padding:50px 90px;box-sizing: border-box;}
			#wrap.invoice #section .content .inner{ margin-bottom: 50px; border-bottom: 1px solid #878787;}
			#wrap.invoice #section .content .inner .title{margin-bottom: 20px; font-size:24px;font-weight:600;padding-bottom: 10px;text-align: left; border-bottom:2px solid #878787;}
			#wrap.invoice #section .content .inner3 .title{border-bottom:none; display:inline-block; margin-bottom: 0; padding-bottom: 0;}
			#wrap.invoice #section .content .inner3{border-bottom:none;}
			#wrap.invoice #section .content .inner3 span{color:#606060; margin-left: 45px;}
			#wrap.invoice #section .content .inner ul li{color:#606060;margin-bottom: 15px;}
			#wrap.invoice #section .content .inner ul li p{ display: inline-block; width: 180px;}
			#wrap.invoice #section .content .inner ul li span em{}
			#wrap.invoice #section .content .inner ul li.totalCost{border-top:1px solid #878787; padding-top: 15px;}
			
			@media (min-width: 0px) and (max-width: 1000px){
				.pc{display: none}
			    .mobile{display: block;}     
			    img{width:100%; height:auto;}
			    #wrap{min-width:auto; }
			    #wrap .wrap{width:90% !important; min-width: auto;}
			    #wrap #section .content{width:auto !important;}
			    
			    #navBtn{right:-15px; width: 25px;}
			    #wrap #navOn{width:100%; height:100%; top:0%; left:0%; z-index:300; position: fixed; display:none; }
			    #wrap #navOn .bg{background-color: #000000; opacity:0.6; width:100%; height:100%; top:0px; left:0px; display:block; content: ""; position: absolute;}
			    #wrap #navOn #nav{width:180px; height:100%; top:0px; right:0px; background-color: #fff; z-index: 2; overflow-y: auto;}
			    #wrap #navOn #nav .navClose{width:40px; top: 5px; right:5px;}
			    #wrap #navOn #nav .container{padding:20px 0px;}
			    #wrap #navOn #nav .menu li{border-top:1px solid #d8d7d7;font-size:14px; padding:10px 20px;  }
			    #wrap #navOn #nav .menu li.active{color: #3462c7;}
			     #wrap #navOn #nav .menu li:last-child{border-bottom:1px solid #d8d7d7;}
			    #wrap #navOn #nav .menu li a{width: auto;}
			    #wrap #navOn #nav .menu li a:active{color:#06a8e7;}
			    #wrap #top{position: fixed;width: 100%;}
			    #wrap #top h1{width: 140px; margin-top:-8px; margin-left:-10px;}
			    #wrap #top h1 .logo1{display: none;}
			    #wrap #top h1 .logo2{display: block;}
			    #wrap #top .content::before{background-color: #fff;  width:100%; height:100%; top:0px; left:0px; display:block; content: ""; position: absolute; z-index: 10;}
			    #wrap #top .content #navOn .mypage.type1 li{border: none; line-height: 1; width: auto; height: auto;position:relative; }
			    #wrap #top .content #navOn .mypage.type1 li:first-child::after{content:""; width:1px; height:12px; display:inline-block; background:#090909;     position: absolute; right: -8px; top: 13px;}
			    #wrap #top .content #navOn .mypage.type1 li a{color: #090909;font-size: 15px; padding: 10px;}
			    #wrap #top .content .mypage.type1{padding-top:50px;}
			    #wrap #top #navOn .menu{margin-top: 18px;}
			    #wrap #top .content .mypage.type2{padding-top: 50px;}
			    #wrap #top .content{padding:15px 10px 0; height: 50px;}
			    #wrap #top .me{width:40px; float: none; margin: 0 auto;}
			    #wrap #top .content #navOn .mypage.type1 li.join a{color:#203864; font-weight: 700;}
			    #wrap #top .content .mypage.type2 ul{display:block; margin-top: 10px; padding:0px; background:none; box-shadow:none; text-align: center;}
			    #wrap #top .content .mypage.type2 li{font-size: 13px;}
			    
			    
			    #wrap #main  .wrap{width: 100% !important;}
			    #wrap #main .slider .text{padding: 75px 20px 40px !important;}
			    #wrap #main .slider .text h2{font-size: 20px;}
			    #wrap #main .slider .text p{font-size: 15px;  padding-top: 20px;}
			    
			    #wrap #footer .wrap{width: 100% !important;}
			    #wrap #footer .wrap .content>div{padding:20px 0; height: auto;}
			    #wrap #footer .wrap .content>div>*{position:static; vertical-align: top; margin-bottom: 10px;}
			    #wrap #footer .terms{left: -5px;}
			    #wrap #footer .terms li{font-size: 15px;}
			    #wrap #footer .terms li a{padding: 5px;}
			    #wrap #footer .terms li:first-child::after{top: 9px; height: 15px;}
			    #wrap #footer .lang{font-size: 15px; width: 120px;display:inline-block;}
			    #wrap #footer .lang p{height: 35px;line-height: 35px; padding-left: 7px;}
			    #wrap #footer .lang li{height: 35px;line-height: 35px; padding-left: 7px;}
			    #wrap #footer .lang.active ul{position:absolute; width: 122px;z-index: 10;}
			    #wrap #footer .family{font-size: 15px; width: 120px; display:inline-block;}
			    #wrap #footer .family p{height: 35px;line-height: 35px; padding-left: 7px;}
			    #wrap #footer .family li{height: 35px;line-height: 35px; padding-left: 7px;}
			    #wrap #footer .family ul{position:absolute; width: 122px;z-index: 10;}
			    #wrap #footer .sns{}
			    #wrap #footer .sns li{width: 35px;height: 25px; padding: 5px;}
			    #wrap #footer .sns li a{ width: 100%;height: 100%; padding:0;}
			    #wrap #footer .sns li img{height:100%; width: auto;}
			    #wrap #footer .cr{ font-size: 15px;}
	    
				#wrap.sub .title h2{font-size: 22px;}
			    #wrap.sub .title p{font-size: 15px;}
			    #wrap.sub .title p a{padding-left: 10px;}
			    #wrap.sub input{font-size: 14px;}
			    #wrap.sub .blue{font-size: 13px;}
			    #wrap.sub #section .wrap{padding-top: 90px; padding-bottom: 100px;}
			    #wrap.sub{font-size: 14px;}
			    #wrap.sub select{background: url(resources/images/select_arrow.png) no-repeat 98% 50%/12px auto;}
			    #wrap.sub #top{background-color: #fff;}
			    #wrap.sub #top .content .mypage.type1 li.join{background-color: transparent;}
			    
			    #wrap.invoice #section .content{padding:20px;} 
			    #wrap.invoice #section .content .inner .title{font-size: 17px;}
			    #wrap.invoice #section .content .inner{margin-bottom:30px;}
			    #wrap.invoice #section .content .inner ul li p{width: 33%;}
			    #wrap.invoice #section .content .inner3 span{margin-left:5px;}
			}
			
		</style>

		<div id="wrap" class="sub invoice">
				
			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>Invoice<span>#${result.ORDER_PNM}</span></h2>
					</div>
					<div class="content">
						<div class="inner1 inner">
							<p class="title">Details</p>
							<ul>
								<li>
									<p>Customer</p>
									<span>${result.USER_ID}</span>
								</li>
								<li>
									<p>Date</p>
									<span>${result.REG_DATE_KO}</span>
								</li>
								<li>
									<p>Description</p>
									<span>${result.PLAN_NAME}</span>
								</li>
								<li>
									<p>Service Period</p>
									<span>${result.REG_DATE_KO} ~ ${result.EXITS_DATE_KO}</span>
								</li>
							</ul>
						</div>
						<div class="inner2 inner">
							<p class="title">Amount</p>
							<ul>	
								<li>
									<p>Subtotal</p>
									<c:set var="subTotal" value="${result.PAY_PRICE - result.PAY_TAX}"/>
									<span>₩ <em><fmt:formatNumber value='${subTotal}' pattern='#,###,###'/></em></span>
								</li>
								<li>
									<p>Tax</p>
									<c:set var="Tax" value="${result.PAY_TAX}"/>
									<span>₩ <em> <fmt:formatNumber value='${Tax}' pattern='#,###,###'/> </em></span>
								</li>
								<li class="totalCost">
									<p>Total</p>
									<c:set var= "Total" value="${result.PAY_PRICE}"/>
									<span>₩ <em> <fmt:formatNumber value='${Total}' pattern='#,###,###'/> </em></span>
								</li>
							</ul>
						</div>
						<div class="inner3 inner">
							<p class="title">Payment method</p>
							<c:if test="${result.PAY_TYPE eq 'card'}">
								<span>Credit Card</span>
							</c:if>
							<c:if test="${result.PAY_TYPE ne 'card'}">
								<span>Bank Transfer</span>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</body>
</html>