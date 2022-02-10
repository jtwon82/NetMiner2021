var checkRandomNumber = false;
var now = new Date();
$(document).ready(function() {
	/*
	if (location.pathname == '/login_dev') {
		$("#register").remove("onclick");
		$("#register").attr("onclick","window.location.href='./register'");
		$(".google").remove("onclick");
		$(".google").attr("onclick","googleLogin()");
	} 
	*/
	//pricing 자주하는 질문
	$("#wrap.pricing #section2 .content ul li .question").click(
		function(){
			$(this).next().toggleClass("active");
			$(this).children().toggleClass("fold");
		}
	);
	// 체크박스 전체 선택
		$(".agree").on("click", "#check_all", function () {
		    $(this).parents(".content").find('.agree input').prop("checked", $(this).is(":checked"));
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
		window.location.reload();
	});
//	$("#check").change(function (){
//		if ($('input:checkbox[name="marketYn"]').is(":checked") == true) {
//			openPoup("agree_popup");
//		}
//		
//		if ($('input:checkbox[name="marketYn"]').is(":checked") == false) {
//			openPoup("refuse_popup");
//		}
//	});
	$("#authentic").click(function(){		
		location.href = document.referrer;
	})
	$(".cancel").click(function (){
		sessionStorage.clear();
		window.location.href = "/account";
	});
	
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
	
	$(".signOut a").click(function(){
		sessionStorage.clear();
		window.location.href="./logOut";
	});

	$(".content .input li #email").on('input',function(){
		var emailValue = $("#email").val();
		var emailStyle = document.getElementById("checkEmailBtn");
		if (emailStyle != '' && emailStyle != null) {
			if (CheckEmailRegx(emailValue)) {
				emailStyle.style.background = "#203864";
				$("#checkEmailBtn").attr('disabled', false);
			} else {
				emailStyle.style.background = "#bbb8b8";
				$("#checkEmailBtn").attr('disabled', true);
			}
		}
	})
	
	$("#leaveBtn").click(function(){
		openPoup("leave_popup");
	})
	
	history.replaceState({}, null, location.pathname);	
})
var emailNumber = "";

function changeBtnColor(){
	if ($("#newemail").val() == '') {
		$("#emailVerifyBtn").css("background","#bbb8b8");
	} else {
		$("#emailVerifyBtn").css("background","#203864");		
	}
}
function CheckEmailRegx(emailVal)
{
    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (emailVal.match(regExp) != null) { 
		return true;
	} else { 
		return false;
	}         

}

function CheckPwd(pwdVal) {
	var pat1= /[0-9]/;
	var pat2= /[a-zA-Z]/;
	var pat3= /[~!@#$%^&*()_+|<>?:{}]/;
	var regExp= /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
	var ergExp2= /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,20}$/;
	if (pwdVal.match(ergExp2) != null) {
		return true;
	} else {
		alert("Your password must have 8~20 characters, including at least 1 number and 1 letter.");
		return false;
	}
}


function checkEmail(){
	event.preventDefault();
	
	var userId = $("#email").val();
	var userpwd = $("#pwd").val();
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="useCode"]:checked').val();
	
	var checkRegx = CheckEmailRegx(userId);	
	
	if (userId=="" || userpwd =="" || company == "" || nation =="" || useCode=="") {
		alert("Please fill out all the fields.");
	} else {
		if (checkRegx) {
			checkRegx = CheckPwd(userpwd);
			var fd= (new FormData(document.form));
			
			if (!checkRegx) {
				$("#pwd").focus();
			} else {
				$.ajax ({
					url:"./checkUser",
					type: "POST",
					data : {
						'email' : userId
					},
					success : function (data) {
						if (data.result) {
							var con = document.getElementById("dimmed");
							con.style.removeProperty("display");
							$.ajax({
								url :"./emailSender",
								type:"POST",
								data:$(document.form).serialize(),
								success: function (data){
									if ("" == data.randomNumber) {
										alert("Email sending failed");
										//window.location.href = "./register";
									} else{
										alert("We've sent you an email to " + userId + ".");
										window.location.href= "./moveCheckEmail?userId="+userId;					
									}
								} 
							})
						} else {
							alert ("This email address already exists.");
						}
					}
				});
			}
		} else {
			alert("Email format is incorrect.");
			 $("#email").focus();
		} 
	}
}

