$(document).ready(function(){
	//새창 알림
	var link_new_win = '새창으로 열립니다.';
	$('a').each(function(){
		if($(this).attr('target') == '_blank'){
			$(this).attr('title', link_new_win);
		}
	});

/*
	$('.nav ul').bxSlider({
		auto:false,
		autoControls:true,
		autoHover:true,
		minSlides:8,
	    maxSlides:9,
	    moveSlides:1,
	    slideMargin:0,
	    autoReload:true,
	    pager:false,
	    breaks: [
	        {screen:0, slides:2},
	        {screen:400, slides:3},
	        {screen:650, slides:4},
	        {screen:880, slides:5},
	        {screen:1000, slides:6}
	    ]
	});
*/
});