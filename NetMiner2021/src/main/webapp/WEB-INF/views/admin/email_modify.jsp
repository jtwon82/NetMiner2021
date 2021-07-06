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
						<ul>
							<li>
								<span>이메일 제목</span>
								<input type="text" value="${item.TITLE}">
							</li>
							<li>
								<span>설명</span>
								<input type="text" value="${item.EXPLAIN}">
							</li>
						</ul>
						<div id="editor-area"></div>
						<textarea id="editordata" name="editordata" style="display:none;">${item.COMMENT}</textarea>
					<div class="delete">
						<button class="red">삭제</button>
					</div>
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

        $("#editor-area").summernote("code", $("#editordata").val());
        //$('#summernote').summernote('insertText',"");
    });

   /*  function uploadImageFile(file, editor) {
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