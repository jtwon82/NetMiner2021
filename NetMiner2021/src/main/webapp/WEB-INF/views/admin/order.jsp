<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class="quit">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>주문관리</h2>
					</div>
					<div class="content">
						<div class="filter">
							<form id="Form" name="Form" method="get" action="/admin/order">
							<ul>
								<li>
									<span>주문 검색 </span>
									<select id="SEARCH_KEY" name="SEARCH_KEY">
										<option value="" disabled="" selected="" hidden="">컬럼</option>
										<option value="UUID">UUID</option>
										<option value="NATION_NAME_KR">국가</option>
										<option value="COMPANY">소속</option>
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
									</select>
<!-- 									<select id="MB_TYPE_CODE" name="MB_TYPE_CODE" disabled="disabled" class='filter filter1'> -->
<!-- 										<option value="" >타입구분</option> -->
<!-- 										<option value="99">Super</option> -->
<!-- 									</select> -->
									<select id="LANGUAGE" name="LANGUAGE" disabled="disabled" class='filter filter1'>
										<option value="" >언어</option>
										<option value="ko">Korean</option>
										<option value="en">English</option>
									</select>
									<select id="PLAN_CODE" name="PLAN_CODE" disabled="disabled" class='filter filter1'>
										<option value="">주문상품</option>
										<option value="01">FREE</option>
										<option value="02">SMALL</option>
										<option value="03">MEDIUM</option>
										<option value="04">LARGE</option>
									</select>
									<select id="DATE_TYPE" name="DATE_TYPE" disabled="disabled" class='filter filter1'>
										<option value="">기간</option>
										<option value="month">MONTH</option>
										<option value="year">YEAR</option>
									</select>
								</li>
								<li>
									<span><input type="checkbox" id='FILTER2' name='FILTER2' class='filter_chkbox' value='2'>결제기간</span>
									<input type="date" id="SDATE" name="SDATE" value="${json.SDATE}" disabled="disabled" class='filter filter2'>~ 
									<input type="date" id="EDATE" name="EDATE" value="${json.EDATE}" disabled="disabled" class='filter filter2'>
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
<script type="text/javascript">TYPE_CODE.value='${json.TYPE_CODE}';</script>
<script type="text/javascript">LANGUAGE.value='${json.LANGUAGE}';</script>
<script type="text/javascript">PLAN_CODE.value='${json.PLAN_CODE}';</script>
<script type="text/javascript">DATE_TYPE.value='${json.DATE_TYPE}';</script>
						</div>
						<table class="main">
							<colgroup>
								<col width="3%">
								<col width="10%">
								<col width="*">
								<col width="8%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>NO</th>
									<th>결제시간</th>
									<th>UUID</th>
									<th>용도</th>
									<th>언어</th>
									<th>국가</th>
									<th>소속</th>
									<th>주문상품</th>
									<th>기간</th>
									<th>금액</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${not empty list }">
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr onclick="location.href=('order_modify?NO=${item.NO}')">
											<td style='text-align:center;padding-left:0px;'>${item.ROWCNT }</td>
											<td>${item.REG_DATE }</td>
											<td>${item.UUID }</td>
											<td>${item.MB_USE_CODE_STR }</td>
											<td>${item.LANGUAGE }</td>
											<td>${item.NATION_NAME_KR }</td>
											<td>${item.COMPANY }</td>
											<td>${item.PLAN_CODE_STR }</td>
											<td>${item.DATE_TYPE }</td>
											<td>${item.PAY_PRICE }</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan='6' align='center'>검색결과가 없습니다.</td>
								</tr>
								</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<div class="pagingContainer">
							<div class="paging">
								<c:if test="${not empty paging2 }">${paging2 }</c:if>
							</div>
						</div>
						<div class="register">
							<button class="navy" onClick="downLoad();">다운로드</button>
							<button class="navy" onclick="location.href='order_modify'">등록</button>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
<script type="text/javascript">
function downLoad() {
	var para = document.location.href.split("?");
	location.href = "order/downLoadExcel?"+para[1];	
}
</script>
</html>