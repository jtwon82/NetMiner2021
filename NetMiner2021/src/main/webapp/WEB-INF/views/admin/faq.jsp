<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class="quit">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>FAQ</h2>
					</div>
					<div class="content">
						<div class="filter">
							<form id="Form" name="Form" method="get" action="/admin/faq">
							<ul>
								<li class="lang">
									<select id="LANGUAGE" name="LANGUAGE">
										<option value="">다국어</option>
										<option value="ko">국문</option>
										<option value="en">영문</option>
									</select>
								</li>
								<li>
									<select id="CATE_CODE" name="CATE_CODE">
										<option value="" >카테고리</option>
										<option value="01">결제</option>
										<option value="02">서비스이용</option>
										<option value="03">계정</option>
										<option value="04">일반</option>
									</select>
									<div class="search">
										<input type="hidden" id='SEARCH_KEY' name='SEARCH_KEY' value="TITLE">
										<input type="text" id='SEARCH_VALUE' name='SEARCH_VALUE' value="${json.SEARCH_VALUE }">
									</div>
								</li>
							</ul>
							<button class="finalSearch navy">검색</button>
							</form>
<script type="text/javascript">LANGUAGE.value='${json.LANGUAGE}';</script>
<script type="text/javascript">CATE_CODE.value='${json.CATE_CODE}';</script>
						</div>
						<table class="main">
							<colgroup>
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th>언어</th>
									<th>카테고리</th>
									<th>작성일시</th>
									<th>제목</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${not empty list }">
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr onclick="location.href=('faq_modify?NO=${item.NO}')">
											<td>${item.LANGUAGE_STR }</td>
											<td>${item.CATE_CODE_STR }</td>
											<td>${item.REG_DATE }</td>
											<td>${item.TITLE }</td>
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
						<div class="pagingContainer">
							<div class="paging">
								<c:if test="${not empty paging2 }">${paging2 }</c:if>
							</div>
						</div>
						<div class="register">
							<button class="navy" onclick="location.href='faq_modify'">등록</button>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
</html>