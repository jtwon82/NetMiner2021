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
	
	
})

