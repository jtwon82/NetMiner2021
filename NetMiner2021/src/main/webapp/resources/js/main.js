$(document).ready(function() {
	
	
	
	// 체크박스 전체 선택
		$(".agree").on("click", "#check_all", function () {
		    $(this).parents(".content").find('input').prop("checked", $(this).is(":checked"));
		});
		
		// 체크박스 개별 선택
		$(".content").on("click", ".check", function() {
		    var is_checked = true;
		
		    $(".content .check").each(function(){
		        is_checked = is_checked && $(this).is(":checked");
		    });
		
		    $("#check_all").prop("checked", is_checked);
		});
			
	function openPoup(id){
		$(".popup").hide();
		$("body").css("overflow-y","hidden");
		$("#"+id).fadeIn();
	}
	
	$(".popup .close, .popup .closeBtn").click(function() {
		$(".popup").fadeOut();
		$("body").css("overflow-y","auto");
	});
	
	$(".content .input #code").on('input',function(){
		var randomNumber = sessionStorage.getItem("randomNumber");
		var inputNumber = $("#code").val();
		console.log(randomNumber);
		if (inputNumber==randomNumber) {
			alert("인증완료 되었습니다.");
		}
	});
})

function checkEmail (){
	var userId = $("#email").val();
	var userpwd = $("#pwd").val();
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="useCode"]:checked').val();
	
	$(function(){
		$.ajax({
			url :"./emailSender",
			type:"POST",
			data:{
				'userId': userId,
				'userpwd' : userpwd,
				'company' : company,
				'nation' : nation,
				'useCode' : useCode
			},
			success: function (data){
				sessionStorage.setItem("randomNumber", data.randomNumber);
				sessionStorage.setItem("email", userId);
				window.location.href= "./moveCheckEmail";
			} 
			
		})
	});
}

function register() {
	var marketYn = "N";
	
	if ($('input:checkbox[name="marketYn"]').is(":checked") == true) {
		marketYn = "Y";
	}
	
	var email = sessionStorage.getItem("email");
	$(function(){
		$.ajax({
			url :"./registerStep1",
			type:"POST",
			data:{
				'email':email, 'marketYn': marketYn 
			},
			success: function (data){
				alert("회원가입 완료");
				sessionStorage.clear();
				window.location.href= "./";
			} 
			
		})
	});
}

const onClickGoogleLogin = (e) => {
		window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?client_id=3052517468-u80jg09gaa920p5sm1brodn0bvm412os.apps.googleusercontent.com" +
				"&redirect_uri=http://localhost:8080/app/google/auth" +
				"&response_type=code&scope=email%20profile%20openid%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive.file&access_type=offline")
	}

const googleLoginBtn = document.getElementById("google login");
googleLoginBtn.addEventListener("click", onClickGoogleLogin) 
