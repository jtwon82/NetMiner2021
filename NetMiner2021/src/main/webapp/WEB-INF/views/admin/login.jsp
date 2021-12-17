<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
		
	<body onload="modForm.ADMIN_ID.focus();">
		<div id="wrap" class="login">
			<div id="section">
				<div class="wrap">
					<div class="content">
					<form name="modForm" id="modForm" method="post" action="/admin/login/check">
						<div class="title">
							<h2>홈페이지 관리자 시스템</h2>
						</div>
						<ul class="input">
							<li><input placeholder="아이디" type="text" name="ADMIN_ID" value=''/></li>
							<li><input placeholder="비밀번호" type="password" name="pwd" value=''/></li>
						</ul>
						<button class="login trs">로그인</button>
					</form>
					</div>
				</div>
			</div>
		</div>
	</body>
<script type="text/javascript">
$(function(){
	$('form').submit(function(event){
		
	}).ajaxForm({
		dataType: 'json',
        beforeSubmit: function (data,form,option) {
            //validation체크 
            input_value = form.find('input[name="ADMIN_ID"]').val();
            if(input_value == ''){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="pwd"]').val();
            if(input_value == ''){
            	alert("비밀번호를 입력해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            console.log(response);
            if('SUCCESS'==response.result){
    			location.replace("/admin/login/confirm");
    			
            }else if('DUPLICATE'==response.result){
            	if(confirm("이미 접속중입니다. 기존의 접속을 종료하시겠습니까?"))
            		location.replace("/admin/login/disconnect");
            	else
            		location.replace("/admin");
            	
//             }else if('LOCK'==response){
//             	alert("비밀번호 5회 실패로 계정이 잠겼습니다. 관리자에게 문의하세요.");
            	
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