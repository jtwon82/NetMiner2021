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
			type:"GET",
			data:{
				'userId':userId
			},
			success: function (data){
				var userInfo = new Object();
				userInfo.userId = userId;
				userInfo.userPwd = userpwd;
				userInfo.company = company;
				userInfo.nation = nation;
				userInfo.useCode = useCode;
				sessionStorage.setItem("randomNumber", data.randomNumber);
				sessionStorage.setItem("email", userId);
				sessionStorage.setItem("userpwd", userpwd);
				sessionStorage.setItem("company", company);
				sessionStorage.setItem("nation", nation);
				sessionStorage.setItem("useCode", useCode);
				
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
	var userPwd = sessionStorage.getItem("userpwd");
	var company = sessionStorage.getItem("company");
	var nation = sessionStorage.getItem("nation");
	var useCode =  sessionStorage.getItem("useCode");
	
	$(function(){
		$.ajax({
			url :"./registerStep1",
			type:"POST",
			data:{
				'email':email, 'pwd' :userPwd, 'company' : company , 'nation' : nation, 'useCode' : useCode, 'marketYn': marketYn 
			},
			success: function (data){
				alert("회원가입 완료");
				
				window.location.href= "./";
			} 
			
		})
	});
}
