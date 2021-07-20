var checkRandomNumber = false;
var now = new Date();
$(document).ready(function() {
	
	if (location.pathname == '/login_dev') {
		$("#register").remove("onclick");
		$("#register").attr("onclick","window.location.href='./register'");
		$(".google").remove("onclick");
		$(".google").attr("onclick","googleLogin()");
	} 
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
	});

	$("#check").change(function (){
		if ($('input:checkbox[name="marketYn"]').is(":checked") == true) {
			openPoup("agree_popup");
		}
		
		if ($('input:checkbox[name="marketYn"]').is(":checked") == false) {
			openPoup("refuse_popup");
		}
	});
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
		var regExp= /^[0-9a-zA-Z]{8,20}$/i;
		if (pwdVal.match(regExp)!= null) {
			var numberExp = /^[0-9]{8,20}$/i
			var strExp = /^[a-zA-Z]{8,20}$/i
			if (pwdVal.match(numberExp)!= null || pwdVal.match(strExp)) {
				alert("It must consist of one or more letters or numbers.");
				return false;
			}			
			return true;
		} else {
			return false;
		}
}


function checkEmail(){
	var userId = $("#email").val();
	var userpwd = $("#pwd").val();
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="useCode"]:checked').val();
	var checkRegx = CheckEmailRegx(userId);	
	
	if (userId=="" || userpwd =="" || company == "" || nation =="" || useCode=="") {
		alert("Please enter member information");
	} else {
		if (checkRegx) {
		checkRegx = CheckPwd(userpwd);
			if (!checkRegx) {
				alert("The password format is incorrect.");
				$("#pwd").focus();
			} else {
				$ (function (){
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
													alert("Email sending failed");
													window.location.href = "./register";
												} else{
													alert("It has been sent to " + userId);
													window.location.href= "./moveCheckEmail?userId="+userId;					
												}
											} 
											
										})
									});
						} else {
							alert ("This is an already registered email address.");
						}
					}
				});
		
			})
			}
		} else {
			alert("Email format is incorrect.");
			 $("#email").focus();
		} 
	
	}
	
}

function register() {
	var marketYn = "N";
	var code = $("#code").val();
	var check1 = $("#check1").prop("checked");
	var check2 = $("#check2").prop("checked");
	var check3 = $("#check3").prop("checked");	
	$(function(){		
		$.ajax({
			url : "./checkRandomNumber",
			data : {"email": userId , "randomNumber" : code},
			type : "POST" ,
			success : function (data) {
				if (data.result == 'codeFail') {
					alert("Please enter the verification code.");
				} else if (data.result == 'timeOver'){
					alert("The verification code has expired. please reissue.");
				} else {
					if (check1 != true || check2 != true) {
						alert("Please agree to the mandatory terms and conditions");
					} else {
						if (check3 == true) {
							marketYn = "Y";
						}			
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
							alert("Membership completed");
							sessionStorage.clear();
							window.location.href= "./registerComplete";
						} 					
					})
				}
				}
			}
			})
		})
}
function googleLogin(){
	var redirectLocal = "http://localhost:8080/auth";
	var redirectPrd="https://www.netminer365.com/auth";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectPrd+"&response_type=code&scope=email%20profile%20openid&access_type=offline";
	
	
}


function registerSns(pwd) {
	var userId = $("#email").val();
	var userpwd = pwd;
	var company = $("#company").val();
	var nation = $("#nation").val();
	var useCode = $('input:radio[name="useCode"]:checked').val();
	var marketYn = "N";
	var check1 = $("#check1").prop("checked");
	var check2 = $("#check2").prop("checked");
	var check3 = $("#check3").prop("checked");
	if (check1 != true || check2 != true) {
		alert("Please agree to the mandatory terms and conditions");
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
					data:{
						'email': userId,
						'pwd' : userpwd,
						'company' : company,
						'nation' : nation,
						'useCode' : useCode,
						'marketYn': marketYn 
					},
					success: function (data){
						alert("Membership completed");
						window.location.href= "./registerComplete";
					} 
					
				})
			});
			
		}
		
	}
	
}
function googleRegister() {
	var redirectLocal = "http://localhost:8080/socialRegister";
	var redirectPrd="https://www.netminer365.com/socialRegister";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectPrd+"&response_type=code&scope=email%20profile%20openid&access_type=offline";
}

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
							alert("The user is a Google user and cannot change the password.");
							window.history.back();
						} else {
							if (data.userId == "") {
								alert("There is no history of registering as that user.");
								window.location.href="./register";
							} else {
								alert("Email sending is complete.");
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

function changePwd(userId){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	var checkRegx = CheckPwd(newPwd);
	//var now = new Date();
	var endDate = $("#END_DATE").val();
	setNowDate();
	if(now > endDate) {
		alert("The password reset page has timed out. please proceed again");
		return;
	}
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


function changeEmail(userId) {
	
	var email = $("#email").val();
	if (userId == email){
		email = userId;
	}
	 var con = document.getElementById("dimmed");
		 con.style.removeProperty("display");
		 $(function (){		
				$.ajax({
					url:"./checkUser",
					type :"POST",
					data : {
								'email' : email
					},
					success : function (data) {
						if (!data.result) {
							alert("This Member already Exits");
							window.location.reload();
						} else {
							$.ajax({
								url:"./changeEmail",
								type:"POST",
								data:{'email':email},
								success : function (data) {
									if (data.randomNumber != "") {
										window.location.href="./goCheckEmail?userId="+email;					
									} else {
										alert("Email sending failed");
									}
								}
							});
						}
					}
				})	
			})	
}

function chageUserId(){
	var email = $("#email").val();
	var checkRegx = CheckEmailRegx(email);
	if (checkRegx) {
		$(function (){
			$.ajax({
				url : "./chageUserId",
				type : "POST",
				data : {'email' : email},
				success : function(data) {
					if (data.state == 'success') {
						$("#checkEmailBtn").css({"background": "bbb8b8"});
						$("#chageUserId").attr('disabled', true);
						$("#email").attr('readOnly', true);
						alert("Email change done");
						window.location.reload();	
					} else {
						alert("This Email already exist");
					}
				}
			})
		});
	} else {
		alert("Email format is incorrect.");
		 $("#email").focus();
	}
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
								'email': userId,
							'company' : company,
							'nation' : nation,
							'useCode' : useCode,
							'marketYn': marketYn,
							'googleYn' : googleYn 				
						},
						success : function (data) {
						 	alert("Your member information has been changed successfully.");
							window.location.href="./";
						}
						
					})
				});		
		}
	} else {
		
		var checkRegx = CheckEmailRegx(userId);	
		
		if (userId=="" || userpwd =="" || company == "" || nation =="" || useCode=="") {
			if (userpwd =="") {
				alert("Please enter your password for secure member information modification.");
			}else {
				alert("Please enter member information");		
			}
		} else {
			if (checkRegx) {
			checkRegx = CheckPwd(userpwd);
				if ( ! checkRegx) {
					alert("The password format is incorrect.");
					$("#pwd").focus();
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
							'marketYn': marketYn,
							'googleYn' : googleYn 				
						},
						success : function (data) {
						 	alert("Your member information has been changed successfully.");
							window.location.href="./";
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

function newRandomNumber(uesrId) {
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
				if (data.randomNumber != "") {
					alert("The verification code has been retransmitted.");
					con.style.display = 'none';
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
				window.location.href="./";
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
