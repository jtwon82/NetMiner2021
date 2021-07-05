<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import ="com.netMiner.app.util.Paging"%>
 
<% Paging p= (Paging)request.getAttribute("paging");
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
						
						<em class="num first active"><a href="#"><%=pageNumber %></a></em>
						<em class="num"><a href="#"><%=lastPageNumber %></a></em>
						
						<% if  ( pageNumber < lastPageNumber ) { %>
							<i class="next arrow"><a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(pageNumber + 1) ) %>">다음</a></i>
						<%} else { %>
							<i class="next arrow"><a href="#">다음</a></i>
						<%}%>
						</div>
					</div>
							
