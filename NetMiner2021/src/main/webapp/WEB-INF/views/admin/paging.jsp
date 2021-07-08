<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import ="com.netMiner.app.util.Paging"%>
 
<%
	Paging p= (Paging)request.getAttribute("paging");
	int pageNumber = p.getPageNumber();
	int entryCountPerOnePage = p.getEntryCountPerOnePage();
	int pageCountPerPageGroup = p.getPageCountPerPageGroup();
	int totalEntryCount = p.getTotalEntryCount();
	int curPageNavi = p.getCurPageNavi();
	int lastPageNumber = p.getLastPageNumber();
	int totalNaviCount = p.getTotalNaviCount(lastPageNumber);
	int startPageNumber = p.getStartPageNumber(curPageNavi);
	int endPageNumber = p.getEndPageNumber( startPageNumber);
	String urlFormat = p.getBaseUrlFormat();
%>
	
					<div class="pagingContainer">
						<div class="paging">
						<% if  ( pageNumber > 1 ) { %>
							<i class="prev arrow"><a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(pageNumber - 1) ) %>">이전</a></i>
						<%} else { %>
							<i class="prev arrow"><a href="#">이전</a></i>
						<%}%>
						 <% if (lastPageNumber == 0)  {%> 
							<em class="num first active"><a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(1) ) %>">1</a></em>
						<%} else { %>
							<%for (int i = 1 ; i <= lastPageNumber ; i++ ) {%>
				            	<%if (i == pageNumber) {%>
				            		<em class="num first active"><a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(i) ) %>"><%=i %></a></em>
				            	<%} else { %>
					            	<em class="num"><a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(i) ) %>"><%=i %></a></em>
					            <%} %>
				         	<%} %>						
						<%} %>
						<% if  ( lastPageNumber != pageNumber ) { %>
							<i class="next arrow"><a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(pageNumber + 1) ) %>">다음</a></i>
						<%} else { %>
							<i class="next arrow"><a href="#">다음</a></i>
						<%}%>
						</div>
					</div>
							
