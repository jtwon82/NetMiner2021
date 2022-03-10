<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
	<body OnUnload="location.href='logout'">
		<div id="wrap" class="quit_modify">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>휴면 / 탈퇴</h2>
					</div>
					<div class="content">
						<form id="Form" name="Form" method="post" action="/admin/quit_modify/check">
						<input type="hidden" name="MODE">
						<input type="hidden" name="NO" readOnly value="${item.NO }">
						<input type="hidden" name="USER_CODE">
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
									<th>USER_CODE</td>
									<td>
										<input type="hidden1" id="USER_CODE" name="USER_CODE" value="${item.USER_CODE}"/>
									</td>
								</tr>
								<tr>
									<th>구분</td>
									<td>
										<input type="hidden" id="USE_CODE" name="USE_CODE" value="${item.USE_CODE }"/>
										<label><input type="radio" name="r1" value='01' selected><span>Academic</span></label>
										<label><input type="radio" name="r1" value='02'><span>Commercial</span></label>
									</td><script>$('input:radio[name=r1]:input[value="${item.USE_CODE }"]').attr("checked", true);</script>
								</tr>
								<tr>
									<th>이메일</td>
									<td><input type="text" name="USER_ID" value="${item.USER_ID }"></td>
								</tr>
								<tr>
									<th>비밀번호</td>
									<td><input type="password" name="USER_PWD" ></td>
								</tr>
								<tr>
									<th>언어</td>
									<td>
										<select id="LANGUAGE" name="LANGUAGE">
											<option value="">선택</option>
											<option value="en">English</option>
											<option value="ko">Korean</option>
										</select><script type="text/javascript">LANGUAGE.value='${item.LANGUAGE}';</script>
									</td>
								</tr>
								<tr>
									<th>국가</td>
									<td>
										<select id="NATION" name="NATION">
											<option value="">선택</option>
											<option value="KR">Korea</option>
											<option value="EN">English</option>
										</select><script type="text/javascript">NATION.value='${item.NATION }';</script>
									</td>
								</tr>
								<tr>
									<th>소속기관</td>
									<td><input type="text" id='COMPANY' name='COMPANY' value='${item.COMPANY }'></td>
								</tr>
								<tr>
									<th>메일 수신 동의 </td>
									<td>
										<select id="MARKET_YN" name="MARKET_YN">
											<option value="">선택</option>
											<option value="Y"  selected="selected" >Y</option>
											<option value="N">N</option>
										</select><script type="text/javascript">MARKET_YN.value='${item.MARKET_YN }';</script>
									</td>
								</tr>
								<tr>
									<th>최근 수신 동의  </td>
									<c:if test="${item.MARKET_YN eq 'Y'}">
									<td>${item.MARKET_DATES }</td>
									</c:if>
									<c:if test="${item.MARKET_YN eq 'N'}">
									<td> - </td>
									</c:if>
								</tr>
								<tr>
									<th>최근 로그인</td>
									<td>${item.LAST_LOGIN_DATES }</td>
								</tr>
								<tr>
									<th>휴면/탈퇴</td>
									<td>
										<select id="USER_STATS_YN" name="USER_STATS_YN">											
											<option value="N"  selected="" >휴면</option>
											<option value="Y">탈퇴</option>
										</select><script>USER_STATS_YN.value='${item.USER_STATS_YN }';</script>
									</td>
								</tr>
								<tr>
									<th>삭제일</td>
									<td>${item.USER_OUT_DATES }</td>
								</tr>
							</tbody>
						</table>
						<div class="delete">
							<button class="red" onclick="this.form.MODE.value='recover';">복원</button>
						</div>
						<div class="finish">
							<button onclick="this.form.MODE.value='cancel';">취소</button>
							<c:choose>
							<c:when test="${item.NO!='' }">
								<button class="navy" onclick="this.form.MODE.value='modify';">수정</button>
							</c:when>
							</c:choose>
						</div>
						</form>
					</div>
					
				</div>
<script type="text/javascript">
$(function(){
	$('form').submit(function(event){
	
		var f= document.Form;
		switch(f.MODE.value){
		case "recover":
			$(f).find('input[name="USER_CODE"]').val("02");
			return true;
			break;
		case "cancel":
			history.go(-1);
			break;
		case "insert": case "modify":
			$(f).find('input[name="USE_CODE"]').val( $(f).find('input[name="r1"]:checked').val() );
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
            	if( form.find('input[name="USE_CODE"]').val()=='' ){	alert('이용용도를 선택해주세요.'); return false; }
                if( form.find('input[name="USER_ID"]').val()=='' ){		alert('이메일을 입력해주세요.'); return false; }
            	if( form.find('input[name="LANGUAGE"]').val()=='' ){	alert('언어를 입력해주세요.'); return false; }
                if( form.find('input[name="NATION"]').val()=='' ){	alert('국가를 입력해주세요.'); return false; }
                if( form.find('input[name="COMPANY"]').val()=='' ){	alert('소속기관을 입력해주세요.'); return false; }
                if( form.find('input[name="MARKET_YN"]').val()=='' ){	alert('이메일 수신동의를 선택해주세요.'); return false; }
                
        		break;
            }

            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            console.log(response);
            if('SUCCESS'==response.result){
				alert("정상 처리되었습니다.");
				location.href='user';
    			
            }else{
            	alert("존재하지 않는 계정이거나 비밀번호가 올바르지 않습니다. 관리자에게 문의하세요.");
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	$('input[name="id"]').focus();
	
	
	$(function (){
		$.ajax({
			url :"./../getNationCode",
				type:"GET",
				success: function (data){
					 var nation = data.NationVo;
					 var html ="";
					$.each(nation , function (i){
						var nationCode = nation[i].NATION_CODE;
						var nationNameKr = nation[i].NATION_NAME_KR;
						if (nationCode==data.userNationCode) {
							html += "<option value='"+nationCode+"\' selected=\'selected\'>"+nationNameKr+"</option>\n"
						} else {
						html += "<option value='"+nationCode+"\'>"+nationNameKr+"</option>\n"; 						
						}
					});
					$("#NATION").empty();
					$("#NATION").append(html);
				} 
		
		});

	})
});
</script>

</html>