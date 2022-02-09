<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class="order_modify">
<%@ include file = "top_gnb.jsp" %>


			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>주문 관리</h2>
					</div>
					<div class="content">
						<form id="Form" name="Form" method="post" action="/admin/order_modify/check">
						<input type="hidden" name="MODE">
						<input type="hidden" name="NO" readOnly value="${item.NO }">
						<input type="hidden" name="USER_CODE">
						<table class="modify">
							<colgroup>
								<col width="25%">
								<col width="*">
							</colgroup>
							<tbody>
							<c:choose>
							<c:when test="${item.NO!='' }">
								<tr>
									<th>주문 ID</td>
									<td>${item.ORDER_ID }</td>
								</tr>
								<tr>
									<th>주문일시</td>
									<td>${item.REG_DATE_STR}</td>
								</tr>
								<tr>
									<th>회원 ID</td>
									<td>${item.USER_ID}</td>
								</tr>
								<tr>
									<th>용도</td>
									<td>${item.USE_CODE_STR }</td>
								</tr>
								<tr>
									<th>언어</td>
									<td>${item.LANGUAGE }</td>
								</tr>
								<tr>
									<th>국가</td>
									<td>${item.NATION}</td>
								</tr>
								<tr>
									<th>소속</td>
									<td>${item.COMPANY}</td>
								</tr>
								<tr>
									<th>금액(원)</td>
									<td>${item.PAY_PRICE }</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th>회원 ID</td>
									<td>
										<select id="USER_ID" name="USER_ID" >
											<option value="">맴버</option>
											<c:forEach items="${members}" var="item" varStatus="status">
											<option value="${item.USER_ID }">${item.USER_ID }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</c:otherwise>
							</c:choose>
							
							<tr>
								<th>주문 상품</td>
								<td>
									<select id="PLAN_CODE" name="PLAN_CODE" >
										<option value="">주문상품</option>
										<option value="01">FREE</option>
										<option value="02">SMALL</option>
										<option value="03">MEDIUM</option>
										<option value="04">LARGE</option>
									</select><script>PLAN_CODE.value='${item.PLAN_CODE }';</script>
								</td>
							</tr>
							<tr>
								<th>기간</td>
								<td>
									<select id="DATE_TYPE" name="DATE_TYPE" >
										<option value="">기간</option>
										<option value="month">MONTH</option>
										<option value="year">YEAR</option>
									</select><script>DATE_TYPE.value='${item.DATE_TYPE }';</script>
									<input type="date" name="EXITS_DATE" value="${fn:substring(item.EXITS_DATE_STR,0,10) }">
								</td>
							</tr>
						</table>
						
						<c:if test="${item.NO!='' }">
							<div class="delete">
								<button class="red" onclick="this.form.MODE.value='delete';">삭제</button>
							</div>
						</c:if>
						<div class="finish">
							<button onclick="this.form.MODE.value='cancel';">취소</button>
							<c:choose>
							<c:when test="${item.NO!='' }">
								<button class="navy" onclick="this.form.MODE.value='modify';">수정</button>
							</c:when>
							<c:otherwise>
								<button class="navy" onclick="this.form.MODE.value='insert';">추가</button>
							</c:otherwise>
							</c:choose>
						</div>
						</form>
					</div>
					
				</div>
			</div>
			
			
<script type="text/javascript">
$(function(){
	$('form').submit(function(event){
	
		var f= document.Form;
		switch(f.MODE.value){
		case "cancel":
			history.go(-1);
			break;
		case "delete":
			return confirm("삭제를 하시겠습니까?");
			break;
		case "insert":
			if($(f).find('select[name="USER_ID"]').val()==''){
				alert("맴버를 선택해주세요.");
				return false;
			}
			return true;
			break;
		case "modify":
// 			$(f).find('input[name="FAQ_CODE"]').val( $(f).find('input[name="r1"]:checked').val() );
			return true;
			break;
		}
		
		event.preventDefault();
		return false;
	}).ajaxForm({
		dataType: 'json',
        beforeSubmit: function (data,form,option) {
            //validation체크 
            var f= document.Form;
            switch(f.MODE.value){
            case "insert": case "modify":
// 				if( form.find('input[name="TITLE"]').val()=='' ){	alert('제목을 입력해주세요.'); return false; }
// 				if( form.find('input[name="DESCRIPTION"]').val()=='' ){	alert('설명을 입력해주세요.'); return false; }
// 				if( form.find('input[name="CONTENT"]').val()=='' ){	alert('설명을 입력해주세요.'); return false; }
        		break;
            }

            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            console.log(response);
            if('SUCCESS'==response.result){
				alert("정상 처리되었습니다.");
				location.href='order';
    			
            }else{
            	alert("존재하지 않는 계정이거나 비밀번호가 올바르지 않습니다. 관리자에게 문의하세요.");
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
});
</script>

</html>