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
									<tr onclick="location.href=('mail_modify?NO=${item.NO}')">
										<td>${item.REG_DATES}</td>
										<td>${item.TITLE}</td>
										<td>${item.EXPLAIN }</td>
									</tr>							
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<%@ include file="paging.jsp"%>
					<div class="pagingContainer">
						<div class="paging">
							<i class="first arrow"><a href="#">처음</a></i>
							<i class="prev arrow"><a href="#">이전</a></i>
							<em class="num first active"><a href="#">1</a></em>
							<em class="num"><a href="#">2</a></em>
							<em class="num"><a href="#">3</a></em>
							<em class="num"><a href="#">4</a></em>
							<em class="num"><a href="#">5</a></em>
							<em class="num"><a href="#">6</a></em>
							<em class="num"><a href="#">7</a></em>
							<em class="num"><a href="#">8</a></em>
							<em class="num"><a href="#">9</a></em>
							<em class="num"><a href="#">10</a></em>
							<i class="next arrow"><a href="#">다음</a></i>
							<i class="last arrow"><a href="#">마지막</a></i>
						</div>
					</div>
					<div class="register">
						<button class="navy">등록</button>
					</div>
					</div>
					
				</div>
			</div>
		</div>
	</body>
</html>