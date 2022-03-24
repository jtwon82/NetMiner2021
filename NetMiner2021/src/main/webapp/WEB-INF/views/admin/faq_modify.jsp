<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class="faq_modify">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>FAQ</h2>
					</div>
					<div class="content">
						<form id="Form" name="Form" method="post" action="/admin/faq_modify/check">
						<input type="hidden" name="MODE">
						<input type="hidden" name="NO" readOnly value="${item.NO }">
						<input type="hidden" name="USER_CODE">
						<ul>
							<li>
								<span>언어</span>
									<select id="LANGUAGE" name="LANGUAGE">
										<option value="ko">국문</option>
										<option value="en">영문</option>
									</select><script>LANGUAGE.value='${item.LANGUAGE }';</script>
							</li>
							<li>
								<span>카테고리</span>
									<select id="CATE_CODE" name="CATE_CODE">
										<option value="01">결제</option>
										<option value="02">서비스이용</option>
										<option value="03">계정</option>
										<option value="04">일반</option>
									</select><script>CATE_CODE.value='${item.CATE_CODE }';</script>
							</li>
							<li>
								<span>제목</span>
								<input type="text" name="TITLE" value="${item.TITLE }">
							</li>
<!-- 							<li> -->
<!-- 								<span>설명</span> -->
<%-- 								<input type="text" name="DESCRIPTION" value="${item.DESCRIPTION }"> --%>
<!-- 							</li> -->
						</ul>
						<textarea id="textarea" name="CONTENT">${item.CONTENT }</textarea>
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
								<button class="navy" onclick="this.form.MODE.value='insert';">등록</button>
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
		case "insert": case "modify":
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
            case "insert": case "modify": case"recover":
				if( form.find('input[name="TITLE"]').val()=='' ){	alert('제목을 입력해주세요.'); return false; }
// 				if( form.find('input[name="DESCRIPTION"]').val()=='' ){	alert('설명을 입력해주세요.'); return false; }
				if( form.find('input[name="CONTENT"]').val()=='' ){	alert('설명을 입력해주세요.'); return false; }
        		break;
            }

            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            console.log(response);
            if('SUCCESS'==response.result){
				alert("정상 처리되었습니다.");
				location.href='faq';
    			
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