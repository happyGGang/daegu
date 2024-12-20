$(document).ready(function () {
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
		}
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
		}
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
