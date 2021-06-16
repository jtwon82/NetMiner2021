$(document).ready(function() {
//header
	//스크롤시 헤더 고정
		window.onscroll = function() {myFunction()};
		var header = document.getElementById("top");
		
		var sticky = header.offsetTop;
		
		function myFunction() {
		  if (window.pageYOffset > sticky) {
		    header.classList.add("sticky");
		  } else {
		    header.classList.remove("sticky");
		  }
		}
	
		$("#wrap #top .me").click(function() {
			$("#wrap #top .content .mypage.type2 ul").fadeToggle();
		});

//footer
	//언어
	$("#wrap #footer .lang p").click(
		function(){
			$("#wrap #footer .lang").toggleClass("active");
		}
	);
	//패밀리사이트
	$("#wrap #footer .family p").click(
		function(){
			$("#wrap #footer .family").toggleClass("active");
		}
	);
	
	
	$(".popup .close, .popup .closeBtn").click(function() {
		$(".popup").fadeOut();
		$("body").css("overflow-y","auto");
	});
	

})