function register(userId) {
	var marketYn = "N";
	var code = $("#code").val();
	var check1 = $("#check1").prop("checked");
	var check2 = $("#check2").prop("checked");
	var check3 = $("#check3").prop("checked");
	if (check3 == true)marketYn = "Y";
	
	if(code==""){
		alert("Please enter a valid code.");
		return;
	}
	if (check1 != true || check2 != true) {
		alert("Please agree to the terms and condition.");
		return;
	}
	
	$.ajax({
		url : "./checkRandomNumber",
		data : {"email": userId , "randomNumber" : code},
		type : "POST" ,
		success : function (data) {
			if (data.result == 'codeFail') {
				alert("Please enter a valid code.");
				
			} else if (data.result == 'timeOver'){
				alert("Your validation code is currently invalid. Please request a new validation code.");
				
			} else {
				var email = userId;
				var con = document.getElementById("dimmed");
					con.style.removeProperty("display");
					$.ajax({
						url :"./registerStep",
						type:"POST",
						data:{
							'email':email, 'marketYn': marketYn 
						},
						success: function (data){
							alert("You've successfully verified your email address.");
							window.location.href= "./registerComplete";
						}
					})
				}
			}
		})
}
function googleLogin(){
	event.preventDefault();
//	var redirectLocal = "http://localhost:8080/auth";
//	var redirectPrd="https://www.netminer365.com/auth";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectAuth+"&response_type=code&scope=email%20profile%20openid&access_type=offline";
}

function googleRegister() {
	event.preventDefault();
//	var redirectLocal = "http://localhost:8080/socialRegister";
//	var redirectPrd="https://www.netminer365.com/socialRegister";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectRegister+"&response_type=code&scope=email%20profile%20openid&access_type=offline";
}


function registerSns(pwd) {
	event.preventDefault();
	var userId = $("#email").val();
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="useCode"]:checked').val();
	var marketYn = "N";
	var check1 = $("#check1").prop("checked");
	var check2 = $("#check2").prop("checked");
	var check3 = $("#check3").prop("checked");
	if (check1 != true || check2 != true) {
		alert("Please agree to the terms and condition.");
	} else {
		if (""== company || ""== nation) {
			alert("Please enter all member information");
		} else {
			if (check3 == true) {
				marketYn = "Y";
			}
			var con = document.getElementById("dimmed");
				con.style.removeProperty("display");
			$(function(){
				$.ajax({
					url :"./registerSNS",
					type:"POST",
					data: $(document.form).serialize(),
					success: function (data){
						if(data.state=='success'){
							window.location.href= "./registerComplete";
						} else {
							alert("Please enter all member information");
						}
					} 
					
				})
			});
			
		}
		
	}
	
}

function changeRegister(){
	
}


$(document).on('click', '.emailChangeBtn', function(e){
	$("#section li.email").hide();
	$("#section li.email.new").show();
	$("#newemail").focus();
	changePwd2BtnChangeCancel();
});
$(document).on('click', '.emailCancelBtn', function(e){
	$("#section li.email").hide();
	$("#section li.email.old").show();
});
function changeEmail() {
	var email = $("#newemail").val();
//	if (userId == email){
//		email = userId;
//	}
	if(email==''){
		alert("Please enter your email in order to save changes.");
		$("#newemail").focus();
		return;
	} else if (!CheckEmailRegx(email)){
		alert("Please enter a valid email address.");
		$("#newemail").focus();
		return;
	}
	 var con = document.getElementById("dimmed");
		con.style.removeProperty("display");
		$.ajax({
			url:"./checkUser",
			type :"POST",
			data : {
						'email' : email
			},
			success : function (data) {
				if (!data.result) {
					alert("This email address already exists.");
					window.location.reload();
				} else {
					$.ajax({
						url:"./changeEmail",
						type:"POST",
						data:{'email':email},
						success : function (data) {
							if (data.randomNumber != "") {
								alert("We've sent you an email to "+email+".");
								window.location.href="./goCheckEmail?userId="+email;					
							} else {
								alert("Email sending failed");
								window.location.reload();
							}
						}
					});
				}
			}
		})
}

