<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
	<script>

	$(document).ready(function() {
		if($("#licenseusage").val() == '') {
			moveReturn();
		} else {
			setEdition();
			setPackage();
			setExtension();
			setQty();
			setShipping();
// 			setShipping_table($("#licenseterm").val());
			setItem();
			setEditionPackage();
			setProof_Text2();
			if($("#proofUrl").val() == '') {
				$("#proofUrl").focus();
			}
			
			nodisplay();
		}
	});

	function moveReturn() {		
		var buyModel = document.getElementById("buyModel");
		
		buyModel.action = "/download_buy/buy/buy-view.do";
		buyModel.submit();
	}

	function setTerm() {
		setEdition();
		setPackage();
		setExtension();

// 		setShipping_table($("#licenseterm").val());
		setItem();
		setTimeout(function(){
			$('#edition_1').click();
		},100);
		checkEditionPackage();
		setShipping();
	}
	
	function setSize() {
		setPackage();
		setItem();
		checkEditionPackage();
	}
	
	function setQty() {
		$("#order_qty").html($("#qty").val());
		$("#extension_qty").html($("#qty").val());
		
		setPrice();
	}
	
	function setPackage() {
		$("form[id=buyModel]").ajaxSubmit({
			url : "/download_buy/buy/buy_package-ajax.do",
			type : "post",
			success : function(data){
				if(data == null || data == '') {
					alert('An error has occurred.');
					history.go(-1);
				} else {
					$("#buy_package_table tr:not(:first)").remove(); 
					$("#buy_package_table_head").after(data);
					$("#packages_all").attr("checked",false);
// 					setPrice();
				}
			}
		});
	}

	function setEdition() {
		$("form[id=buyModel]").ajaxSubmit({
			url : "/download_buy/buy/buy_edition-ajax.do",
			type : "post",
			success : function(data){
				if(data == null || data == '') {
					alert('An error has occurred.');
					history.go(-1);
				} else {
					$("#buy_edition_table tr:not(:first)").remove(); 
					$("#buy_edition_table_head").after(data);
				}
			}
		});
	}
	
	function setExtension() {
		$("form[id=buyModel]").ajaxSubmit({
			url : "/download_buy/buy/buy_extension-ajax.do",
			type : "post",
			success : function(data){
				if(data == null || data == '') {
					alert('An error has occurred.');
					history.go(-1);
				} else {
					$("#buy_extension_table tr:not(:first)").remove(); 
					$("#buy_extension_table_head").after(data);
					$("#extensions_all").attr("checked",false);
				}
			}
		});
	}

	var editionPackArr;
	var editionsize;
	var selectEdition = 0;
	
	function setEditionPackage(edition) {
		selectEdition= edition;
		$("form[id=buyModel]").ajaxSubmit({
			url : "/download_buy/buy/buy_editionpackage-ajax.do",
			type : "post",
			success : function(data){
				if(data == null || data == '') {
					alert('An error has occurred.');
					history.go(-1);
				} else {
					editionPackArr = new Array();
					$("#editionpackage2").html(data);
					$("#licensesize").val(editionsize);
					setSize();
				}
			}
		});
	}
	
	<c:if test="${ buyModel.licenseusage eq '0'}">
	function nodisplay() {
		$('.nodisplay').css("display","none");
		$("#collapseExample").removeClass("collapse");
	}
	</c:if>
	
	function checkEditionPackage(){
		setTimeout(function(){
				var packages =  $('input:checkbox[name="packages"]');
				$('input[name="editionpackages"]').each(function(index){
					var checkboxid = '#'+packages.eq(index).val();
					for(var i =0; i<editionPackArr.length; i++){
					 	if(this.value == editionPackArr[i]) {
							$(checkboxid).attr('checked', true);
						}		
					}
				});
				setPrice();	
		},100);
	}
	
	<c:if test="${ buyModel.licenseusage ne '0'}">
	function setPackageCheckAll() {
		if($("#packages_all").prop("checked")) {
			$('input:checkbox[name="packages"]').each(function(){
				if(!this.disabled) {
					this.checked = true;
				}
			});
		} else {
			$('input:checkbox[name="packages"]').each(function(){
				if(!this.disabled) {
					this.checked = false;
				}
			});
		}
		
		setPrice();
	}
	
	function setExtensionsCheckAll() {
	    if($("#extensions_all").prop("checked")) {
        $('input:checkbox[name="extensions"]').each(function(){
            if(!this.disabled) {
                this.checked = true;
              }
            });
	    } else {
	        $('input:checkbox[name="extensions"]').each(function(){
	            if(!this.disabled) {
	                this.checked = false;
	              }
	            });
	    }
	    setPrice();
	}
	</c:if>
	
	function setItem() {
		var item = "Netminer";
		var licenseusage = $("#licenseusage").val();
		var licenseterm = $("#licenseterm option:selected").text();
		var licensesize = $("#licensesize option:selected").text();
		if(licenseusage == '0') {
			licenseusage = "Student(Coursework)";
		} else if(licenseusage == '1') {
			licenseusage = "Student(Research)";
		} else if(licenseusage == '2') {
			licenseusage = "Academic";
		}
		
		$("#order_items").html(item + " (" + licenseusage + ", " + licenseterm + ", " + licensesize + ")");
	}
	function setProof_Text2() {
		var licenseusage= $("#licenseusage").val();
		if(licenseusage == '2'){
		
		$("#Proof_text2").html("Proof of academic status(Professor, Academic researcher, Student) is required to register and activate the NetMiner.<br/>You can choose one of the following methods for the proof of your status");
		}else{
			$("#Proof_text2").html("Proof of full-time student status is required to register and activate the NetMiner.<br/>You can choose one of the following methods for the proof of your status");
		}
		
	}
	function setPrice(packageid, id) {
		if(packageid==7){
			var checkboxid = '#'+ id;
			var checkboxid2 = '#'+ (++id);
			if($(checkboxid).prop("checked")){
				$(checkboxid2).prop("checked", true);
				$(checkboxid2).attr("disabled","disabled");
			}else{
				$(checkboxid2).removeAttr("disabled");
			}
		}
    	var discounts = {"1":0, "2":0.05, "3":0.09, "4":0.12, "5":0.14, "6":0.16, "7":0.17, "8":0.18, "9":0.19, "10":0.20,
	          "11":0.21, "12":0.22, "13":0.23, "14":0.24, "15":0.25, "16":0.26, "17":0.27, "18":0.28, "19":0.29, "20":0.3,
	          "21":0.31, "22":0.32, "23":0.33, "24":0.34, "25":0.35, "26":0.36, "27":0.37, "28":0.38, "29":0.39, "30":0.4}

		var qty = $("#qty").val();
		var prices = $("input[name=prices]");
		var editionpackages = $("input[name=editionpackages]");
		var price = 0;
		var extensionPrice = 0; // 선택한 익스텐션들의 가격
		var extensionSum = 0; // 선택한 익스텐션들의 가격 * 수량
		var extensionPrices = $("input[name=extensionprices]"); // 익스텐션 개별 가격 리스트
		var sum = 0;
		var discount = 0;
	  	var discountRate = 0;
		var delivery = getDeliveryPrice();
		var total = 0;

		var useScriptpackage = false;
		$('input:checkbox[name="packages"]').each(function(index){
			if(this.checked) {
				if(editionpackages.eq(index).val() ==7){
					useScriptpackage =true;
				}
				if(useScriptpackage && editionpackages.eq(index).val()==8){
					
				}else{
					price = price + new Number(prices.eq(index).val());	
				}
// 				price = price + new Number(prices.eq(index).val());
			}
		});
		
	 	var licenseusage = $("#licenseusage").val();
	    
	    var showExtension = false;
		$('input:checkbox[name="extensions"]').each(function(index){
			if(this.checked) {
				// 익스텐션의 체크박스가 선택되어 있는 경우
				extensionPrice = extensionPrice + new Number(extensionPrices.eq(index).val())
				showExtension = true;
			}
		});
		if(showExtension) {
			$("#extension_pricelist").show();
		} else {
			$("#extension_pricelist").hide();
			// 익스텐션이 아무것도 선택되어 있지 않다면 최상위 체크박스를 해제한다
			$("#extensions_all").attr("checked",false);
		}
	    
	    extensionSum = extensionPrice * new Number(qty);
		sum = price * new Number(qty);
		
	  	if(licenseusage == '0') {
	    	discountRate = total * -1;
	  	}
	  	if(licenseusage == '2') {
	    	discountRate = discounts[qty];
	  	}
    	discount = - ((sum + extensionSum) * discountRate);
    	discounted = sum + extensionSum + discount;
		
		total = discounted + delivery;
		
		$("#order_price").html(price.toFixed(2));
		$("#price").val(price.toFixed(2));
		
		$("#extension_price").html(extensionPrice.toFixed(2));
		$("#extensionPrice").val(extensionPrice.toFixed(2));
		
		$("#order_sum").html(sum.toFixed(2));
		$("#sum").val(sum.toFixed(2));
		
		$("#extension_sum").html(extensionSum.toFixed(2));
		$("#extensionSum").val(extensionSum.toFixed(2));
		
		$("#order_discount").html(discount.toFixed(2));
		$("#discount").val(discount.toFixed(2));
		
		$("#order_delivery").html(delivery.toFixed(2));
		$("#delivery").val(delivery.toFixed(2));
		
		$("#order_total").html(total.toFixed(2));
		$("#total").val(total.toFixed(2));

	}
	
	function setShipping() {
		var esd = "ESD (Electronic software Delivery)";
		var cd = "ESD(Electronic Software Delivery) is default.<br/>I want CD Package by DHL express with additional shipping cost <input type='checkbox' id='shipping_cd_check' onclick='javascript:setCD();'/>";
		var delivery = "The selected item will be delivered by DHL express.";
		
		var licenseusage = $("#licenseusage").val();
		
		if(licenseusage == '0') {
			$("#shipping_kind_td").html(esd);
		} else {
			$("#shipping_kind_td").html(cd);
			$("#shipping_notice_1").html("<font color='red'>[Notice]</font> Valid e-mail Address is required. Software License Key will be delivered to your e-mail address.");
			$("#shipping_notice_2").html("");
		} 
// 		else {
// 			var licenseterm = $("#licenseterm").val();
			
// 			if(licenseterm == '1') {
// 				$("#shipping_kind_td").html(cd);
// 				$("#shipping_notice_1").html("<font color='red'>[Notice]</font> Valid e-mail Address is required. Software License Key will be delivered to your e-mail address.");
// 				$("#shipping_notice_2").html("");
// 			} else {
// 				$("#shipping_kind_td").html(delivery);
// 				$("#shipping_notice_1").html("<font class='fontred'>[Notice]</font> Valid e-mail Address is required. Software License Key will be delivered to your e-mail address.");
// 				$("#shipping_notice_2").html("&nbsp;&nbsp;&nbsp;&nbsp; Please provide the correct address and phone number for accurate delivery.");
				
// 			}
// 		}
	}

	function setShipping_table(licenseterm) {
		

		
		var tr_country = "<tr>"
    				+ "<td width='152' >Country</td>"
    				+ "<td colspan='3' id='country_price'>"+$("#aaaa").html()+"</td>"
  					+ "</tr>";
		var tr_tel = "<tr>"
            		+ "<td width='152'>Tel.</td>"
            		+ "<td colspan='3'><input type='text' class='input_w200'/></td>"
          			+ "</tr>";
		var tr_zip = "<tr>"
            		+ "<td width='152'>Zip</td>"
            		+ "<td colspan='3'><input type='text' class='input_w200'/></td>"
          			+ "</tr>";
		var tr_addr = "<tr>"
            		+ "<td width='152'>Address</td>"
            		+ "<td colspan='3'><input type='text' class='input_w500'/></td>"
          			+ "</tr>";
          			
		$("#shipping_info_table tr:not(:first)").remove(); 
		
		if(licenseterm == '2') {
			$("#shipping_notice_1").html("<font class='fontred'>[Notice]</font> Valid e-mail Address is required. Software License Key will be delivered to your e-mail address.");
			$("#shipping_notice_2").html("&nbsp;&nbsp;&nbsp;&nbsp; Please provide the correct address and phone number for accurate delivery.");

			$("#shipping_info_table_head").after(tr_addr);
			$("#shipping_info_table_head").after(tr_zip);
			$("#shipping_info_table_head").after(tr_tel);
			$("#shipping_info_table_head").after(tr_country);

						
		} else {
			$("#shipping_notice").html("<font color='red'>[Notice]</font> Valid e-mail Address is required. Software License Key will be delivered to your e-mail address.");
		}
	}

	function setCD() {
	 	if($("#shipping_cd_check").prop("checked")) {
// 	 		$("#shipping").val("1");
	 		$('#collapseExample2').collapse('show');
		} else {
// 			$("#shipping").val("0");
			$('#collapseExample2').collapse('hide');
		} 
		
		setPrice();
	}
	
	function setUserEmail() {
		 	if($("#user_update").prop("checked")) {
		 		$("#email").val("");
		 		$("#email").val($("#email2").text());
		 		$("#email").attr("readonly",true);
			} else{
				$("#email").attr("readonly",false);
			}
		}

	function getDeliveryPrice() {
		var licenseusage = $("#licenseusage").val();

		var delivery = $("#countrylist option:selected").val();
		var delivery2 = parseFloat(delivery)
		var delivery3=$("#countrylist option:selected").text();


		
		if(licenseusage == '0') {
			return 0;
		} else {
			if($("#shipping_cd_check").prop("checked")) {
				$("#country").val(delivery3);
				return delivery2;
// 				return 46;
			} else {
			
				return 0;
			}
		} 
// 		else {
// 			var licenseterm = $("#licenseterm").val();
			
// 			if(licenseterm == '1') {
// 				if($("#shipping_cd_check").prop("checked")) {
// 					$("#country").val(delivery3);
// 					return delivery2;
// 				} else {
// 					return 0;
// 				}
// 			} else {
// // 				delivery2 = $("#countrylist option:selected").val();
// 				$("#country").val(delivery3);
// 				return delivery2;
// 			}
// 		}
	}

	//disabled 풀었던 checkbox들 다시 disabled 시키기
	function fn_pay_return() {
		$('input:checkbox[name="packages"]').each(function(index){
			for(var i = 0; i < arrCheckDisabled.length; i++) {
				if(index == arrCheckDisabled[i]) {
					this.disabled = true;
					break;
				}
			}
		});
	}

	//disabled checkbox 임시로 담아놓는 배열
	var arrCheckDisabled = new Array();
	
	function fn_check() {
		if($("#proofUrl").val() == '' && $("#attach_files").val() == '') {
			alert("Please enter the URL or scanned image files.");
			$("#proofUrl").focus();
			return false;
		}
		return true;
	}

	function fn_save(pay) {
		if(!fn_check()) {
			return;
		}
		
		if($("#shipping_cd_check").is(":checked")) {
			$("#shipping").val("1");
		}else{
			$("#shipping").val("0");
		}

		if($("#licenseterm").val() == '2') {
			$("#shipping").val("1");
		}
		
		$("#pay").val(pay);
		
		//checkbox disabled 인 것들 풀어서 값 넘기기
		var i = 0;
		arrCheckDisabled = new Array();

		$('input:checkbox[name="packages"]').each(function(index){
			if(this.disabled) {
				arrCheckDisabled[i] = index;
				i++;
				this.disabled = false;
			}
		});

		//초기화
		$("#sale_id_div").html(""); 

		$("form[id=buyModel]").ajaxSubmit({
			url : "/download_buy/buy/buy-create.do",
			type : "post",
			success : function(data){
				fn_pay_return();				
				
				if(data == null || data == '') {
					alert('An error has occurred.');
				} else {
					
					//에러면
					if(data.indexOf("error_message") > -1) {
						$("#return_message").html(data);
						alert($("#error_message").html());
						$("#return_message").html(""); 
						return;
						
					}
					
					//성공이면
					$("#sale_id_div").html(data); 
				}

				//무료
				if(pay == 0) {
					fn_moveReturn_Student_courcework();
					
				//계좌이체
				} else if(pay == 1) {
					fn_moveReturn_Account_transfer();
					
				//카드
				} else if(pay == 2) {
					if($('input[name="saleids"]').length > 0) {
						fn_pay();
		
					}
//					fn_pay_end_update();
				}
			}
		});
	}

	function fn_pay_end_update() {
		doAjax("buyModel", "/download_buy/buy/buy-update.do", "", "fn_moveReturn()");
	}
	
	function fn_moveReturn_Student_courcework() {
		var buyModel = document.getElementById("buyModel");
		
		buyModel.action = "/download_buy/buy/buy_ok_Student_courcework-view.do";
		buyModel.submit();
	}
	
	function fn_moveReturn_Research_academic() {
		var buyModel = document.getElementById("buyModel");
		
		buyModel.action = "/download_buy/buy/buy_ok_Research_academic-view.do";
// 		buyModel.submit();
	}
	
	function fn_moveReturn_Account_transfer() {
		var buyModel = document.getElementById("buyModel");
		
		buyModel.action = "/download_buy/buy/buy_ok_Account_transfer-view.do";
		buyModel.submit();
	}
	
	function fn_pay() {
		var sWin = window.open("about:blank", "netminer_paypal_popup", "menubar=no,toolbar=no,scrollbars=no,resizable=no,width=1000,height=700,status");

		var buyModel = document.getElementById("buyModel");
		
		buyModel.target = "netminer_paypal_popup";
		buyModel.action = "/download_buy/buy/paypal-popup.do";
		buyModel.submit();
		sWin.focus();
		
	}

	function fn_guidePP() {
		var option = "width=500px, height=600px, scrollbars=yes, resizable=yes, statusbar=no";
		var sWin = window.open("/html/guidePP.html", "PAYPAL_GUIDE_POPUP", option);
		sWin.focus();
	}
	
	</script>

