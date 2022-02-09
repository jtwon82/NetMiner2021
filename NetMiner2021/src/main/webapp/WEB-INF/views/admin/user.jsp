<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>

	<body OnUnload="location.href='logout'">
		<div id="wrap" class="user">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>이용자</h2>
					</div>
					<div class="content">
						<div class="filter">
							<form id="Form" method="get" action="/admin/user">
							<ul>
								<li>
									<span>이용자 검색</span>
									<select id="SEARCH_KEY" name="SEARCH_KEY">
										<option value="" >컬럼</option>
										<option value="USER_ID">이메일</option>
										<option value="COMPANY">소속</option>
										<option value="NATION">국가</option>
									</select>
									<div class="search">
										<input type="text" name="SEARCH_VALUE" value="${json.SEARCH_VALUE }">
									</div>
								</li>
								<li>
									<span><input type="checkbox" id='FILTER1' name='FILTER1' class='filter_chkbox' value='1'>필터링</span>
									<select id="USE_CODE" name="USE_CODE" disabled="disabled" class='filter filter1'>
										<option value="" >용도</option>
										<option value="01">Academic</option>
										<option value="02">Commercial</option>
										<option value="99">Super</option>
									</select>
									<select id="SC_PLAN_CODE" name="SC_PLAN_CODE" disabled="disabled" class='filter filter1'>
										<option value="">주문상품</option>
										<option value="01">FREE</option>
										<option value="02">SMALL</option>
										<option value="03">MEDIUM</option>
										<option value="04">LARGE</option>
									</select>
									<select id="LANGUAGE" name="LANGUAGE" disabled="disabled" class='filter filter1'>
										<option value="" >언어</option>
										<option value="ko">Korean</option>
										<option value="en">English</option>
									</select>
									<select id="MARKET_YN" name="MARKET_YN" disabled="disabled" class='filter filter1'>
										<option value="" >수신동의</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
								</li>
								<li>
									<span><input type="checkbox" id='FILTER2' name='FILTER2' class='filter_chkbox' value='2'>가입기간</span>
									<input type="date" id="start" name='SDATE' value="${json.SDATE}" disabled="disabled" class='filter filter2'>~ 
									<input type="date" id="finish" name='EDATE' value="${json.EDATE}" disabled="disabled" class='filter filter2'>
								</li>
							</ul>
							<button class="finalSearch navy">검색</button>
							</form>
<script type="text/javascript">
	$(".filter_chkbox").change(function(e){
		$(".filter"+this.value).prop('disabled', 'disabled');
		if(this.checked){
			$(".filter"+this.value).prop('disabled', '');
		} else{
			$(".filter"+this.value).prop('disabled', 'disabled');
		}
	});
	if('${json.FILTER1}'=='1')	$("#FILTER1").click();
	if('${json.FILTER2}'=='2')	$("#FILTER2").click();
	
</script>
<script type="text/javascript">SEARCH_KEY.value='${json.SEARCH_KEY}';</script>
<script type="text/javascript">USE_CODE.value='${json.USE_CODE}';</script>
<script type="text/javascript">LANGUAGE.value='${json.LANGUAGE}';</script>
<script type="text/javascript">SC_PLAN_CODE.value='${json.SC_PLAN_CODE}';</script>
<script type="text/javascript">MARKET_YN.value='${json.MARKET_YN}';</script>

						</div>
						<table class="main">
							<colgroup>
								<col width="20%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="*">
								<col width="5%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>UUID</th>
									<th>가입일시</th>
									<th>타입구분</th>
									<th>용도구분</th>
									<th>이용현황</th>
									<th>트라이얼</th>
									<th>이메일</th>
									<th>언어</th>
									<th>국가</th>
									<th>소속</th>
									<th>수신동의</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${not empty list }">
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr onclick="location.href=('user_modify?NO=${item.NO}')">
											<td>${item.UUID }</td>
											<td>${item.REG_DATES }</td>
											<td>${item.TYPE_CODE_STR }</td>
											<td>${item.USE_CODE_STR }</td>
											<td>${item.SC_PLAN_CODE_STR }</td>
											<td>${item.FREE_YN }</td>
											<td>${item.USER_ID }</td>
											<td>${item.LANGUAGE }</td>
											<td>${item.NATION_NAME_KR }</td>
											<td>${item.COMPANY }</td>
											<td>${item.MARKET_YN }</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan='8' align='center'>검색결과가 없습니다.</td>
								</tr>
								</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<%--@ include file="paging.jsp"--%>
						<div class="pagingContainer">
							<div class="paging">
								<c:if test="${not empty paging2 }">${paging2 }</c:if>
							</div>
						</div>
						<div class="register">
							<button class="navy" onClick="downLoad();">다운로드</button>
							<button class="navy" onclick="location.href='user_modify'">등록</button>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
<script type="text/javascript">

function downLoad() {
	var para = document.location.href.split("?");
	location.href = "user/downLoadExcel?"+para[1];	
}
// $(function(){
// 	$('form').ajaxForm({
// 		dataType: 'json',
//         beforeSubmit: function (data,form,option) {
//             //validation체크 
//             input_value = form.find('input[name="id"]').val();
//             if(input_value == ''){
//             	alert("아이디를 입력해주세요.");
//             	return false;
//             }
            
//             return true;
//         },
//         success: function(response,status){
//             //성공후 서버에서 받은 데이터 처리
//             console.log(response);
//             if('SUCCESS'==response.result){
//     			location.replace("/admin/login/confirm");
    			
//             }else if('DUPLICATE'==response.result){
//             	if(confirm("이미 접속중입니다. 기존의 접속을 종료하시겠습니까?"))
//             		location.replace("/admin/login/disconnect");
//             	else
//             		location.replace("/admin");
            	
//             }else{
//             	alert("존재하지 않는 계정이거나 비밀번호가 올바르지 않습니다. 관리자에게 문의하세요.");
//             }
//         },
//         error: function(){
//         	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
//         }                               
//     });
// 	$('input[name="id"]').focus();
// });
</script>
</html>