function registerCheckEmail(userId){
	var code = $("#code").val();
	if (code == '') {
		alert("Please Enter Verity Code");
	} else {
	
		$(function(){	
			$.ajax({
			url : "./checkRandomNumber",
			data : {"email": userId , "randomNumber" : code},
			type : "POST" ,
			success : function(data) {
					if (data.result == 'codeFail') {
						alert("Please enter a valid code.");
						
					} else if (data.result == 'timeOver'){
						alert("The current authentication number has expired. please reissue");
						
					} else {
						window.location.href="./registerCheckEmail?userId="+userId;
						
					}
				}
			})
		})
	}
}

function updateUserInfo(googleYn){
	
	var userId = $("#email").val();
	var userpwd = $("#pwd").val();
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="c1"]:checked').val();
	var marketYn = "N";
	
	$(".emailCancelBtn").click();
	changePwd2BtnChangeCancel()
	
	if ($('input:checkbox[name="marketYn"]').is(":checked") == true) {
		marketYn = "Y";
	}
	if (googleYn == 'Y') {
		if (company == "" || nation =="" || useCode==""){
			alert("Please enter member information");
		} else {
			$(function (){
					$.ajax({
						url : "./updateUserInfo",
						type : "POST",
						data : {
//							'userId': userId,
							'company' : company,
							'nation' : nation,
							'useCode' : useCode,
							'marketYn': marketYn
						},
						success : function (data) {
							if (data.state == "fail") {
								alert("The password is incorrect.");
							} else {
							 	alert("Your profile has been saved successfully.");
								//window.location.href="./";						
								location.reload();
							}
						}
						
					})
				});		
		}
	} else {
		
		var checkRegx = CheckEmailRegx(userId);	
		
		if (userId=="" || userpwd =="" || company == "" || nation =="" || useCode=="") {
			if (userpwd =="") {
				alert("Please enter your password in order to save changes.");
			}else {
				alert("Please enter member information");		
			}
		} else {
			if (checkRegx) {
			checkRegx = CheckPwd(userpwd);
				if ( ! checkRegx) {
					$("#pwd").focus();
				} else {
					
					$(function (){
					$.ajax({
						url : "./updateUserInfo",
						type : "POST",
						data : {
//							'userId': userId,
							'userPwd' : userpwd,
							'company' : company,
							'nation' : nation,
							'useCode' : useCode,
							'marketYn': marketYn
						},
						success : function (data) {
							if (data.state == "fail") {
								alert("The password is incorrect.");
							} else {
							 	alert("Your profile has been saved successfully.");
								//window.location.href="./";								
								location.reload();
							}
						}
						
					})
				});			
				}
			} else {
				alert("Email format is incorrect.");
				 $("#email").focus();
			}
			
		}
	}
};

function newRandomNumber(userId) {
	var con = document.getElementById("dimmed");
			con.style.removeProperty("display");
	$(function (){
		$.ajax({
			url : "./sendNewRandom",
			type : "POST",
			data : {
				'email' : userId				
			}, 
			success : function(data) {
				if (data.result==0) {
					alert("We've sent you an email to "+ userId + ".");
					con.style.display = 'none';
					
				} else if (data.result == 'timeOver'){
					alert("Your validation code is currently invalid. Please request a new validation code.");
					window.location.href="./";
				}
			}
			
		})
	})
	
}
function delteUser () {
	var con = document.getElementById("dimmed");
			con.style.removeProperty("display");
	$(function (){
		$.ajax({
			url : "./delteMember",
			type : "POST",
			success : function(data) {
				if (data.result == 'fail') {
					$(".popup").hide();
					$("body").css("overflow-y","hidden");
					$("#leave_hold_popup").fadeIn();
					
				} else {
					window.location.href="./";
				} 
			}
			
		})
	})
}

























function changeLanguage(language) {
	$(function (){
		$.ajax({
			url : "./changeLanguage",
			type : "POST",
			data : {"language" : language},
			success : function(data) {
				var path = $(location).attr('pathname');
				window.location.href = path;
			}
			
		})
	})
}

function setNowDate(){
	$.ajax({
		url :"./getNow",
		type : "GET",
		success : function (data) {
			now = data.nowDateTime;
		}
	})
}

