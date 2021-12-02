<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class='administrator'>
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>관리자</h2>
					</div>
					<div class="content">
						<table class="main">
							<colgroup>
								<col width="15%">
								<col width="25%">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th>가입일시</th>
									<th>ID</th>
									<th>설명</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr onclick="location.href=('administrator_modify?NO=${item.NO}&ADMIN_ID=${item.ADMIN_ID}')">
										<td class="bl0">${item.REG_DATES }</td>
										<td>${item.ADMIN_ID }</td>
										<td class="br0">${item.DESCRIPTION }</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
<%-- 					 <%@ include file="paging.jsp"%> --%>
						<div class="pagingContainer">
							<div class="paging">
								<c:if test="${not empty paging2 }">${paging2 }</c:if>
							</div>
						</div>
					<div class="register">
						<button class="navy"><a href="./administrator_modify">등록</a></button>
					</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
</html>