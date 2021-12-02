document.onkeydown = noEvent;

function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}

function showUpdate() {
//	var updateDiv = document.getElementById("update");
//	updateDiv.style.removeProperty("display");
	$(".update").removeClass('h');
}

$(function (){
	$.ajax({
		url :"./getNationCode",
			type:"GET",
			success: function (data){
				 var nation = data.NationVo;
				 var html ="";
				$.each(nation , function (i){
					var nationCode = nation[i].NATION_CODE;
					var nationNameKr = nation[i].NATION_NAME_KR;
					if (nationCode==data.userNationCode) {
						html += "<option value='"+nationCode+"\' selected=\'selected\'>"+nationNameKr+"</option>\n"
					} else {
					html += "<option value='"+nationCode+"\'>"+nationNameKr+"</option>\n"; 						
					}
				});
				$("#nation").empty();
				$("#nation").append(html);
			} 
	
	});

})

/*function showEmailRegister(){
	var email = $("#email").val();
	var pwd = $("#pwd").val();
	var company = $("#commpany").val();
	var nation = $("#nation").val();
	var useCode = $(".useCode").val();
	
	if (email != null && email != '' && pwd != null && pwd != '' &&
	 company != null && company != '' &&nation != null && nation != '' && useCode != null && useCode != '' ) {
		
	}
	
}*/