// findUserInfo
function requestSetPwd() {
	var userId = $("#email").val();
	var checkRegx = CheckEmailRegx(userId);

	if (userId == "") {
		alert("Please enter your e-mail");
	} else {
		
		if (checkRegx) {
			 var con = document.getElementById("dimmed");
			 con.style.removeProperty("display");
			$(function (){
				$.ajax({
					url:"./findUserInfo",
					type:"POST",
					data:{'email': userId},
					success : function (data){
						/*해당 유저의 아디 값이 있으면 메일 전송 없으면 alert 창으로 가입여부 후 확인시 가입창으로 */
						//console.log(data);
						if (data.googleYn == 'Y') {
							alert("If you signed up with google, you cannot change your password. Please sign-in with google account.");
							window.history.back();
						} else {
							if (data.userId == "") {
								alert("This email address is not registered.");
								window.location.href="./register";
							} else {
								alert("We've sent you an email to "+ userId);
								window.location.href="./login";
							}							
						}
					}
				})
			});
			
		} else {
			alert("Email is not formatted properly.");
		}
	}
}
// findUserInfo
function changePwd(userId){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	var checkRegx = CheckPwd(newPwd);

	if (checkRegx) {
		if (newPwd == newPwd2) {	
			$(function (){
				$.ajax({
					url:"./changeNewPwd",
					type:"POST",
					data:{'email': userId , 'pwd':newPwd},
					success : function (data){
						sessionStorage.clear();
						alert("Your password has been changed successfully.");
						window.location.href= "./login";
					}
						
				})
			});
		} else {
			alert("The password is wrong.");
		}
	} else {
		alert("The password format is incorrect.")
		$("#newPwd").focus();
	}
}

function changePwd2BtnChange(userid){
	$("#section .pwd.new input").val('');
	$("#section .pwd.new button").css("background-color", "#bbb8b8");
	
	if($("#pwd").val()==""){
		alert("Please enter the current password.");
		$("#pwd").focus();
		
	} else {
		$(".emailCancelBtn").click();
		
		$.ajax({
			url:"./chkUserInfoPwdProc",
			type:"POST",
			data:{'email': userid
				, 'pwd': $("#pwd").val()
				}
			,success : function (data){
				if(data.result==0){
					$("#section .pwd.new").removeClass('h');
					$("#section .pwd.new:eq(0) input").focus();
					
					$("#section .pwd.old button:eq(0)").addClass('h');
					$("#section .pwd.old button:eq(1)").removeClass('h');
					
					$(".update").addClass('h');
					
				} else {
					alert("Please enter the password.");
				}
			}
		});
	}
	
}

function changePwd2BtnChangeCancel(){
	$("#section .pwd.new").addClass('h');

	$("#section .pwd.old button:eq(0)").removeClass('h');
	$("#section .pwd.old button:eq(1)").addClass('h');

	$("#pwd").val('');
	$("#section .pwd.new:eq(0) input").val('');
	$("#section .pwd.new:eq(1) input").val('');
}

$(document).on('keyup', '.pwd.new input:eq(1)', function(e){
	var pwd= $('.pwd.new input:eq(0)').val();
	var pwd2= $('.pwd.new input:eq(1)').val();
	if( pwd==pwd2 ){
		$(this).next().css("background-color", "#203864");
	} else {
		$(this).next().css("background-color", "#bbb8b8");
	}
});

function changePwd2BtnChangeAct(userId){
	var newPwd = $("#section .pwd.new:eq(0) input").val();
	var newPwd2 = $("#section .pwd.new:eq(1) input").val();
	var checkRegx = CheckPwd(newPwd2);

	if(newPwd!=newPwd2){
		alert("Please check the password.");
		$("#section .pwd.new:eq(1) input").focus();
		
	} else if (checkRegx) {
		$.ajax({
			url:"./changeNewPwd2",
			type:"POST",
			data:{'email': userId , 'pwd':$("#pwd").val(), 'pwd2':newPwd2},
			success : function (data){
				if(data.result=='o'){
					sessionStorage.clear();
					alert("Your password has been changed successfully.");
					location.reload();
					
				} else{
					alert("Current password is incorrect.");
				}
			}
		})
	} else {
		$("#newPwd").focus();
	}
}

