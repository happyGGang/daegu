$(document).ready(function () {
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
			
	// 타이틀 액티브 처리
	$('.book_information_item:first').addClass('menu_active');

	$('.book_information_item').click(function () {
		$('.book_information_item').removeClass('menu_active');
		$(this).addClass('menu_active');
	});

	// 메인 스와이퍼
	const BookSwiper = new Swiper('.book_information_swiper .swiper', {
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
	const BookListSwiper = new Swiper('.book_list', {
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

	// 메인 스와이퍼 & 리스트 스와이퍼 정지 OR 재생
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
});
