$(function(){

	// 상단팝업존 - 공통적용
	if ($('.topPopZone ul').length > 0) {
		$('.topPopZone ul').bxSlider({
			mode:'fade',
			pause: 7000,
			speed: 1000,
			pager: true,
			auto: true,
			autoHover : true,
			autoControls: true,
			autoControlsCombine: true
		});
	}

	$('.popup .close > a').click(function(){
		$('.popup_top').slideToggle(500);
		$('span.popup a').toggleClass('on');
		if($('span.popup a').attr("class") == "on"){
			$('span.popup a').text("POPUP OPEN");
		}else{
			if ($(this).prev().is(':checked')) {
				var todayDate = new Date();
				todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				document.cookie = "toppopupzone=no; path=/; expires="+ todayDate.toGMTString() + ";";
			}
			$('span.popup a').text("POPUP CLOSE");
		}
	});

});