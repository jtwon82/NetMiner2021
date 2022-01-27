<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
<body OnUnload="location.href='logout'">
	<div id="wrap" class="email">
		<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>자동 이메일</h2>
					</div>
					<div class="content">
						<table class="main">
							<colgroup>
								<col width="15%">
								<col width="30%">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th>등록일시</th>
									<th>이메일 제목</th>
									<th>설명</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${not empty list }">
								<c:forEach items="${list}" var="item" varStatus="status">
									<tr onclick="location.href=('email_modify?NO=${item.NO}')">
										<td>${item.REG_DATES}</td>
										<td>${item.TITLE}</td>
										<td>${item.EXPLAIN }</td>
									</tr>							
								</c:forEach>
							</c:if>
						</tbody>
					</table>
<%-- 					<%@ include file="paging.jsp"%>					 --%>
						<div class="pagingContainer">
							<div class="paging">
								<c:if test="${not empty paging2 }">${paging2 }</c:if>
							</div>
						</div>
					<div class="register">
						<button class="navy" onclick="location.href='email_modify'">등록</button>
					</div>
					</div>
					
				</div>
			</div>
		</div>
	</body>
</html>