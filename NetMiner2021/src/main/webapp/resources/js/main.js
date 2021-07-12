var checkRandomNumber = false;
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
			checkRandomNumber = true;
			document.getElementById('code').readOnly = true
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
		$(function(){
			$.ajax({
				url : "./goBack",
				type : "GET",
				success : function (data) {
					sessionStorage.clear();
					window.history.back();
				}
			})
		})
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
		if (CheckEmailRegx(emailValue)) {
			emailStyle.style.background = "#203864";
			$("#checkEmailBtn").attr('disabled', false);
		} else {
			emailStyle.style.background = "#bbb8b8";
			$("#checkEmailBtn").attr('disabled', true);
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
		var regExp= /^[0-9a-zA-Z]{4,20}$/i;
		if (pwdVal.match(regExp)!= null) {
			var numberExp = /^[0-9]{4,20}$/i
			var strExp = /^[a-zA-Z]{4,20}$/i
			if (pwdVal.match(numberExp)!= null || pwdVal.match(strExp)) {
				alert("하나또는 두개이상의 문자혹은 숫자로 이루어져야합니다.");
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
		alert("회원정보를 입력해주세요");
	} else {
		if (checkRegx) {
		checkRegx = CheckPwd(userpwd);
			if (!checkRegx) {
				alert("비밀번호 형식이 맞지 않습니다.");
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
													alert("이메일 전송 실패");
													window.location.href = "./register";
												} else{
													sessionStorage.setItem("randomNumber", data.randomNumber);
													sessionStorage.setItem("email", userId);
													alert(userId + "로 발송완료 했습니다.");
													window.location.href= "./moveCheckEmail";					
												}
											} 
											
										})
									});
						} else {
							alert ("이미 가입된 이메일 주소입니다.");
						}
					}
				});
		
			})
			}
		} else {
			alert("이메일 형식이 맞지 않습니다.");
			 $("#email").focus();
		} 
	
	}
	
}

function register() {
	var marketYn = "N";
	var check1 = $("#check1").prop("checked");
	var check2 = $("#check2").prop("checked");
	var check3 = $("#check3").prop("checked");
	if (checkRandomNumber) {
		if (check1 != true || check2 != true) {
			alert("필수약관에 동의 해주세요");
		} else {
			if (check3 == true) {
				marketYn = "Y";
			}
			
			var email = sessionStorage.getItem("email");
			var con = document.getElementById("dimmed");
				con.style.removeProperty("display");
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
	} else {
		alert("인증번호를 입력해주세요");
	}
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
		alert("필수약관에 동의 해주세요");
	} else {
		if (""== company || ""== nation) {
			alert("회원 정보를 모두 입력해주세요");
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
						alert("회원가입 완료");
						window.location.href= "./";
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
		alert("이메일을 입력해 주세요");
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
							alert("해당 유저는 구글 유저로 비밀번호변경이 불가능합니다.");
							window.history.back();
						} else {
							if (data.userId == "") {
								alert("해당 유저로 가입된 이력이 없습니다.");
								window.location.href="./register";
							} else {
								alert("이메일 발송이 완료 되었습니다.");
								window.location.href="./login";
							}							
						}
					}
						
				})
			});
			
		} else {
			alert("이메일의 형식이 맞지 않습니다.");
		}
	}
	
}

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
						alert("비밀번호가 성공적으로 변경 되었습니다.");
						window.location.href= "./login";
					}
						
				})
			});
		} else {
			alert("비밀번호가 틀립니다.");
		}
	} else {
		alert("비밀번호 형식이 맞지 않습니다.")
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
	var checkRegx = CheckEmailRegx(email);
	var emailBtn = document.getElementById("chageUserId");
	if (checkRegx) {
		$(function (){
			$.ajax({
				url : "./chageUserId",
				type : "POST",
				data : {'email' : email},
				success : function(data) {
					sessionStorage.clear();
					if (data.state == 'success') {
						emailBtn.style.background = "#bbb8b8";
						$("#chageUserId").attr('disabled', true);
						$("#email").attr('readOnly', true);
						alert("이메일 변경 완료");						
					} else {
						alert("해당 아이디는 이미 존재 합니다");
					}
				}
			})
		});
	} else {
		alert("이메일 형식이 맞지 않습니다.");
		 $("#email").focus();
	}
}

function registerCheckEmail(){
	sessionStorage.clear();
	window.location.href="./registerCheckEmail";
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
			alert("회원정보를 입력해주세요");
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
						 	alert("회원정보가 성공적으로 변경 되었습니다.");
							window.location.href="./";
						}
						
					})
				});		
		}
	} else {
		
		var checkRegx = CheckEmailRegx(userId);	
		
		if (userId=="" || userpwd =="" || company == "" || nation =="" || useCode=="") {
			if (userpwd =="") {
				alert("안전한 회원정보 수정을 위해 비밀번호를 입력해주세요");
			}else {
				alert("회원정보를 입력해주세요");		
			}
		} else {
			if (checkRegx) {
			checkRegx = CheckPwd(userpwd);
				if ( ! checkRegx) {
					alert("비밀번호 형식이 맞지 않습니다.");
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
						 	alert("회원정보가 성공적으로 변경 되었습니다.");
							window.location.href="./";
						}
						
					})
				});			
				}
			} else {
				alert("이메일 형식이 맞지 않습니다.");
				 $("#email").focus();
			}
			
		}
	}
};

function newRandomNumber() {
	var userId = sessionStorage.getItem("email");
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
					sessionStorage.setItem("randomNumber", data.randomNumber);
					alert("인증번호 재전송 되었습니다.");
					con.style.display = 'none';
					location.reload();
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
			}
			
		})
		var path = $(location).attr('pathname');
		window.location.href = path;
	})
}