</head>
	
<body>
<div id="editionpackage2" style="display:none"></div>
  <!--하단컨텐츠-->
  <div id="container02" >
  
	<form:form commandName="buyModel" method="post" enctype="multipart/form-data">
		<form:hidden path="licenseusage" />
		<form:hidden path="pay" />
		<form:hidden path="shipping"/>
		<form:hidden path="status" value="TMP"/>
		<form:hidden path="on_offline" value="online"/>
		<form:hidden path="price" />
		<form:hidden path="sum" />
		<form:hidden path="surtax" value="0"/>
		<form:hidden path="surtax_sum" />
		<form:hidden path="discount" />
		<form:hidden path="delivery" />
		<form:hidden path="total" />
		<form:hidden path="country" />
		<form:hidden path="registercount" value="2"/>
		<form:hidden path="registered" value="0"/>
		<form:hidden path="extensionPrice"/>
		<form:hidden path="extensionSum"/>
		
<!-- 	<div id="aaaa" style="display: none; display:   "> -->
<%-- 	<form:select id="countrylist" onchange="javascript:setCD();" path="delivery" items="${buyModel.countryList}" itemLabel="text" itemValue="value" class="input_w200"/> --%>
<!-- 	</div>	 -->

	<div id="dbemail2" style="display: none;">
	<ul>
	<li id="email2">${buyModel.email}</li>
