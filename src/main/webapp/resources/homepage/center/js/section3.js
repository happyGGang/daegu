$(document).ready(function () {
	// 타이틀 액티브 처리
	$('.book_information_item:first').addClass('menu_active');

	$('.book_information_item').click(function () {
		$('.book_information_item').removeClass('menu_active');
		$(this).addClass('menu_active');
	});

	// 메인 스와이퍼
	const BookSwiper = new Swiper('.book_information_swiper .swiper', {
		speed: 3000,
		allowTouchMove: false,
		autoplay: {
			delay: 3000,
			disableOnInteraction: false,
		},
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
		speed: 3000,
		autoplay: {
			delay: 3000,
			disableOnInteraction: false,
		},
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

	// 프로그레스바
	const progressBar = document.querySelector('.progress');

	BookSwiper.on('slideChangeTransitionStart', () => {
		progressBar.style.transition = 'none';
		progressBar.style.width = '0%';
	});

	BookSwiper.on('slideChangeTransitionEnd', () => {
		progressBar.style.transition = `width ${BookSwiper.params.autoplay.delay}ms linear`;
		progressBar.style.width = '100%';
	});

	progressBar.style.transition = `width ${BookSwiper.params.autoplay.delay}ms linear`;
	progressBar.style.width = '100%';
});
