<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "top.jsp" %>
<link rel="stylesheet" href="/resources/admin/css/summernote/summernote-lite.css">
<body OnUnload="location.href='logout'">
<div id="wrap" class="email_modify">
	<%@ include file = "top_gnb.jsp" %>
	<div id="section">
				<div class="wrap">
					<div class="title">
						<h2>자동 이메일</h2>
					</div>
					<div class="content">
					<form id="Form" name="Form" method="post" action="/admin/email_modify/check">
					<input type="hidden" name="MODE" style="display:none;">
					<input type="hidden" name="NO" readOnly value="${item.NO }" style="display:none;">
					<input type="hidden" name="EMAIL_CODE" readOnly value="${item.EMAIL_CODE }" style="display:none;">
						<ul>
							<li>
								<span>이메일 제목</span>
								<input type="text" value="${item.TITLE}" name="TITLE">
							</li>
							<li>
								<span>설명</span>
								<input type="text" value="${item.EXPLAIN}" name="EXPLAIN">
							</li>
						</ul>
						<div id="editor-area"></div>
						<textarea id="COMMENT" name="COMMENT"  style="display:none;">${item.COMMENT}</textarea>
						
					<div class="delete">
						<button class="red" onclick="this.form.MODE.value='delete';">삭제</button>
					</div>
						<div class="finish">
							<button onclick="this.form.MODE.value='cancel';">취소</button>
							<c:choose>
							<c:when test="${item.COMMENT!='' }">
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
	
	<script src="/resources/admin/js/summernote/summernote-lite.js"></script>
	<script src="/resources/admin/js/summernote/lang/summernote-ko-KR.js"></script>
	<script type="text/javascript">

    $(document).ready(function () {
        $("#editor-area").summernote({
            lang: "ko-KR",
            height: 500,
            callbacks: {
                onImageUpload: function (files) {
                    uploadImageFile(files[0], this);
                }
            },
            tooltip: false
        });

        $("#editor-area").summernote("code", $("#COMMENT").val());
      
    });
    $(function(){
    	
    	$('form[name="Form"]').serialize();
    	$('form').submit(function(event){
    		var f= document.Form;
    		switch(f.MODE.value){
    		case "cancel":
    			history.go(-1);
    			break;
    		case "insert": case "modify":
    			var code = $("#editor-area").summernote("code");
                $("#COMMENT").val(code);
                
    			return true;
    			break;
    		case "delete":
    			return confirm("이메일 삭제를 하시겠습니까?");
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
                	if( form.find('input[name="TITLE"]').val()=='' ){	alert('제목을 작성해주세요'); return false; }
                	if( form.find('input[name="EXPLAIN"]').val()=='' ){	alert('설명을 작성해주세요'); return false; }
                	if( form.find('textarea[name="COMMENT"]').val()=='' ){	alert('내용을 작성해주세요'); return false; }
                	
                	break;
          
                }

                return true;
            },
            success: function(response,status){
                //성공후 서버에서 받은 데이터 처리
                console.log(response);
                if('SUCCESS'==response.result){
    				alert("정상 처리되었습니다.");
    				location.href='email';
        			
                } else if (response.result == 'FIX') {
            		alert("해당 이메일은 수정만 가능합니다.");

                } else {
                	alert("자동이메일 수정이 정상적으로 처리되지 않았습니다. 관리자에게 문의하세요."); 
            	}
                
            },
            error: function(){
            	alert("자동이메일 수정이 정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
            }                               
        });
    	
    })
    /*
     function uploadImageFile(file, editor) {
        var data = new FormData();
        data.append("file", file);

        $.ajax({
            data: data,
            type: "POST",
            url: "/api/editor/upload",
            contentType: false,
            processData: false,
            success: function (json) {
                console.log(json);
                if (json.result === "SUCCESS") {
                    $(editor).summernote('insertImage', json.url);
                } else {
                    alert("업로드에 실패했습니다.");
                    return false;
                }
            }
        }); 
    }
   */
	
	</script>
</body>
</html>