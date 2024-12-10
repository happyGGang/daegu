$(document).ready(function () {
	// 타이틀 액티브 처리
	$('.board_index li:first').addClass('index_active');

	$('.board_index li').click(function () {
		$('.board_index li').removeClass('index_active');
		$(this).addClass('index_active');
	});

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
});
