<%@ page language="java" contentType="text/html; charset=UTF-8 "
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="top.jsp"%>
<body OnUnload="location.href='logout'">
<body>
	<div id="wrap" class="check">
		<%@ include file="top_gnb.jsp"%>
		<div id="section">
			<div class="wrap">
				<div class="title">
					<h2>점검 설정</h2>
				</div>
				<div class="content">
					<form id="Form" name="Form" method="post" action="/admin/check_modify">
					<input type="hidden" name="MODE">
						<div class="checkInput">
							<dl class="type1">
								<dt>점검 상태</dt>
								<dd>
									<div class="switchContainer">
										<label class="switch"> 
										<input type= "hidden" id="STATS_YN" name="STATS_YN" value="${list.STATS_YN}"/>
											<input type="checkbox" name="r1">										
											<span class="slider round"></span>
										</label>
										<p>OFF</p>
										<p style="display: none;">ON</p>
									</div>
									<script>
										var check = $("input[type='checkbox']");
										check.click(function() {
											$("p").toggle();
										});
										if ($("input[name='STATS_YN']").val() == 'Y') {
											$("input:checkbox[name='r1']").attr("checked" , true);
											$("p").toggle();
										}
									</script>
								</dd>
							</dl>
							<dl class="type1 date">
								<dt>시작시간</dt>
								<dd>
									<input type="date" name="START_DATE" value="${list.START_DATES}"/>
									<div class="time">
										<input placeholder="HH" type="number" name="START_HH" value="${list.START_HH}"/>시
									</div>
								</dd>
							</dl>
							<dl class="type1 date">
								<dt>종료시간</dt>
								<dd>
									<input type="date" name="END_DATE" value="${list.END_DATES}"/>
									<div class="time">
										<input placeholder="HH" type="number" name="END_HH" value="${list.END_HH}"/>시<label class="unsettled">
											<input type="checkbox" name="END_DATE_YN" value="${list.END_DATE_YN}" <c:if test="${list.END_DATE_YN eq 'Y'}"> checked="checked"</c:if> onchange=" changeInput();"/>미정</label>
									</div>
								</dd>
							</dl>
							<dl class="type2 txt">
								<dt>점검 내용 (KO)</dt>
								<dd>
									<input type="text"  name="COMMENT_KR" value="${list.COMMENT_KR}"/>
								</dd>
							</dl>
							<dl class="type2">
								<dt>점검 내용 (EN)</dt>
								<dd>
									<input type="text" name="COMMENT_EN" value="${list.COMMENT_EN}"/>
								</dd>
							</dl>
						</div>

						<div class="finish">
							<button onclick="this.form.MODE.value='cancel';">취소</button>
							<button class="navy" onclick="this.form.MODE.value='modify'">저장</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
<script type="text/javascript">
$(function (){
	$('form').submit(function(event){
		var f = document.Form
		switch (f.MODE.value) {
		case "cancel":
			history.go(-1);
			break;
		case "modify":
			var checkVal = 'N';
			if ($("input:checkbox[name='r1']").is(":checked")) {
				checkVal ='Y';
			}
			$(f).find('input[name="STATS_YN"]').val(checkVal);
			return true;
			break;
		}
		event.preventDefault();
		return false;
	}).ajaxForm({
		dataType : 'json',
		beforeSubmit : function (data, form, option) {
			var f= document.Form;
			  switch(f.MODE.value){
			  case "modify":
				  if( form.find('input[name="START_DATE"]').val()=='') { alert('시작날짜를 지정해주세요'); return false;}
				  if( form.find('input[name="START_HH"]').val()=='') { alert('시작 시간을 지정해주세요'); return false;}
				  if( form.find('input[name="END_DATE"]').val()=='' &&  
						  form.find('input[name="END_HH"]').val()=='' &&
						  $("input:checkbox[name='END_DATE_YN']").is(":checked") == false
						  ) { alert('종료시간을 지정또는 미정버튼을 클릭해주세요'); return false;}
				  if( form.find('input[name="COMMENT_KR"]').val()=='') { alert('한글 점검내용을 입력해주세요'); return false;}
				  if( form.find('input[name="COMMENT_EN"]').val()=='') { alert('영문 점검내용을 입력해주세요'); return false;}
			  }
			  return true;
		},
		success: function (response, status) {
			if('SUCCESS'==response.result){
				alert("정상 처리되었습니다.");
				location.href='check';
    			
            }else{
            	alert("적용 되지 않았습니다. 관리자에게 문의하세요.");
            }
		},
		error : function (){
			alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
		}	
	})
})
/*$("input:checkbox[name=complete_yn]").is(":checked") == true*/
function changeInput(){
	console.log($("input:checkbox[name='END_DATE_YN']").is(":checked"));
	if ($("input:checkbox[name='END_DATE_YN']").is(":checked")) {
		$("input[name='END_DATE']").val('');
		$("input[name='END_HH']").val('');
	}
	
}
</script>
</body>
</html>