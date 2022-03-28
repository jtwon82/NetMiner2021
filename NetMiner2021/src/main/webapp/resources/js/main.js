var checkRandomNumber = false;
var now = new Date();
$(document).ready(function() {
	
	//pricing 자주하는 질문
	$("#wrap.pricing #section2 .content ul li .question").click(
		function(){
			$(this).next().toggleClass("active");
			$(this).children().toggleClass("fold");
		}
	);
		
	/*if (location.pathname == '/login_dev') {
		$("#register").remove("onclick");
		$("#register").attr("onclick","window.location.href='./register'");
		$(".google").remove("onclick");
		$(".google").attr("onclick","googleLogin()");
	} 
	*/
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
	
	/*subscribe */
	$("button[class='pay trs']").click(function (){
		if($(this).data('payplatform')=='paypal'){
			return false;
		}
		var accountRoute = $("input[name='sub2']:checked").val();
		var url = document.createElement('a');
		url.href = location.href;
			
		if (accountRoute == 'card') {
			/*카드결제시 */
			Payment['successUrl'] = url.origin +'/payment' ;
		} else {
			/*계좌 이체시*/
			Payment['successUrl'] = url.origin +'/payment';
		}
		
		Payment['failUrl'] = url.origin;
		console.log("url.origin"+ url.origin);
		Payment['tossPayments'].requestPayment(accountRoute, {
			amount: Payment['amount'],
			orderId: Payment['orderId'],
			orderName: Payment['orderName'],
			customerName: Payment['customerName'],
			successUrl: Payment['successUrl'],
			failUrl: Payment['failUrl'],
		});
	});
	
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
		alert("비밀번호는 영문 대소문자/숫자 조합, 8~20자로 설정해야 합니다.");
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
		alert("회원 가입을 위해 모든 필드를 입력해 주세요. ");
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
								data: $(document.form).serialize(),
								success: function (data){
									if ("" == data.randomNumber) {
										alert("이메일 전송 실패");
										//window.location.href = "./register";
									} else{
										alert(userId+"으로 이메일을 발송하였습니다.");
										window.location.href= "./moveCheckEmail?userId="+userId;					
									}
								} 
							})
						} else {
							alert ("이미 가입한 이메일입니다. ");
						}
					}
				});
			}
		} else {
			alert("이메일 형식이 맞지 않습니다.");
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
		alert("유효한 인증코드를 입력해 주세요.");
		return;
	}
	if (check1 != true || check2 != true) {
		alert("필수 약관에 동의해 주세요.");
		return;
	}
	
	$.ajax({
		url : "./checkRandomNumber",
		data : {"email": userId , "randomNumber" : code},
		type : "POST" ,
		success : function (data) {
			if (data.result == 'codeFail') {
				alert("유효한 인증코드를 입력해 주세요.");
				
			} else if (data.result == 'timeOver'){
				alert("인증코드가 만료되었습니다. 새 인증코드를 요청하세요.");
				
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
							alert("이메일 인증이 완료되었습니다.");
							window.location.href= "./registerComplete";
						}
					})
				}
			}
		})
}

// 구글 로그인시 프롬프트 및 파라미터설명
// https://developers.google.com/identity/protocols/oauth2/web-server#creatingclient
function googleLogin(){
	event.preventDefault();
//	var redirectLocal = "http://localhost:8080/auth";
//	var redirectPrd="https://www.netminer365.com/auth";

	window.location.href="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectAuth+"&response_type=code&prompt=select_account&access_type=offline&scope=https://www.googleapis.com/auth/userinfo.email";
}

