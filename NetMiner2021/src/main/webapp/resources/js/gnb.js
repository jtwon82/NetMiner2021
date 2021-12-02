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

	
	var sticky;
	function resizeFn() {
		//스크롤시 헤더 고정
		window.onscroll = function() {myFunction()};
		header = document.getElementById("top");
		sticky = header.offsetTop;
	}
	function myFunction() {
		if($(window).width() >1000){
			if (window.pageYOffset > sticky) {
				$("#top").addClass("sticky");
			} else {
				$("#top").removeClass("sticky");
			}
		}else{
			$("#top").removeClass("sticky");
		}
		
	}
	
	
	$(window).on('resize', function() {
		resizeFn();
	});
	resizeFn();
		
	
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
	$("#wrap #footer .lang, #wrap #footer .family").mouseleave(function(e){
		$(this).removeClass("active");
	});
	
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
	

	// 
})