$(document).ready(function() {
//header
	//메뉴

	$("#wrap #top .menu span").on("mouseenter", 
	function() { 
		$("#wrap #top .menu ul").fadeIn(); 
		$(this).addClass("active");
	})
	$("#wrap #top .menu").on("mouseleave", 
	function() { 
		$("#wrap #top .menu ul").fadeOut(); 
		$("#wrap #top .menu span").removeClass("active");
	})
	//모바일메뉴
	$("#navBtn").click(function() {
		$("#navOn").fadeIn();
	});
	$(".navClose, #navOn .bg").click(function() {
		$("#navOn").fadeOut();
	});

	//스크롤시 헤더 고정
	if($(window).width() >1000){
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
	}
		
	
	//로그인 후 메뉴
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