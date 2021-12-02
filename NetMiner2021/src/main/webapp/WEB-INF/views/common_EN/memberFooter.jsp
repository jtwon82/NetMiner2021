<%@ page pageEncoding="UTF-8"%>
<div id="footer">
				<div class="wrap">
					<div class="content">
						<div>
							<ul class="terms obj">
								<li><a href="./TermsOfService">Terms of Service</a></li>
								<li><a href="./Privacy">Privacy Policy</a></li>
							</ul>
							<div class="lang obj">
								<p>ENGLISH<span></span></p>
								<ul>
									<li><a href="javascript:;" onClick="changeLanguage('KR');">KOREAN</a></li>
									<li style="display:none;"><a href="javascript:;">ENGLISH</a></li>
								</ul>
							</div>
							<div class="family obj">
								<p>Family Site<span></span></p>
								<ul>
									<li><a href="http://www.netminer.com/" target="_blank">NetMiner</a></li>
<!-- 									<li><a href="http://www.cyram.com/en/index/index_body.php" target="_blank">Cyram</a></li> -->
									<c:choose>
									<c:when test="${language eq '_EN'}">
										<li><a href="http://www.cyram.com/en/index/index_body.php" target="_blank">Cyram</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="http://www.cyram.com" target="_blank">Cyram</a></li>
									</c:otherwise>
									</c:choose>
									<li><a href="http://edu.cyram.com" target="_blank" style="color:gray; cursor: default; pointer-events:none ">Cyram Education </a></li>
								</ul>
							</div>
							<ul class="sns kr obj" style="display:none;">
								<li class="fb"><a href="https://www.facebook.com/CyramInc" target="_blank"><img src="resources/images/footer_fb.png" alt="페이스북"></a></li>
								<li class="tw"><a href="https://twitter.com/cyraminc" target="_blank"><img src="resources/images/footer_tw.png" alt="트위터"></a></li>
								<li class="blog"><a href="https://cyram.tistory.com" target="_blank"><img src="resources/images/footer_blog.png" alt="블로그"></a></li>
								<li class="yt"><a href="https://www.youtube.com/channel/UCEyZjvgAc4uEIuHKRI5Jk0w/" target="_blank"><img src="resources/images/footer_yt.png" alt="유튜브"></a></li>
							</ul>
							<ul class="sns en obj" >
								<li class="fb"><a href="https://www.facebook.com/cyramnetminer" target="_blank"><img src="resources/images/footer_fb.png" alt="facebook"></a></li>
								<li class="tw"><a href="https://twitter.com/netminer" target="_blank"><img src="resources/images/footer_tw.png" alt="instagram"></a></li>
								<li class="yt"><a href="https://www.youtube.com/channel/UCEyZjvgAc4uEIuHKRI5Jk0w/" target="_blank"><img src="resources/images/footer_yt.png" alt="youtube"></a></li>
							</ul>
							<p class="cr obj">© CYRAM Inc. ALL RIGHTS RESERVED</p>
						</div>
					</div>
				</div>
			</div>