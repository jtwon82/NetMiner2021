<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>
<style>
.h {display:none;}

#main .mypage.type1{position: relative;text-align: center;top: -100px;}
#main .mypage.type1 li.join{transition: all 0.5s;text-align: center;cursor: pointer;font-size: 26px;border: 1px solid #fff;width: 216px;line-height: 60px;height: 60px;display: inline-block;}
@media (min-width: 0px) and (max-width: 1000px){
	#main .mypage.type1{right:0px;top:-20px;}
	#main .mypage.type1 li.join{border:1px solid #fff;width:148px;text-align:center;line-height:42px;height:42px;}
}
#main .mypage.type1 li{display: inline-block; color:#fff; font-size:20px; }
#main .mypage.type1 li.join a{width:100%;height:100%;} 
#main .mypage.type1 li.login a{padding:5px 5px 5px 20px; color:#fff; }

.select2-container{margin-top:15px;}
.select2-container .select2-selection--single{height: 60px;}
.select2-container--default .select2-selection--single .select2-selection__rendered{line-height: 60px;}
.select2-container--default .select2-selection--single .select2-selection__arrow{top:15px;}
.select2-dropdown{top: -16px;}
@media (min-width: 0px) and (max-width: 1000px){
   .select2-container .select2-selection--single{height:35px;}
   .select2-container--default .select2-selection--single .select2-selection__rendered{line-height:35px;}
   .select2-container--default .select2-selection--single .select2-selection__arrow{top:5px;}
   .select2-results{font-size:12px;}
}
</style>
<script type="text/javascript">
<!--
	var language= "${language}";
	var ROOT_URL= "${ROOT_URL}";
	var redirectAuth= "${GOOGLE_CALL_BACK_LOGIN_URL}";
	var redirectRegister= "${GOOGLE_CALL_BACK_REGISTER_URL}";
-->