function googleRegister() {
	event.preventDefault();
//	var redirectLocal = "http://localhost:8080/socialRegister";
//	var redirectPrd="https://www.netminer365.com/socialRegister";

	var url="https://accounts.google.com/o/oauth2/v2/auth?client_id=370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com&"
	+"redirect_uri="+redirectAuth+"&response_type=code&prompt=select_account&access_type=offline&scope=https://www.googleapis.com/auth/userinfo.email";
	window.location.href= url;
	
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
					data: $(document.form).serialize(),
					success: function (data){
						if(data.state=='success'){
							window.location.href= "./registerComplete";
						} else {
							alert("회원 정보를 모두 입력해주세요");
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
		alert("이메일 입력칸이 비어있습니다.");
		$("#newemail").focus();
		return;
	} else if (!CheckEmailRegx(email)){
		alert("올바른 이메일 형식이 아닙니다.");
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
					alert("이미 가입한 이메일입니다. ");
					window.location.reload();
				} else {
					$.ajax({
						url:"./changeEmail",
						type:"POST",
						data:{'email':email},
						success : function (data) {
							if (data.randomNumber != "") {
								alert(email+" 으로 이메일을 발송하였습니다.");
								window.location.href="./goCheckEmail?userId="+email;					
							} else {
								alert("이메일 전송 실패");
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
		alert("인증번호를 입력해 주세요");
	} else {
	
		$(function(){	
			$.ajax({
			url : "./checkRandomNumber",
			data : {"email": userId , "randomNumber" : code},
			type : "POST" ,
			success : function(data) {
					if (data.result == 'codeFail') {
						alert("인증번호가 일치하지 않습니다.");
						
					} else if (data.result == 'timeOver'){
						alert("인증번호가 만료 되었습니다. 다시 발급해주세요");
						
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
			alert("회원정보를 입력해주세요");
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
								alert("비밀번호가 올바르지 않습니다.");
							} else {
							 	alert("프로필이 수정되었습니다. ");
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
				alert("안전한 프로필 수정을 위해 비밀번호를 입력해 주세요.");
			}else {
				alert("회원정보를 입력해주세요");		
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
								alert("비밀번호가 올바르지 않습니다.");
							} else {
							 	alert("프로필이 수정되었습니다. ");
								//window.location.href="./";
							 	location.reload();
							}
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
					alert(userId+"으로 이메일을 발송하였습니다.");
					con.style.display = 'none';
					
				} else if (data.result == 'timeOver'){
					alert("인증코드가 만료되었습니다. 새 인증코드를 요청하세요.");
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
							alert("구글로 가입한 경우에는 비밀번호 변경이 불가능합니다. 구글 계정으로 로그인 하세요.");
							window.history.back();
						} else {
							if (data.userId == "") {
								alert("가입하지 않은 이메일입니다.");
								window.location.href="./register";
							} else {
								alert(userId + "으로 이메일을 발송하였습니다.");
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
						alert("비밀번호가 변경되었습니다.");
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

function changePwd2BtnChange(userid){
	$("#section .pwd.new input").val('');
	$("#section .pwd.new button").css("background-color", "#bbb8b8");
	
	if($("#pwd").val()==""){
		alert("현재 비밀번호를 입력해주세요.");
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
					alert("현재 비밀번호가 틀렸습니다.");
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
		alert("비밀번호를 확인해주세요");
		$("#section .pwd.new:eq(1) input").focus();
		
	} else if (checkRegx) {
		$.ajax({
			url:"./changeNewPwd2",
			type:"POST",
			data:{'email': userId , 'pwd':$("#pwd").val(), 'pwd2':newPwd2},
			success : function (data){
				if(data.result=='o'){
					sessionStorage.clear();
					alert("비밀번호가 변경되었습니다.");
					location.reload();
					
				} else{
					alert("현재 비밀번호가 틀립니다.");
				}
			}
		})
	} else {
		$("#newPwd").focus();
	}
}

/*Billing Script*/
/*
function subscribe(price, payType) {
	$.ajax({
		url:"./payment",
		type:"POST",
		data :{'price':price,'payType':payType},
		success : function(data) {
			if (data.result == 'success') {
				location.href = "./subscribe";
			}
		}
	
	})
}
*/



