<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>

	<body OnUnload="location.href='logout'">
		<div id="wrap" class="user">
<%@ include file = "top_gnb.jsp" %>

			<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>이용자</h2>
					</div>
					<div class="content">
						<div class="filter">
							<form id="Form" method="get" action="/admin/user">
							<ul>
								<li>
									<span>이용자 검색</span>
									<select id="SEARCH_KEY" name="SEARCH_KEY">
										<option value="" >컬럼</option>
										<option value="USER_ID">이메일</option>
										<option value="COMPANY">소속</option>
									</select>
									<div class="search">
										<input type="text" name="SEARCH_VALUE" value="${json.SEARCH_VALUE }">
									</div>
								</li>
								<li>
									<span><input type="checkbox" id='FILTER1' name='FILTER1' class='filter_chkbox' value='1'>필터링</span>
									<select id="USE_CODE" name="USE_CODE" disabled="disabled" class='filter filter1'>
										<option value="" >용도</option>
										<option value="01">Academic</option>
										<option value="02">Commercial</option>
									</select>
									<select id="LANGUAGE" name="LANGUAGE" disabled="disabled" class='filter filter1'>
										<option value="" >언어</option>
										<option value="ko">Korean</option>
										<option value="en">English</option>
									</select>
									<select id="MARKET_YN" name="MARKET_YN" disabled="disabled" class='filter filter1'>
										<option value="" >수신동의</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
								</li>
								<li>
									<span><input type="checkbox" id='FILTER2' name='FILTER2' class='filter_chkbox' value='2'>가입기간</span>
									<input type="date" id="start" name='SDATE' value="${json.SDATE}" disabled="disabled" class='filter filter2'>~ 
									<input type="date" id="finish" name='EDATE' value="${json.EDATE}" disabled="disabled" class='filter filter2'>
								</li>
							</ul>
							<button class="finalSearch navy">검색</button>
							</form>
<script type="text/javascript">
	$(".filter_chkbox").change(function(e){
		$(".filter"+this.value).prop('disabled', 'disabled');
		if(this.checked){
			$(".filter"+this.value).prop('disabled', '');
		} else{
			$(".filter"+this.value).prop('disabled', 'disabled');
		}
	});
	if('${json.FILTER1}'=='1')	$("#FILTER1").click();
	if('${json.FILTER2}'=='2')	$("#FILTER2").click();
	
</script>
<script type="text/javascript">SEARCH_KEY.value='${json.SEARCH_KEY}';</script>
<script type="text/javascript">USE_CODE.value='${json.USE_CODE}';</script>
<script type="text/javascript">LANGUAGE.value='${json.LANGUAGE}';</script>
<script type="text/javascript">MARKET_YN.value='${json.MARKET_YN}';</script>

						</div>
						<table class="main">
							<colgroup>
								<col width="12%">
								<col width="14%">
								<col width="*">
								<col width="12%">
								<col width="12%">
								<col width="12%">
								<col width="12%">
							</colgroup>
							<thead>
								<tr>
									<th>가입일시</th>
									<th>용도</th>
									<th>이메일</th>
									<th>언어</th>
									<th>국가</th>
									<th>소속</th>
									<th>수신동의</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty list }">
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr onclick="location.href=('user_modify?NO=${item.NO}')">
											<td>${item.REG_DATES }</td>
											<td>${item.USE_CODE }</td>
											<td>${item.USER_ID }</td>
											<td>${item.LANGUAGE }</td>
											<td>${item.NATION }</td>
											<td>${item.COMPANY }</td>
											<td>${item.MARKET_YN }</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
						<%@ include file="paging.jsp"%>
						<div class="register">
							<button class="navy" onClick="downLoad();">다운로드</button>
							<button class="navy" onclick="location.href='user_modify'">등록</button>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	</body>
<script type="text/javascript">
function downLoad() {
	 var searchKey = SEARCH_KEY.value;
	$.ajax({
		url : "user/downLoadExcel",
		type : "POST",
		data : {
			searchKey : $(".SEARCH_VALUE").val(),
			"USE_CODE" : $(".USER_CODE").val(),
			"MARKET_YN" : $(".MARKET_YN").val(),
			"SDATE" : $(".SDATE").val(),
			"EDATE" : $(".EDATE").val()
		},
		success : function (data){
			
			var sheetName = data.sheetName;
			var fileName = data.fileName;

			var html = ''; 
			html += '<html xmlns:x="urn:schemas-microsoft-com:office:excel">'; 
			html += ' <head>';
			html += ' <meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8">';
			html += ' <xml>';
			html += ' <x:ExcelWorkbook>'; 
			html += ' <x:ExcelWorksheets>'; 
			html += ' <x:ExcelWorksheet>' 
			html += ' <x:Name>' + sheetName + '</x:Name>'; 
			html += ' <x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions>'; 
			html += ' </x:ExcelWorksheet>'; 
			html += ' </x:ExcelWorksheets>';
			html += ' </x:ExcelWorkbook>'; 
			html += ' </xml>';
			html += ' </head>'; 
			html += ' <body>';
			
			var body  = "<table class='main'><thead><tr><th>가입일시</th><th>용도</th><th>이메일</th><th>언어</th><th>국가</th><th>소속</th><th>수신동의</th></tr></thead><tbody>";				
			data.list.forEach(function (item, index, array){
					body += "<tr>";
					body += "<td>"+item.REG_DATES +"</td>";
					body += "<td>"+item.USE_CODE  +"</td>";
					body += "<td>"+item.USER_ID   +"</td>";
					body += "<td>"+item.LANGUAGE  +"</td>";
					body += "<td>"+item.NATION    +"</td>";
					body += "<td>"+item.COMPANY   +"</td>";
					body += "<td>"+item.MARKET_YN +"</td>";
					body += "</tr>";
			})
			html += body;
			html += "</tbody>";
			html += "</table>";
			html += ' </body>'; 
			html += '</html>';
			
			
			var data_type = 'data:application/vnd.ms-excel';
			 var ua = window.navigator.userAgent;
			 var blob = new Blob([html], {type: "application/csv;charset=utf-8;"});
			 if ((ua.indexOf("MSIE ") > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) && window.navigator.msSaveBlob) {
			  navigator.msSaveBlob(blob, fileName);
			 } else { 
			 var anchor = window.document.createElement('a');
			 anchor.href = window.URL.createObjectURL(blob);
			 anchor.download = "USER_INFO"+fileName;
			 document.body.appendChild(anchor);
			 anchor.click();
			 document.body.removeChild(anchor);
			 }

		}
	})  
}
// $(function(){
// 	$('form').ajaxForm({
// 		dataType: 'json',
//         beforeSubmit: function (data,form,option) {
//             //validation체크 
//             input_value = form.find('input[name="id"]').val();
//             if(input_value == ''){
//             	alert("아이디를 입력해주세요.");
//             	return false;
//             }
            
//             return true;
//         },
//         success: function(response,status){
//             //성공후 서버에서 받은 데이터 처리
//             console.log(response);
//             if('SUCCESS'==response.result){
//     			location.replace("/admin/login/confirm");
    			
//             }else if('DUPLICATE'==response.result){
//             	if(confirm("이미 접속중입니다. 기존의 접속을 종료하시겠습니까?"))
//             		location.replace("/admin/login/disconnect");
//             	else
//             		location.replace("/admin");
            	
//             }else{
//             	alert("존재하지 않는 계정이거나 비밀번호가 올바르지 않습니다. 관리자에게 문의하세요.");
//             }
//         },
//         error: function(){
//         	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
//         }                               
//     });
// 	$('input[name="id"]').focus();
// });
</script>
</html>