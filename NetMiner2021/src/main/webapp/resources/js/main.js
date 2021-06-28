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
	$("#check").change(function (){
		if ($('input:checkbox[name="marketYn"]').is(":checked") == true) {
			openPoup("agree_popup");
		}
		
		if ($('input:checkbox[name="marketYn"]').is(":checked") == false) {
			openPoup("refuse_popup");
		}
	});
	$(".back").click(function(){
		window.history.back();
	})
	
	var filter = "win16|win32|win64|mac";
	
	if (navigator.platform ) {	
	 if (filter.indexOf(navigator.platform.toLowerCase()) < 0) {	
		const target = document.getElementsByClassName("mobile");
		target.disabled = false;
	
	 } else {	
		const target = document.getElementsByClassName("pc");
		target.disabled = false;
	 }

}
	
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
				if ("" == data.randomNumber) {
					alert("이메일 전송 실패");
					window.location.href = "./register";
				} else{
					sessionStorage.setItem("randomNumber", data.randomNumber);
					sessionStorage.setItem("email", userId);
					window.location.href= "./moveCheckEmail";					
				}
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

	window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectPrd+"&response_type=code&scope=email%20profile%20openid&access_type=offline");
	
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

	window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectPrd+"&response_type=code&scope=email%20profile%20openid&access_type=offline");
}

function requestSetPwd() {
	var userId = $("#email").val();
	if (userId == "") {
		alert("이메일을 입력해 주세요");
	}
	
	$(function (){
		$.ajax({
			url:"./findUserInfo",
			type:"POST",
			data:{'email': userId},
			success : function (data){
				/*해당 유저의 아디 값이 있으면 메일 전송 없으면 alert 창으로 가입여부 후 확인시 가입창으로 */
				//console.log(data);
			}
				
		})
	});
}

function changePwd(userId){
	console.log(userId);
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	
	if (newPwd == newPwd2) {	
		$(function (){
			$.ajax({
				url:"./changeNewPwd",
				type:"POST",
				data:{'email': userId , 'pwd':newPwd},
				success : function (data){
					alert("비밀번호가 성공적으로 변경 되었습니다.");
					window.location.href= "./login";
				}
					
			})
		});
	} else {
		alert("비밀번호가 틀립니다.");
	}
}


function changeEmail(userId) {
	var email = $("#email").val();
	if (userId == email){
		email = userId;
	}
	
	$(function (){
		$.ajax({
			url:"./changeEmail",
			type:"POST",
			data:{'email':email},
			success : function (data) {
				if (data.randomNumber != "") {
					sessionStorage.setItem("randomNumber", data.randomNumber);
					window.location.href="./goCheckEmail";					
				} else {
					alert("이메일 전송 실패");
				}
			}
		});
	});
}

function chageUserId(){
	var email = $("#email").val();
	
	$(function (){
		$.ajax({
			url : "./chageUserId",
			type : "POST",
			data : {'email' : email},
			success : function(data) {
				alert("이메일 변경 완료");
			}
		})
	});
}

function registerCheckEmail(){
	sessionStorage.clear();
	window.location.href="./registerCheckEmail";
}

function updateUserInfo(){
	
	var userId = $("#email").val();
	var userpwd = $("#pwd").val();
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="c1"]:checked').val();
	var marketYn = "N";
	
	if ("" == userpwd || null == userpwd) {
		alert("비밀번호를 입력해 주세요");
	} else {
			$(function (){
		$.ajax({
			url : "./updateUserInfo",
			type : "POST",
			data : {
					'email': userId,
				'pwd' : userpwd,
				'company' : company,
				'nation' : nation,
				'useCode' : useCode,
				'marketYn': marketYn 				
			},
			success : function (data) {
			 	alert("회원정보가 성공적으로 변경 되었습니다.");
				window.location.href="./";
			}
			
		})
	});
	}
	

};