</script>
	<div id="top">
				<div class="content">
					<div class="wrap">
						<h1 class="obj"><a href="./"><img src="/resources/images/main_logo.png" alt="Why NetMiner 365 logo" class="logo1"><img src="/resources/images/main_logo2.png" alt="Why NetMiner 365 logo" class="logo2"></a></h1>
						<div class="pc">
							<div class="menu obj">
								<span class="select">Why NetMiner 365</span>
								<ul class="menu" style="display:none;">
									<li><a href="./whyNetMiner">Why NetMiner 365</a></li>
									<li><a href="./feature">Feature</a></li>
									<li><a href="./function">Function</a>
									<li><a href="./solution">Solution</a>
								</ul>
							</div>
							<a class="price obj" href="./pricing">Pricing</a>
							
							<!-- 로그인 전-->
							<c:if test="${empty memberVo}">
							<div class="mypage obj type1" >
								<ul>
									<!--  <li class="join"><a href="./login" >Start for free</a></li>-->
									<li class="join"><a href="./pricing" >Start for free</a></li>
									<li class="login"><a href="./login" >Sign in</a></li>
								</ul>
							</div>
							</c:if>

							<!-- 로그인 후-->
							<c:if test="${!empty memberVo}">
							<div class="mypage obj type1" style="right: 70px;">
								<ul>
									<c:if test="${memberVo.SUBSCRIPT_YN eq 'Y'}">
											<c:if  test="${memberVo.CHECK_TRIAL == 1}">
												<c:if test="${memberVo.CHECK_PLAN_CODE eq '01'}">
													<c:if test="${memberVo.DIFF_DAY > 0}">
													  <li class="join"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" >My Workspace</a></li>
													</c:if>
													<c:if test="${memberVo.DIFF_DAY <= 0}">
														  <li class="join"><a href="./pricing">Buy Now</a></li>
													</c:if>
												</c:if>
												<c:if test="${memberVo.CHECK_PLAN_CODE ne '01'}">
													<c:if test="${memberVo.DIFF_DAY >= -5}">
													  <li class="join"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" >My Workspace</a></li>
													</c:if>
													<c:if test="${memberVo.DIFF_DAY < -5}">
													  <li class="join"><a href="./pricing">Buy Now</a></li>
													</c:if>
												</c:if>
											</c:if>
											<c:if test="${memberVo.CHECK_TRIAL == 0}">
												<c:if test="${memberVo.DIFF_DAY >= -5}">
												  <li class="join"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" >My Workspace</a></li>
												</c:if>
												<c:if test="${memberVo.DIFF_DAY < -5}">
												  <li class="join"><a href="./pricing">Start for free</a></li>
												</c:if>										
											</c:if>
									</c:if>
									 <c:if test="${memberVo.SUBSCRIPT_YN eq 'N'}"> 									
											  <li class="join"><a href="./pricing">Start for free</a></li>								
									 </c:if>									 
								</ul>
							</div>
							<div class="mypage obj type2">
								<p class="me">
									<img src="/resources/images/top_me.png" alt="mypage">
								</p>
								<ul>
									<c:if test="${memberVo.SUBSCRIPT_YN eq 'Y'}">
										<c:if  test="${memberVo.CHECK_TRIAL == 1}">
											<c:if test="${memberVo.CHECK_PLAN_CODE eq '01'}">
												<c:if test="${memberVo.DIFF_DAY > 0}">
													<li class="workSpace active"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" class="trs">Go to my workspace</a></li> 
												</c:if>
												<c:if test="${memberVo.DIFF_DAY <= 0}">
													<c:if test="${language eq '_EN'}">
														<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
													</c:if>
													<c:if test="${language eq ''}">
														<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
													</c:if>
												</c:if>
											</c:if>
											<c:if test="${memberVo.CHECK_PLAN_CODE ne '01'}">
												<c:if test="${memberVo.DIFF_DAY >= -5}">
											 		<li class="workSpace active"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" class="trs">Go to my workspace</a></li> 
											 	</c:if>
											 	<c:if test="${memberVo.DIFF_DAY < -5}">
												 	<c:if test="${language eq '_EN'}">
														<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
													</c:if>
													<c:if test="${language eq ''}">
														<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
													</c:if>
											 	</c:if>
											</c:if>
										</c:if>
										<c:if test="${memberVo.CHECK_TRIAL == 0}">
											<c:if test="${memberVo.DIFF_DAY >= -5}">
										 		<li class="workSpace active"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" class="trs">Go to my workspace</a></li> 
										 	</c:if>
										 	<c:if test="${memberVo.DIFF_DAY < -5}">
											 	<c:if test="${language eq '_EN'}">
													<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
												</c:if>
												<c:if test="${language eq ''}">
													<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
												</c:if>
										 	</c:if>
										</c:if>
									</c:if>
									<c:if test="${memberVo.SUBSCRIPT_YN eq 'N'}"> 
											<c:if test="${language eq '_EN'}">
												<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
											</c:if>
											<c:if test="${language eq ''}">
												<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
											</c:if>
									</c:if>
									<li class="account"><a href="./account" class="trs">Account</a></li>
									<li class="billing"><a href="./billing" class="trs">Billing</a></li>
									<li class="signOut"><a href="#" class="trs">Sign-Out</a></li>
								</ul>
							</div>
							</c:if>
						</div>
						<div id="navBtn" class="mobile obj"><img src="/resources/images/navBtn.png"></div>
						<div id="navOn" class="mobile">
							<div id="nav" class="obj">
								<div class="navClose obj"><img src="/resources/images/nav_close.png" alt="닫기"></div>
								<div class="container">
									<!-- 로그인 전-->
									<c:if test="${empty memberVo}">
									<div class="mypage type1" >
										<ul>
											<li class="join"><a href="./pricing" >Start for free</a></li>
											<li class="login"><a href="./login" >Sign in</a></li>
										</ul>
									</div>
									</c:if>
									<!-- 로그인 후-->
									<c:if test="${!empty memberVo}">
									<div class="mypage type2" >
										<p class="me">
											<img src="/resources/images/top_me.png" alt="mypage">
										</p>
										<ul>
										<c:if test="${memberVo.SUBSCRIPT_YN eq 'Y'}">
											<c:if  test="${memberVo.CHECK_TRIAL == 1}">
												<c:if test="${memberVo.CHECK_PLAN_CODE eq '01'}">
													<c:if test="${memberVo.DIFF_DAY > 0}">
														<li class="workSpace active"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" class="trs">Go to my workspace</a></li> 
													</c:if>
													<c:if test="${memberVo.DIFF_DAY <= 0}">
														<c:if test="${language eq '_EN'}">
															<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
														</c:if>
														<c:if test="${language eq ''}">
															<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
														</c:if>
													</c:if>
												</c:if>
												<c:if test="${memberVo.CHECK_PLAN_CODE ne '01'}">
													<c:if test="${memberVo.DIFF_DAY >= -5}">
												 		<li class="workSpace active"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" class="trs">Go to my workspace</a></li> 
												 	</c:if>
												 	<c:if test="${memberVo.DIFF_DAY < -5}">
													 	<c:if test="${language eq '_EN'}">
															<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
														</c:if>
														<c:if test="${language eq ''}">
															<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
														</c:if>
												 	</c:if>
												</c:if>
											</c:if>
											<c:if test="${memberVo.CHECK_TRIAL == 0}">
												<c:if test="${memberVo.DIFF_DAY >= -5}">
											 		<li class="workSpace active"><a href="http://${ONLINEDOMAIN}/Loginfo?passport=${memberId}" class="trs">Go to my workspace</a></li> 
											 	</c:if>
											 	<c:if test="${memberVo.DIFF_DAY < -5}">
												 	<c:if test="${language eq '_EN'}">
														<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
													</c:if>
													<c:if test="${language eq ''}">
														<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
													</c:if>
											 	</c:if>
											</c:if>
										</c:if>
										<c:if test="${memberVo.SUBSCRIPT_YN eq 'N'}"> 
												<c:if test="${language eq '_EN'}">
													<li class="workSpace active"><a href="./pricing" onclick="alert('You are not currently using NetMiner365');" class="trs">Go to my workspace</a></li> 
												</c:if>
												<c:if test="${language eq ''}">
													<li class="workSpace active"><a href="./pricing" onclick="alert('현재 이용중인 상품이 없습니다.');" class="trs">Go to my workspace</a></li> 
												</c:if>
										</c:if>
											<li class="account"><a href="./account" class="trs">Account</a></li>
											<li class="billing"><a href="./billing" class="trs">Billing</a></li>
											<li class="signOut"><a href="#" class="trs">Sign-Out</a></li>
										</ul>
									</div>
									</c:if>
									<ul class="menu">
										<li><a href="./whyNetMiner">Why NetMiner 365</a></li>
										<li><a href="./feature">Feature</a></li>
										<li><a href="./function">Function</a>
										<li><a href="./solution">Solution</a>
										<li><a href="./pricing">Pricing</a>
									</ul>
								</div>
							</div>
							<div class="bg"></div>
						</div>
					</div>
				</div>
			</div>
