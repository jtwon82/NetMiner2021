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
				'email': userId,
				'pwd' : userpwd,
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
			url :"./registerStep",
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
function googleLogin(){
	var redirectLocal = "http://localhost:8080/app/auth";
	var redirectPrd="http://ec2-3-36-122-128.ap-northeast-2.compute.amazonaws.com/NetMiner2021/auth";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectLocal+"&response_type=code&scope=email%20profile%20openid&access_type=offline";
	
}


function registerSns(pwd) {
	console.log(pwd);
	var userId = $("#email").val();
	var userpwd = pwd;
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="useCode"]:checked').val();
	var marketYn = "N";
	
	if ($('input:checkbox[name="marketYn"]').is(":checked") == true) {
		marketYn = "Y";
	}
	
	$(function(){
		$.ajax({
			url :"./registerSNS",
			type:"POST",
			data:{
				'email': userId,
				'pwd' : userpwd,
				'company' : company,
				'nation' : nation,
				'useCode' : useCode,
				'marketYn': marketYn 
			},
			success: function (data){
				alert("회원가입 완료");
				window.location.href= "./";
			} 
			
		})
	});
}
function googleRegister() {
	var redirectLocal = "http://localhost:8080/app/socialRegister";
	var redirectPrd="http://ec2-3-36-122-128.ap-northeast-2.compute.amazonaws.com/app/socialRegister";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectLocal+"&response_type=code&scope=email%20profile%20openid&access_type=offline";
}

function resetPwd() {
	var userId = $("#email").val();
	
	$(function (){
		$.ajax({
			url:"./resetPwd",
			type:"POST",
			data:{'email': userId},
			success : function (data){
				console.log(data);
			}
				
		})
	});
}



