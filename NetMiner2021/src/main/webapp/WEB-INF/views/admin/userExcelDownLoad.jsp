<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
		<script src="/resources/admin/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="/resources/admin/js/swiper.min.js" type="text/javascript"></script>
		<script src="/resources/admin/js/gnb.js?st=2" type="text/javascript"></script>
		<script src="/resources/admin/js/jquery.form.js?st=2" type="text/javascript"></script>
</head>
<script type="text/javascript">
$(function (){

const excelDownload = document.querySelector('#excelDownload');

$(function exportExcel(){ 
  // step 1. workbook 생성
  var wb = XLSX.utils.book_new();

  // step 2. 시트 만들기 
  var newWorksheet = excelHandler.getWorksheet();

  // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
  XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

  // step 4. 엑셀 파일 만들기 
  var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

  // step 5. 엑셀 파일 내보내기 
  saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
	window.history.back();
})

var excelHandler = {
    getExcelFileName : function(){
        return 'USER_INFO_'+'${fileName}'+'.xlsx';	//파일명
    },
    getSheetName : function(){
        return '${sheetName}';	//시트명
    },
    getExcelData : function(){
        return document.getElementById('result'); 	//TABLE id
    },
    getWorksheet : function(){
        return XLSX.utils.table_to_sheet(this.getExcelData());
    }
}

function s2ab(s) { 
  var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
  var view = new Uint8Array(buf);  //create uint8array as viewer
  for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
  return buf;    
}
})
</script>
<body>
	<table class='main' id ="result" style="display: none;">
		<thead>
			<tr>
									<th>NO</th>
									<th>UUID</th>
									<th>가입일시</th>
									<th>타입구분</th>
									<th>용도구분</th>
									<th>이용현황</th>
									<th>트라이얼</th>
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
					<tr>
											<td>${item.ROWCNT }</td>
											<td>${item.UUID }</td>
											<td>${item.REG_DATES }</td>
											<td>${item.TYPE_CODE_STR }</td>
											<td>${item.USE_CODE_STR }</td>
											<td>${item.SC_PLAN_CODE_STR }</td>
											<td>${item.FREE_YN }</td>
											<td>${item.USER_ID }</td>
											<td>${item.LANGUAGE }</td>
											<td>${item.NATION_NAME_KR }</td>
											<td>${item.COMPANY }</td>
											<td>${item.MARKET_YN }</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</body>
</html>