<%-- 	<form:input id="shipping" path="shipping"/> --%>
	</ul>
	</div>	

    <div id="sale_id_div">
	</div>
	  
    <div class="submain" >
    <img src="/images/sub/contitle16.gif" alt="NetMiner Buy_Student"/>
      <div class="buybox08">

       <ul><li>
<c:choose>
	<c:when test="${ buyModel.licenseusage eq '0' }">
       <img src="/images/sub/buy_title01.gif" alt="Student Coursework"/>
	</c:when>
	<c:when test="${ buyModel.licenseusage eq '1' }">
       <img src="/images/sub/buy_title02.gif" alt="Student Research"/>
	</c:when>
	<c:otherwise>
       <img src="/images/sub/buy_title03.gif" alt="Academic"/>
	</c:otherwise>
</c:choose>
       </li></ul>
       <!-- 
       <img src="/images/sub/buy_title04.gif" alt="Institute Commercial Enterprise buy"/>
        -->
      
      <h1 class="hfont_33">Proof of Status</h1>
        <ul >
            <li class="font12_red" id="Proof_text2"></li>
           <li>
           
             <table style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;" class="buss_tb8">
               <tr>
                 <td  class=" alignl "><strong>URL </strong> of your school's web page or web directory that proves your student status.
                 <span class=" font12_red">The web page must have your name on it.</span></td>
                 <td style="width:365px;" class=" alignl "><form:input path="proofUrl" class="input_w300" /></td>
               </tr>
               <tr>
                 <td class="alignl">Scanned Image file of dated student id or registration receipt.</td>
                 <td class="alignl"><form:input type="file" path="attach_files" class="input_w300" /></td>
               </tr>
             </table>
           </li>
        </ul>
        <img src="/images/sub/buy_line.gif" style="margin:0px;"/>
      </div>
      <div class="buybox12 nodisplay" id="nodisplay" >
      <table style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;height:30px" >
          <tr>
            <td style="width:82px;" > <h1 class="hfont_33" style="padding-top:10px;">Term </h1></td>
            <td style="width:30px;" class="mdb10"><img src="/images/sub/btn_question.gif" alt="question" align="middle" style="cursor:pointer"  onclick="openLayer('poster01',{top:305, left:80});"  class="mdb10" /></td>
            <td style="width:165px;">
	            <form:select onchange="javascript:setTerm();" path="licenseterm" items="${buyModel.licensetermsList}" itemLabel="text" itemValue="value" class="input_w130"/>
            </td>
            <td style="width:48px;">  <h1 class="hfont_33"  style="padding-top:10px;">Qty</h1></td>
            <td style="width:36px;"><img src="/images/sub/btn_question.gif" alt="question" style="cursor:pointer" onclick="openLayer('poster04',{top:305, left:300});"    class="mdb10"/></td>
            <td style="width:96px;">
            	<form:select onchange="javascript:setQty();" path="qty" items="${buyModel.qtyList}" itemLabel="text" itemValue="value" class="input_w70"/>
            </td>
          </tr>
        </table>
      </div>      
      <div class="subday mdb10"></div>
       
    <div id="poster01" class="layer-popupexe"> 
    <div class="buybox03">
      <h1>Type of Term</h1>
     <ul>
      <li>Type of Term is classified as 6 Months, Annual (1Year) and Perpetual.<br />
         6 Months is available for Coursework Use only.</li>
      <li>Annual is available for Student Research Use and Academic Use.</li>
      <li>Perpetual is available for Academic Use, Institute Use, Commercial Use and Enterprise Use.</li>
      <li>It can be summarized as follows.</li>   
      <li class="mdl10 mdt10"><strong>Coursework use</strong> : 6 Months</li>
      <li class="mdl10"><strong>Student Research use</strong> : Annual</li>
      <li class="mdl10"><strong>Academic Use</strong> : Annual, Perpetual</li>
      <li class="mdl10"><strong>Institute/Commercial/Enterprise Use</strong> : Perpetual</li>
      <li class=" mdt5"><strong>Notice</strong> : If the type of Term is Perpetual, ESD (Electronic Software Delivery) is not supported for security reason, and extra USB flashdrive-looking hardware license key is required to execute program in addition to the software key as is required for other type of license. 
