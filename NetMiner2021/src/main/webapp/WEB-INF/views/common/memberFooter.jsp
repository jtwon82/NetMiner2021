<%@ page pageEncoding="UTF-8"%>
<div id="footer">
				<div class="wrap">
					<div class="content">
						<div>
							<ul class="terms obj">
								<li><a href="./TermsOfService">이용약관</a></li>
								<li><a href="./Privacy">개인정보처리방침</a></li>
							</ul>
							<div class="lang obj">
								<p>KOREAN<span></span></p>
								<ul>
									<li style="display:none;"><a href="javascript:;">KOREAN</a></li>
									<li><a href="javascript:;" onClick="changeLanguage('EN');">ENGLISH</a></li>
								</ul>
							</div>
							<div class="family obj">
								<p>패밀리사이트<span></span></p>
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
									<li><a href="http://onlineedu.cyram.com" target="_blank">사이람 교육센터</a></li>
								</ul>
							</div>
							<ul class="sns kr obj">
								<li class="fb"><a href="https://www.facebook.com/CyramInc" target="_blank"><img src="resources/images/footer_fb.png" alt="페이스북"></a></li>
								<li class="ins"><a href="https://twitter.com/cyraminc" target="_blank"><img src="resources/images/footer_ins.png" alt="인스타그램"></a></li>
								<li class="blog"><a href="https://cyram.tistory.com" target="_blank"><img src="resources/images/footer_blog.png" alt="블로그"></a></li>
								<li class="yt"><a href="https://www.youtube.com/channel/UCEyZjvgAc4uEIuHKRI5Jk0w/" target="_blank"><img src="resources/images/footer_yt.png" alt="유튜브"></a></li>
							</ul>
							<ul class="sns en obj" style="display:none;">
								<li class="fb"><a href="https://www.facebook.com/cyramnetminer" target="_blank"><img src="resources/images/footer_fb.png" alt="facebook"></a></li>
								<li class="ins"><a href="https://twitter.com/netminer" target="_blank"><img src="resources/images/footer_ins.png" alt="instagram"></a></li>
								<li class="yt"><a href="https://www.youtube.com/channel/UCEyZjvgAc4uEIuHKRI5Jk0w/" target="_blank"><img src="resources/images/footer_yt.png" alt="youtube"></a></li>
							</ul>
							<p class="cr obj">© CYRAM Inc. ALL RIGHTS RESERVED</p>
						</div>
					</div>
				</div>
			</div>