$(document).ready(function(){
	if(!($('body').is('.lte7'))){
		var navi = $('.Gnb').html();
		$('nav#menu').html(navi);

		$('nav#menu').mmenu({
			"offCanvas": {
				"position": "right"
			},
			"slidingSubmenus": false,
			"navbars": true,
			"extensions": [
				"shadow-page",
				"pagedim-black",
				"border-full"
			]
		});
		$('.mm-listview .mm-next').addClass('mm-fullsubopen');
		$('.mm-title').html('메뉴 전체보기');
	}

	//서브페이지 왼쪽메뉴 오른쪽 화살표 아이콘 생성
	$('.lnb>ul>li').each(function(){
		if(!($(this).hasClass('s'))){
			$(this).find('a').append('<i class="fa fa-angle-right"></i>');
		}
	});

	//배너
	var bannerSlider = $('.banner-roll').bxSlider({
		//mode : 'fade',	// 모드선택 horizontal/vertical/fade
		slideWidth: 135,
		speed: 500,			// 이동 속도를 설정
		moveSlides: 1,		// 슬라이드 이동시 개수
		//minSlides: 4,		// 최소 노출 개수
		maxSlides: 8,		// 최대 노출 개수
		auto: false,		// 자동 실행 여부
		autoHover: true,	// 마우스 호버시 정지 여부
		pager: false,		// 현재 위치 페이징 표시 여부 설정
		controls: false		// 이전 다음 버튼 노출 여부
	});

	$('.bottom-banner .prev').on('click',function(){
		bannerSlider.goToPrevSlide();	//이전 슬라이드 배너로 이동
		return false;
	});

	$('.bottom-banner .next').on('click',function(){
		bannerSlider.goToNextSlide();	//다음 슬라이드 배너로 이동
		return false;
	});
});