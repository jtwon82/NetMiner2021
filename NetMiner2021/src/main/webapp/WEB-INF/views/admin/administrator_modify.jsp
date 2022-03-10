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
						<form id="Form" name="Form" method="post" action="/admin/administrator_modify/check">
						<input type="hidden" name="MODE">
						<input type="hidden" name="NO" readOnly value="${item.NO }">
						<table class="modify">
							<colgroup>
								<col width="15%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>가입일시</td>
									<td>${item.REG_DATES }</td>
								</tr>
								<tr>
									<th>ID</td>
									<td><input type="text" name="ADMIN_ID"  value="${item.ADMIN_ID }"></td>
								</tr>
								<tr>
									<th>비밀번호</td>
									<td><input type="password" name="ADMIN_PWD" value=""></td>
								</tr>
								<tr>
									<th>설명</td>
									<td><input type="text" name="DESCRIPTION" value="${item.DESCRIPTION }"></td>
								</tr>
							</tbody>
						</table>
						<div class="finish">
							<c:if test="${item.NO!='' }">
							<button class="red" onclick="this.form.MODE.value='delete';" style="float: left">삭제 </button>	
							</c:if>					
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
		</div>
	</body>
<script type="text/javascript">
$(function(){
	$('form').submit(function(event){
		var f= document.Form;
		switch(f.MODE.value){
		case "cancel":
			history.go(-1);
			break;
			
		case "insert": case "modify" : case "delete":
			return true;
			break;
		}
		
		event.preventDefault();
		return false;
	}).ajaxForm({
		dataType: 'json',
        beforeSubmit: function (data,form,option) {
            //validation체크 
        	if(form.find('input[name="ADMIN_ID"]').val()==''){ alert("아이디를 입력해주세요.");	return false;	}
//         	if(form.find('input[name="ADMIN_PWD"]').val()==''){ alert("비밀번호를 입력해주세요.");	return false;	}
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            console.log(response);
            if('SUCCESS'==response.result){
            	alert("정상 처리되었습니다.");
				location.href='administrator';
    			
            }else{
            	alert("존재하지 않는 계정이거나 비밀번호가 올바르지 않습니다. 관리자에게 문의하세요.");
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	$('input[name="id"]').focus();
});
</script>
</html>