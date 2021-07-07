<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<title>Privacy|NetMiner 365</title>
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
		<script src="resources/js/gnb.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
		<script src="resources/js/main.js?st=<%= Math.floor(Math.random() *100)%>" type="text/javascript"></script>
	</head>
	<body>
		<div id="wrap" class="sub terms privacy">
			<%@include file = "../common/top.jsp" %>
			
			<div id="section">
				<div class="wrap">
					<h3>개인정보처리방침</h3>
					<p class="txt1">
						(주)사이람 은 「개인정보 보호법」 제30조에 따라 정부주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.<br><br>이 개인정보처리방침은 2021년 7월 1부터 적용됩니다.
					</p>
					<dl>
						<dt>제 1조 (개인정보의 처리 목적)</dt>
						<dd>
							<ul>
								<li>(주)사이람 은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 겨우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</li>
								<li>1. 홈페이지 이용자 가입 및 관리<br>이용자 가입의사 확인, 이용자 서비스 제공에 따른 본인 식별·인증, 이용자자격 유지·관리, 서비스 부정이용 방지, 각종 고지·통지 목적으로 개인정보를 처리합니다.</li>
								<li>2. 마케팅 및 광고에의 활용<br>신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 서비스의 유효성 확인, 접속빈도 파악 또는 이용자의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 2조 (개인정보의 처리 및 보유 기간)</dt>
						<dd>
							<ul>
								<li>1. (주)사이람 은 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.</li>
								<li>
									<p>2. 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.</p>
									<table>
										<colgroup>
											<col style="width:35%"><col style="width: 65%;">
										</colgroup>
										<tbody>
											<tr>
												<th>개인정보의 파일 명칭</th>
												<th>개인정보의 항목</th>
											</tr>
											<tr>
												<td>홈페이지 이용자가입 및 관리</td>
												<td>필수: 이메일, 비밀번호, 회사명, 국가<br>선택: 이메일 수신 여부</td>
											</tr>
											<tr>
												<td>마케팅 및 광고에의 활용</td>
												<td>필수: 이메일</td>
											</tr>
										</tbody>
									</table>
									<p>또한 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.</p>
									<table>
										<colgroup>
											<col style="width:35%"><col style="width: 65%;">
										</colgroup>
										<tbody>
											<tr>
												<th>개인정보의 파일 명칭</th>
												<th>개인정보의 항목</th>
											</tr>
											<tr>
												<td>통신사실 확인</td>
												<td>IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등</td>
											</tr>
										</tbody>
									</table>
								</li>
								<li>
									<p>3. 개인정보 수집 및 이용 목적이 달성되면 지체 없이 파기되나, 아래의 경우에는 명시한 기간 동안 보관할 수 있으며 다른 목적으로는 사용되지 않습니다. </p>
									<table>
										<colgroup>
											<col style="width:30%"><col style="width: 35%;"><col style="width: 35%;">
										</colgroup>
										<tbody>
											<tr>
												<th>개인정보파일의 명칭</th>
												<th>보유근거</th>
												<th>보유기간</th>
											</tr>
											<tr>
												<td>홈페이지 이용자가입 및 관리 / 마케팅 및 광고에의 활용</td>
												<td>서비스 이용의 혼선 방지, 불량 이용자의 재가입 방지, 명예훼손 등 권리침해 분쟁 및 수사협조</td>
												<td>이용자 탈퇴 시,  이메일을 제외한  정보는 즉시 삭제<br>이메일은 1년 간 분리보관 후 삭제</td>
											</tr>
											<tr>
												<td>통신사실 확인</td>
												<td>「통신비밀보호법」 제41조에 따른 통신사실확인자료 보관 서비스 이용 기록, 접속 로그, 접속 IP 정보</td>
												<td>6개월</td>
											</tr>
										</tbody>
									</table>
								</li>
								<li>4. 장기 미이용자(휴면이용자)의 개인정보 처리<br>‘개인정보 유효기간제’에 따라 1년 이상 로그인 기록이 없으면 해당 이용자는 휴면 계정으로 전환되며 개인정보는 별도 분리하여 보관합니다.<br>참고로 휴면 전환 30일 전에 휴면 전환 예정일과 정보 처리 방법을 이메일을 통해 이용자에게 알려드립니다.</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 3조 (개인정보의 처리 위탁)</dt>
						<dd>
							<ul>
								<li>제3조(개인정보의 처리 위탁)</li>
								<li>
									개인정보 처리위탁 중 국외에서 처리하는 위탁업무는 아래와 같습니다.
									<ol>
										<li>- 수탁업체 : Amazon Web Service</li>
										<li>- 위탁 업무 내용 : 데이터 보관 및 시스템 운영</li>
										<li>- 개인정보 이전국가 : 대한민국 서울 (AWS Seoul Region)</li>
										<li>- 이전되는 개인정보 항목 : 서비스 제공 과정에서 수집한 모든 개인정보</li>
										<li>- 개인정보 이전일시 : 서비스 이용을 위한 필요 정보 입력 시</li>
										<li>- 개인정보 이전방법 : AWS 클라우드 컴퓨팅 환경에 개인정보 보관</li>
										<li>- 개인정보 보유, 이용기간 : 이용자 탈퇴 또는 개인정보 유효기간 도래 시까지 보관</li>
									</ol>
								</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 4조 (정보주체와 법정대리인의 권리·의무 및 그 행사방법)</dt>
						<dd>
							<ul>
								<li>1. 정보주체는 (주)사이람에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.</li>
								<li>2. 제1항에 따른 권리 행사는(주)사이람에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 (주)사이람 은 이에 대해 지체 없이 조치하겠습니다.</li>
								<li>3. 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
								<li>4. 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.</li>
								<li>5. 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.</li>
								<li>6. (주)사이람 은 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 5조 (개인정보의 파기)</dt>
						<dd>
							<ul>
								<li>1. (주)사이람 은 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.</li>
								<li>2. 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.</li>
								<li>
									3. 개인정보 파기의 절차 및 방법은 다음과 같습니다.
									<ol>
										<li>① 파기절차<br>(주)사이람 은 파기 사유가 발생한 개인정보를 선정하고, (주)사이람 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.</li>
										<li>② 파기방법<br>종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기하고 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.</li>
									</ol>
								</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 6조 (개인정보의 안전성 확보 조치)</dt>
						<dd>
							<p>(주)사이람 은 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.</p>
							<ul>
								<li>1. 개인정보 취급 직원의 최소화 및 교육<br>개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화하여 개인정보를 관리하는 대책을 시행하고 있습니다.</li>
								<li>2. 해킹 등에 대비한 기술적 대책<br>(주)사이람('NetMiner 365')은 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.</li>
								<li>3. 개인정보의 암호화<br>이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.</li>
								<li>4. 접속기록의 보관 및 위변조 방지<br>개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능 사용하고 있습니다.</li>
								<li>5. 개인정보에 대한 접근 제한<br>개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 7조 (개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항)</dt>
						<dd>
							<ul>
								<li>1. (주)사이람 은 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다. </li>
								<li>
									2. 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다. 
									<ol>
										<li>① 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다. </li>
										<li>② 쿠키의 설치·운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.<br>쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.</li>
									</ol>
								</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 8조 (개인정보 보호책임자)</dt>
						<dd>
							<ul>
								<li>
									1. (주)사이람 은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
									<ol>
										<li>① 개인정보 보호책임자</li>
										<li>- 성명 : 김기훈</li>
										<li>- 직책 : 대표 이사</li>
										<li>- 연락처 : 031-739-8352, <a href="mailto:netminer@cyram.com"><b>netminer@cyram.com</b></a></li>
									</ol>
									<ol>
										<li>② 개인정보 보호 담당부서</li>
										<li>- 부서명 : 지원파트</li>
										<li>- 담당자 : 박재영</li>
										<li>- 연락처 : 031-739-8352, <a href="mailto:netminer@cyram.com"><b>netminer@cyram.com</b></a></li>
									</ol>
								</li>
								<li>
									2. 정보주체는 (주)사이람 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. (주)사이람 은 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.
								</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 9조 (개인정보 열람창구)</dt>
						<dd>
							<ul>
								<li>정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다.<br>(주)사이람 은 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.</li>
								<li>
									① 개인정보 열람청구 접수·처리 부서
									<ol>
										<li>- 부서명 : 지원파트</li>
										<li>- 담당자 : 박재영</li>
										<li>- 연락처 : 031-739-8352, <a href="mailto:netminer@cyram.com"><b>netminer@cyram.com</b></a></li>
									</ol>
								</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 10조 (권익침해 구제방법)</dt>
						<dd>
							<p>정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.</p>
							<ul>
								<li>1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)</li>
								<li>2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)</li>
								<li>3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)</li>
								<li>4. 경찰청 : (국번없이) 182 (cyberbureau.police.go.kr)</li>
							</ul>
							<p>「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정•삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.<br><br></p>
							<p>※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.</p>
						</dd>
					</dl>
					<dl>
						<dt>제 11조 (개인정보 처리방침 변경)</dt>
						<dd>
							<ul>
								<li>1. 이 개인정보처리방침은 2021년 7월 1부터 적용됩니다.</li>
								<li>2. 이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다.</li>
							</ul>
						</dd>
					</dl>
				</div>
			</div>
			
			<%@include file = "../common/footer.jsp" %>
		</div>
	
	</body>
</html>