package and the hardware key will be delivered by door-to-door express delivery service.</li>
     </ul>
    </div>       
 <a href="#" class="close"><img src="/images/main/layer_close.gif" alt="close"/></a>    
    </div>
    <div id="poster02" class="layer-popupexe"> 
    <div class="buybox03">
      <h1>Data Size</h1>
     <ul>
      <li>Here are 4 levels of data size: Small, Medium, Large and Huge. The maximum size of nodes at each level is as follows.</li>
     
      <li class="mdl10 mdt10"><strong>Small</strong> :1,000</li>
      <li class="mdl10"><strong>Medium</strong> : 10,000</li>
      <li class="mdl10"><strong>Large</strong> : 100,000</li>
      <li class="mdl10" style="margin-bottom:18px;"><strong>Huge</strong> :1,000,000</li>
      <li>Available data size for each type of Usage is as follows.</li>
	<li class="mdl10 mdt10">Coursework Use : Small</li>
	<li class="mdl10 ">Student Research Use : Small, Medium, Large</li>
	<li class="mdl10 ">Academic Use : Small, Medium, Large, Huge</li>
	<li class="mdl10 ">Institute/Commercial Use : Small, Medium, Large, Huge</li>
	<li class="mdl10 ">Enterprise Use : Unlimited</li>
      <li class=" mdt5"><strong>Notice</strong> : It is not guaranteed that the software will perform efficiently on the Data Size. 
