$(document).ready(function(){
	//퀵메뉴 드롭다운
/*	$('div.qmenu div.control a').on('click', function(e){
		e.preventDefault();
		$('div.qmenu .section').slideToggle(100);
		$('div.qmenu div.control a').toggleClass('active');
	});*/
	//관련사이트
/*	$('div#footer a.fsite').on('click', function(e){
		e.preventDefault();
		$(this).toggleClass('active').next().slideToggle(100);
		return false;
	});
	$(document).click(function(){
		$('div#footer a.fsite').removeClass('active').next().hide();
	});
	*/
	$('#footer .site1 .btn').click(function(e){
		var url = $('.site1 select option:selected').val();
		var openNewWindow = window.open("about:blank");

		openNewWindow.location.href = url;
		
		e.preventDefault();
	});
	
	$('#footer .site2 .btn').click(function(e){
		var openNewWindow = window.open("about:blank");
		var url=$('.site2 select option:selected').val();
		openNewWindow.location.href=url;
		
		e.preventDefault();
	});
	
	// 좌측 메뉴를 벗어나면 하위 메뉴가 사라지도록
	$('div#header').on('mouseout focusout', function(){
		clearTimeout(submenuTimeout);
		submenuTimeout = setTimeout(function() {
			$('div.Gnb ul.gnb-menu li.List').removeClass('active');
			$('div.Gnb').removeClass('on');
			$('div.mask').hide();
		}, 3000);
	});
	
	// 하위 메뉴 때문에 검색창이 가려지지 않도록
	$('input#search_text').on('mouseover focusin', function(){
		$('div.Gnb ul.gnb-menu li.List').removeClass('active');
		$('div.Gnb').removeClass('on');
		$('div.mask').hide();
	});
	
});

$(window).scroll(
    function(){
        //스크롤의 위치가 상단에서 450보다 크면
        if($(window).scrollTop() > 150){
        /* if(window.pageYOffset >= $('원하는위치의엘리먼트').offset().top){ */
            $('div#wrap').addClass("menu-fixed");
            //위의 if문에 대한 조건 만족시 fixed라는 class를 부여함
        }else{
            $('div#wrap').removeClass("menu-fixed");
            //위의 if문에 대한 조건 아닌경우 fixed라는 class를 삭제함
        }
    
    
    });