$(document).ready(function() {

	$("#wrap #nav .menu span").click(
		function(){
			$(this).toggleClass("on");
			$(this).next().toggleClass("on");
		}
	);
	
	$(".popup .close, .popup .closeBtn").click(function() {
		$(".popup").fadeOut();
		$("body").css("overflow-y","auto");
	});
	

})