The Data Size is the maximum size of nodes allowed to be imported into NetMiner. The performance of NetMiner depends on the system performance on which NetMiner is installed.
You need to check the full description about 'Scalability and Performance' of NetMiner on our web page in FAQ Menu.</li>
     </ul>
    </div>       
 <a href="#" class="close"><img src="/images/main/layer_close.gif" alt="close"/></a>    
    </div>

    <!--레이어팝업/설명부분-->
    <div id="poster04" class="layer-popupexe"> 
    <div class="buybox03">
      <h1>Qty</h1>
     <ul>
      <li>Enter the number of NetMiner license 
And Quantity discounts will be applied.</li>
     </ul>
    </div>       
 <a href="#" class="close"><img src="/images/main/layer_close.gif" alt="close"/></a>    
    </div>
    <!--//레이어팝업/설명부분-->
    
    
    <!-- 에디션 -->
	<div class="buybox11 nodisplay" id="nodisplay" >  
	        
	  <!--레이어팝업/패키지설명부분-->
	    <div id="poster05" class="layer-popupexe"> 
		    <div class="buybox03">
		      <h1>The Edition of NetMiner</h1>
		      <ul>
			     <li>
			     NetMiner consists of 10 packages and 4 data size options. <br/><br/>
				(Data size means the maximum number of nodes such as person, words, institute, etc.)<br/>
				Each edition includes different packages and data size so that you can easily select the right functions to meet your needs. 
				If you want to make your own edition not preset edition, you can separately select packages and size. <br/><br/>
			     
				 </li>
			     <li><a href="/product/package01.do" target="_blank">Edition & Package Description</a></li>
		      </ul>
		    </div>       
		 	<a href="#" class="close"><img src="/images/main/layer_close.gif" alt="close"/></a>    
	    </div>
	    <!--//레이어팝업/패키지설명부분-->    
	    <ul>
	    	<li>
				<h1 class="mdt10 hfont_33" >Edition </h1>
	       		<span><img src="/images/sub/btn_question.gif" alt="question" style="cursor:pointer" onclick="openLayer('poster05',{top:355, left:513});"/></span></li>
	      	<li>
	      		<table id="buy_edition_table" class="buss_tb8" style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;">
				  	<tr id="buy_edition_table_head">
					    <th >Edition</th>
					    <th style="width:550px; padding:0 50 0 70px;">Description</th>
					    <th style="width:100px;">Price (USD)</th>
					    <th style="width:50px;">&nbsp;</th>
	  				</tr>
				</table>
			</li>
	      </ul> 
	</div>
	<div class="buybox04 nodisplay" id="nodisplay">
	Do you want to make your own edition not preset edition? 
		<span>
      		<a data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" style="text-decoration:underline; color:#006699 ">
	       Make Your Own Edition
	      	</a>
	  </span>
	</div>
    <img class="nodisplay" src="/images/sub/buy_line.gif"/>
	<!-- // 에디션 -->
   <div class="collapse" id="collapseExample" aria-expanded="false" style="height: 0px;">
     <div class="buybox12" >
      <table style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;height:30px" >
          <tr>
            <td style="width:105px;">  <h1 class="hfont_33"  style="padding-top:10px;">Data Size </h1> </td>
            <td style="width:34px;"><img src="/images/sub/btn_question.gif" alt="question" style="cursor:pointer" onclick="openLayer('poster02',{top:605, left:80});"  class="mdb10"/></td>
            <td style="width:224px;">
            	<form:select onchange="javascript:setSize();" path="licensesize" items="${buyModel.licensesizesList}" itemLabel="text" itemValue="value" class="input_w200"/>
            </td>
          </tr>
        </table>
      </div> 
      
      <!-- 패키지 -->
    <div class="buybox11" >    
	  	<!--레이어팝업/패키지설명부분-->
		 <div id="poster03" class="layer-popupexe"> 
		    <div class="buybox03">
		      <h1>The Packages of NetMiner</h1>
		     <ul>
		      <li>The Packages of NetMiner are divided such that users can select some of those packages in order to build customized NetMiner for their needs.
		
				<br/>
				<br/>
				Prices and specifications are subject to change without notice.
				<br/>
				
				Prices excluses any taxes and shipping&amp;handling cost.</li>
		     
		     <li><a href="/product/package01.do" target="_blank">Package Description</a></li>
		      
		     </ul>
		    </div>       
	 		<a href="#" class="close"><img src="/images/main/layer_close.gif" alt="close"/></a>    
	   </div>
	    <!--//레이어팝업/패키지설명부분-->   
       <ul >
         <li>
			<h1 class="mdt10 hfont_33" >Packages </h1>

		       <span><img src="/images/sub/btn_question.gif" alt="question" style="cursor:pointer" onclick="openLayer('poster03',{top:755, left:513});"/></span></li>
		      <li><table id="buy_package_table" class="buss_tb8" style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;">
			  <tr id="buy_package_table_head">
			    <th style="width:100px;">&nbsp;</th>
			    <th style="width:220px;">Package</th>
			    <th >Description</th>
			<!--     <th style="width:100px;">Description</th> -->
			    <th style="width:100px;">Price (USD)</th>
			    <th style="width:50px;">
			    	
			<c:choose>
				<c:when test="${ buyModel.licenseusage eq '0'}">
			    	&nbsp;
				</c:when>
				<c:otherwise>
			    	<input type="checkbox" id="packages_all" onclick="javascript:setPackageCheckAll();"/>
				</c:otherwise>
			</c:choose>
			
			    </th>
			  </tr>
			  
			</table>
			</li>
        </ul> 
      </div>
        <img src="/images/sub/buy_line.gif"/>
       </div>
     	<!-- //패키지 -->  
	<!-- 익스텐션 -->
				<c:choose>
					<c:when test="${ buyModel.licenseusage ne '0' }">
						<div class="buybox11">
							<ul>
								<li>
									<h1 class="mdt10 hfont_33" style="float: left;">Extensions</h1>
									<span style="margin-top: 17px; font-size: 12px; float: left;">&nbsp;※
										All or part of the service could be suspended or terminated by data provider company.</span> 
									 <span style="margin-top: 0px;"><img
										src="/images/sub/btn_question.gif" alt="question"
										style="cursor: pointer"
										onclick="openLayer('poster05',{top:355, left:513});" /></span>
								</li>
								<li>
									<table id="buy_extension_table" class="buss_tb8"
										style="border: 0px; padding: 0px; border-collapse: collapse; border-spacing: 0px;">
										<tr id="buy_extension_table_head">
											<th>Extensions</th>
											<th style="width: 550px; padding: 0 50 0 70px;">Description</th>
											<th style="width: 100px;">Price(USD)</th>
											<th style="width: 50px;"><input type="checkbox"
												id="extensions_all"
												onclick="javascript:setExtensionsCheckAll();;" /></th>
										</tr>
										<!-- 여기서부터 Extension의 정보는 setExtension()에서 구현한다 -->
									</table>
								</li>
							</ul>
						</div>
						<img class="nodisplay" src="/images/sub/buy_line.gif" />
					</c:when>
				</c:choose>
	<!-- //익스텐션 -->
       
        <div class="buybox11" >  
        <h2  class="mdt10" >Delivery Methods And Shipping Information </h2>
         <ul  >
          <li id="shipping_notice_1"></li>
          <li id="shipping_notice_2" class="mdl32 mdb10"></li>
          <li>
            <table id="shipping_info_table" class="buss_tb9" style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;margin:0 auto;">

								<tr id="shipping_info_table_head">
									<td style="width:50px;">Delivery Methods</td>
									<td style="width:330px;" id="shipping_kind_td"></td>
									<td style="width:50px;">e-mail</td>
									<td><form:input id="email" path='email' class='input_w160' /><input
 										type='checkbox' id="user_update" name="user_update"  value="Y"/> 
										Profile reflects</td>
								</tr>
								<tr>
									<td style="width:152px;">Country</td>
									<td colspan="3"><form:select id="countrylist" onchange="javascript:setCD();" path="delivery2" items="${buyModel.countryList}" itemLabel="text" itemValue="value" class="input_w200"/></td>
								</tr>
						</table>
					<div class="collapse" id="collapseExample2" aria-expanded="false" style="height: 0px;">
						<table class="buss_tb9" style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;margin:0 auto;">
								<tr>
									<td style="width:152px;">Tel.</td>
									<td colspan='3'><form:input type='text' id="phone" path="phone" class='input_w200' /></td>
								</tr>
								<tr>
									<td style="width:152px;">Zip</td>
									<td colspan='3'><form:input type='text' id="zipcode" path="zipcode" class='input_w200' /></td>
								</tr>

								<tr>
									<td style="width:152px;">Address</td>
									<td colspan='3'><form:input type='text' id="address1" path="address1" class='input_w500' /></td>
								<%-- 	<td colspan='3'><form:input type='text' id="address2" path="address2" class='input_w500' /></td> --%>
								</tr>

							</table>
						</div>
          </li>
          </ul>
        </div>
  
      <!--//선택부분-->
      
      <div class="buybox11" >  
        <h2  class="mdt10" ><span class="mdt20">Order items</span></h2>
         <ul  ><li>
           <table  class="buss_tb9" style="border:0px;padding:0px;border-collapse:collapse;border-spacing:0px;" >
             <tr>
               <th >Items</th>
               <th style="width:100px;">Price</th>
               <th style="width:100px;">Qty</th>
               <th style="width:150px;">Total Price (USD)</th>
             </tr>
             <tr>
               <td class="brline2" id="order_items">Netminer</td>
               <td align="right" id="order_price"></td>
               <td align="center" id="order_qty"></td>
               <td align="right" id="order_sum"></td>
             </tr>
             <tr id="extension_pricelist">
               <td class="brline2">Extensions</td>
               <td align="right" id="extension_price"></td>
               <td align="center" id="extension_qty"></td>
               <td align="right" id="extension_sum"></td>
             </tr>
             <tr>
               <td>Discount</td>
               <td align="right">&nbsp;</td>
               <td align="center">&nbsp;</td>
               <td align="right" id="order_discount"></td>
             </tr>
             <tr>
               <td>Shipping &amp; handling Cost</td>
               <td align="right">&nbsp;</td>
               <td align="center">&nbsp;</td>
               <td align="right" id="order_delivery"></td>
             </tr>
             <tr>
               <td>Total</td>
               <td align="right">&nbsp;</td>
               <td align="center">&nbsp;</td>
               <td align="right" id="order_total"></td>
             </tr>
           </table>
         </li>
        </ul>
      </div>
        
        
        <div class="buybox11" >  
        <h2  class="mdt10" >Payment Methods</h2>
         <ul  >
          <li class=" font12"> Any taxes(VAT) or tariffs which may be imposed by Customs in the importing country are not included to the price.
          <br/>If you have any payment or there is an error in the process questions, please mail to <a href="mailto:netminer@cyram.com">netminer@cyram.com</a>.
	<c:if test="${ buyModel.licenseusage ne '0' }">
		<br/>Please review payment guide before proceeding your payment. 
			<a href="javascript:fn_guidePP();">
		[Click Here]
	    	</a>
	</c:if>
          </li>
          <li style="float:right">

<c:choose>
	<c:when test="${ buyModel.licenseusage eq '0' }">
          	<a href="javascript:fn_save(0);"><img src="/images/sub/btn_pay04_eng.gif" alt="Free" class="mdl25"/></a>
	</c:when>
	<c:otherwise>
			<a href="javascript:fn_save(1);" style="text-decoration:none;">
		       	<img src="/images/sub/btn_pay03_eng.gif" alt="Bank Transfer"  class="mdl25"/>
	    	</a>

			<a href="javascript:fn_save(2);" style="text-decoration:none;">
	          	<img src="/images/sub/btn_paypal_E.png" alt="paypal"/>
	    	</a>
<ul><li class="font12" style="float:right"> *  Please allow pop-ups from this site for payment.</li>
</ul>   
	</c:otherwise>
</c:choose>
          
          </li>
        </ul>
      </div>
        
        
        <div class="buybox10">
        <h2>Address</h2>
        <ul>
         <li>
#904, U-Space 2B, 670, Daewangpangyo-ro, Bundang-gu, Seongnam-si, Gyeonggi-do, 13494, South Korea</li>
        </ul>
      </div>
      
    </div>
      

	</form:form>
	
  </div>
  <!--//하단컨텐츠-->

</body>
</html>
