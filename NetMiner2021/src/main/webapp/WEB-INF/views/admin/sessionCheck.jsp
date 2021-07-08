<%@page import="com.netMiner.app.config.Constant"%>
<%@page import="com.netMiner.app.model.vo.AdminVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%
	AdminVo admin = (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
	%>
	<% if (admin == null) {%>
		<script type="text/javascript">
			$(function (){
				alert("관리자 로그인후 이용해주세요");
				window.location.href="/admin/";
			})
		</script>
	<%}%>