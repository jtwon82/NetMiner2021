<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file = "top.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
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
								<col width="15%">
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
<!-- 								<tr> -->
<!-- 									<th>회원 ID</td> -->
<%-- 									<td>${item.USER_ID}</td> --%>
<!-- 								</tr> -->
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
									<td>${item.NATION_NAME_KR}</td>
								</tr>
								<tr>
									<th>소속</td>
									<td>${item.COMPANY}</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th>회원 UUID</td>
									<td>
										<select id="UUID" name="UUID" style="width:430px;">
											<option value="">맴버(UUID)</option>
											<c:forEach items="${members}" var="item" varStatus="status">
											<option value="${item.UUID }">${item.UUID }</option>
											</c:forEach>
										</select><script>$('select[name="UUID"]').select2();</script>
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
							<tr>
								<th>금액</td>
								<td>
									<select id="PAY_PLATFORM" name="PAY_PLATFORM" >
										<option value="">화폐단위</option>
										<option value="toss">원화</option>
										<option value="paypal">달러</option>
									</select><script>PAY_PLATFORM.value='${item.PAY_PLATFORM }';</script>
									<input type="text" name="PAY_PRICE" value="${item.PAY_PRICE }"></td>
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
			if($(f).find('select[name="PLAN_CODE"]').val()==''){
				alert("주문상품을 선택해주세요.");
				return false;
			}
			if($(f).find('select[name="DATE_TYPE"]').val()==''){
				alert("기간을 선택해주세요.");
				return false;
			}
			if($(f).find('input[name="EXITS_DATE"]').val()==''){
				alert("기간을 선택해주세요.");
				return false;
			}
			if($(f).find('input[name="PAY_PLATFORM"]').val()==''){
				alert("결제플랫폼을 선택해주세요.");
				return false;
			}
			if($(f).find('input[name="PAY_PRICE"]').val()==''){
				alert("금액을 입력해주세요.");
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
            	alert("관리자에게 문의하세요.");
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
});
</script>

</html>