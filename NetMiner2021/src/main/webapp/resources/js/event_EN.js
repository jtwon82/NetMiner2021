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
					var nationNameEn = nation[i].NATION_NAME_EN;
					if (nationCode==data.userNationCode) {
						html += "<option value='"+nationCode+"\' selected=\'selected\'>"+nationNameEn+"</option>\n"
					} else {
						html += "<option value='"+nationCode+"\'>"+nationNameEn+"</option>\n"; 
						
					}
				});
				$("#nation").empty();
				$("#nation").append(html);
			} 
	
	});

})
