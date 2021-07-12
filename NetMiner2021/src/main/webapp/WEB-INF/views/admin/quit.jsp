<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class="quit">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>휴면 / 탈퇴</h2>
					</div>
					<div class="content">
						<div class="filter">
							<form id="Form" name="Form" method="get" action="/admin/quit">
							<ul>
								<li>
									<span>이용자 검색</span>
									<select id="SEARCH_KEY" name="SEARCH_KEY">
										<option value="" disabled="" selected="" hidden="">컬럼</option>
										<option value="USER_ID">이메일</option>
										<option value="COMPANY">소속</option>
									</select>
									<div class="search">
										<input type="text" id='SEARCH_VALUE' name='SEARCH_VALUE' value="${json.SEARCH_VALUE }">
									</div>
								</li>
								<li>
									<span><input type="checkbox" id='FILTER1' name='FILTER1' class='filter_chkbox' value='1'>필터링</span>
									<select id="USER_CODE_STATS" name="USER_CODE_STATS" disabled="disabled" class='filter filter1'>
										<option value="" disabled="" selected="" hidden="">휴면/탈퇴</option>
										<option value="REST">휴면</option>
										<option value="QUIT">탈퇴</option>
									</select>
									
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
// 	if('${json.FILTER2}'=='2')	$("#FILTER2").click();
</script>
<script type="text/javascript">SEARCH_KEY.value='${json.SEARCH_KEY}';</script>
<script type="text/javascript">USER_CODE_STATS.value='${json.USER_CODE_STATS}';</script>

						</div>
						<table class="main">
							<colgroup>
								<col width="12%">
								<col width="14%">
								<col width="*">
								<col width="12%">
								<col width="12%">
								<col width="12%">
								<col width="12%">
							</colgroup>
							<thead>
								<tr>
									<th>가입일시</th>
									<th>용도</th>
									<th>이메일</th>
									<th>언어</th>
									<th>국가</th>
									<th>소속</th>
									<th>수신동의</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty list }">
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr onclick="location.href=('quit_modify?NO=${item.NO}')">
											<td>${item.REG_DATES }</td>
											<td>${item.USE_CODE }</td>
											<td>${item.USER_ID }</td>
											<td>${item.LANGUAGE }</td>
											<td>${item.NATION_NAME_KR }</td>
											<td>${item.COMPANY }</td>
											<td>${item.MARKET_YN }</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
						
						<div class="pagingContainer">
							<div class="paging">
								<c:if test="${not empty paging2 }">${paging2 }</c:if>
<!-- 								<i class="first arrow"><a href="#">처음</a></i> -->
<!-- 								<i class="prev arrow"><a href="#">이전</a></i> -->
<!-- 								<em class="num first active"><a href="#">1</a></em> -->
<!-- 								<em class="num"><a href="#">2</a></em> -->
<!-- 								<em class="num"><a href="#">3</a></em> -->
<!-- 								<em class="num"><a href="#">4</a></em> -->
<!-- 								<em class="num"><a href="#">5</a></em> -->
<!-- 								<em class="num"><a href="#">6</a></em> -->
<!-- 								<em class="num"><a href="#">7</a></em> -->
<!-- 								<em class="num"><a href="#">8</a></em> -->
<!-- 								<em class="num"><a href="#">9</a></em> -->
<!-- 								<em class="num"><a href="#">10</a></em> -->
<!-- 								<i class="next arrow"><a href="#">다음</a></i> -->
<!-- 								<i class="last arrow"><a href="#">마지막</a></i> -->
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
</html>