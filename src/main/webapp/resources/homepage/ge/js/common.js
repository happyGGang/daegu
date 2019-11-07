$(document).ready(function(){
	//퀵메뉴 드롭다운
	$('div.qmenu div.control a').on('click', function(e){
		e.preventDefault();
		$('div.qmenu .section').slideToggle(100);
		$('div.qmenu div.control a').toggleClass('active');
	});
	//관련사이트
	$('div.tnb a.fsite').on('click', function(e){
		e.preventDefault();
		$(this).toggleClass('active').next().slideToggle(100);
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
    }
);