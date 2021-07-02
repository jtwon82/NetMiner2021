<%@ page pageEncoding="UTF-8"%>

	<div id="top">
				<div class="content">
					<div class="wrap">
						<h1 class="obj"><a href="./"><img src="/resources/images/main_logo.png" alt="Why NetMiner 365 logo" class="logo1"><img src="/resources/images/main_logo2.png" alt="Why NetMiner 365 logo" class="logo2"></a></h1>
						<div class="pc">
							<div class="menu obj">
								<span class="select">Why NetMiner 365</span>
								<ul>
									<li><a href="./whyNetMiner">Why NetMiner 365</a></li>
									<li><a href="./feature">Feature</a></li>
									<li><a href="./function">Function</a>
									<li><a href="./solution">Solution</a>
								</ul>
							</div>
							<!-- 로그인 전-->
							<c:if test="${empty memberVo}">
							<div class="mypage obj type1" >
								<ul>
									<li class="join"><a href="./login" >Start for free</a></li>
									<li class="login"><a href="./login" >Sign in</a></li>
								</ul>
							</div>
							</c:if>

							<!-- 로그인 후-->
							<c:if test="${!empty memberVo}">
							<div class="mypage obj type2">
								<p class="me">
									<img src="/resources/images/top_me.png" alt="mypage">
								</p>
								<ul>
									<li class="workSpace active"><a href="http://online.netminer365.com/Loginfo?passport=${memberVo.userId}" class="trs">My Workspace</a></li>
									<li class="account"><a href="./account" class="trs">Account</a></li>
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
											<li class="join"><a href="./login" >Start for free</a></li>
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
											<li class="workSpace active"><a href="http://online.netminer365.com/Loginfo?passport=${memberVo.userId}" class="trs">My Workspace</a></li>
											<li class="account"><a href="./account" class="trs">Account</a></li>
											<li class="signOut"><a href="#" class="trs">Sign-Out</a></li>
										</ul>
									</div>
									</c:if>
									<ul class="menu">
										<li><a href="./whyNetMiner">Why NetMiner 365</a></li>
										<li><a href="./feature">Feature</a></li>
										<li><a href="./function">Function</a>
										<li><a href="./solution">Solution</a>
									</ul>
								</div>
							</div>
							<div class="bg"></div>
						</div>
					</div>
				</div>
			</div>
