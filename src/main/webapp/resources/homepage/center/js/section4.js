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
});
