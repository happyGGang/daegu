$(document).ready(function () {
	// 타이틀 액티브 처리
	$('.board_index li:first').addClass('index_active');

	$('.board_index li').click(function () {
		$('.board_index li').removeClass('index_active');
		$(this).addClass('index_active');
	});

/* ------------------------------------------------------------------------------------------------------------------- */

	// 팝업 스와이퍼 페이지네이션
	let slidesPerPage = 1;
	const totalSlides = $('.popup_swiper .swiper-slide').length;
	let totalPages = Math.ceil(totalSlides / slidesPerPage);

	// 팝업 스와이퍼
	const popupSwiper = new Swiper('.popup_swiper .swiper', {
		speed: 3000,
		pagination: {
			el: '.popup_swiper .swiper-pagination',
			type: 'fraction',
			renderFraction: function (currentClass, totalClass) {
				return '<span class="' + currentClass + '"></span>' + ' / ' + totalPages;
			},
		},
		autoplay: {
			delay: 5000,
			disableOnInteraction: false,
		},
		loop: true,
		slidesPerView: 1,
		loopAddBlankSlides: true,
		navigation: {
			nextEl: '.popup_swiper .swiper-button-next',
			prevEl: '.popup_swiper .swiper-button-prev',
		},
	});


	// 팝업 스와이퍼 정지 OR 재생
	var popzoneConLen = $('.popup_swiper .swiper-slide').length;
	if(popzoneConLen > 1)
	{
	
	const autoplayButton = document.querySelector('.popup_autoplay');

	autoplayButton.addEventListener('click', () => {
		if (popupSwiper.autoplay.running) {
			popupSwiper.autoplay.stop();
			updateAutoplayButton('/resources/homepage/center/img/popup_play.svg', '재생버튼');
		} else {
			popupSwiper.autoplay.start();
			updateAutoplayButton('/resources/homepage/center/img/popup_stop.svg', '정지버튼');
		}
	});

	function updateAutoplayButton(src, alt) {
		autoplayButton.src = src;
		autoplayButton.alt = alt;
	}
	
	}
	
/* ------------------------------------------------------------------------------------------------------------------- */


	const calendarSwiper = new Swiper('.calendar_swiper .swiper', {
		speed: 3000,
		slidesPerView: 6,
		slidesPerGroup: 6,
		direction: 'vertical',
		loopAddBlankSlides: true,
		allowTouchMove: false,
		navigation: {
			nextEl: '.calendar_swiper .swiper-button-next',
			prevEl: '.calendar_swiper .swiper-button-prev',
		},
	});

			// 메인 스와이퍼
	var BookSwiper;
	var BookListSwiper;

	BookSwiper = new Swiper('.book_information_swiper .swiper', {
		speed: 200,
		allowTouchMove: false,
		loop: true,
		slidesPerView: 1,
		loopAddBlankSlides: true,
		effect: 'fade',
		fadeEffect: {
			crossFade: true,
		},
		navigation: {
			nextEl: '.book_information_swiper .swiper-button-next',
			prevEl: '.book_information_swiper .swiper-button-prev',
		},
	});

	// 리스트 스와이퍼
	BookListSwiper = new Swiper('.book_list', {
		speed: 200,
		spaceBetween: 10,
		loop: true,
		slidesPerView: 4,
		loopAddBlankSlides: true,
		allowTouchMove: false,
		navigation: {
		nextEl: '.book_information_swiper .swiper-button-next',
		prevEl: '.book_information_swiper .swiper-button-prev',
		},
	});


	// 메인 스와이퍼 & 리스트 스와이퍼 정지 OR 재생 - 버튼 있을떄 없을떄 예외처리
	var len;
	if( $('#librarian.book_information_item').hasClass('menu_active') )
	{
		len = $('.librarian .swiper-slide').length;
	}
	else if( $('#bestBook.book_information_item').hasClass('menu_active') )
	{
		len = $('.bestBook .swiper-slide').length;
	}
	else if( $('#newBook.book_information_item').hasClass('menu_active') )
	{
		len = $('.newBook .swiper-slide').length;;
	}
	else
	{
		len = 0;
	}

	if(len > 1)
	{

	const autoplayButton = document.querySelector('.book_autoplay');

	autoplayButton.addEventListener('click', () => {
		if (BookSwiper.autoplay.running) {
			BookSwiper.autoplay.stop();
			BookListSwiper.autoplay.stop();
			updateAutoplayButton('/resources/homepage/center/img/book_information_play.svg', '재생버튼');
		} else {
			BookListSwiper.autoplay.start();
			BookSwiper.autoplay.start();
			updateAutoplayButton('/resources/homepage/center/img/book_information_stop.svg', '정지버튼');
		}
	});

	function updateAutoplayButton(src, alt) {
		autoplayButton.src = src;
		autoplayButton.alt = alt;
	}

	}
});
