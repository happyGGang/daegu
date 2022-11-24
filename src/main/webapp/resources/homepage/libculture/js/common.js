$(document).ready(function(){
	pageMain.init();
});


var pageMain = (function(){
	var init, bindEvent;

	init = function() {
		bindEvent();
	};

	bindEvent = function(){

		// TAB
		$(document).on('click', '.tabMenuS a.t-tabs', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabS');
			var moreUrl = $(this).data('link');

			$(this).closest('.tabMenuS').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.con').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);
		});

	};

	return {
		init: init
	}
})();

$(function(){
	
	var _width = $(window).width();
	var __width = $(window).width();
	var _ingcultures;

	var ingCultures = function(){
		try {
			if( _ingcultures ) _ingcultures.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( _width <= 425 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 430
			});
		}
		else if( _width <= 550 && _width > 425 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 430
			});
		}
		else if( _width <= 768 && _width > 550 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 430
			});
		}
		else if( _width <= 1024 && _width > 768 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 430
			});
		}
		else if( _width <= 1140 && _width > 1024 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 390
			});
		}
		else if( _width <= 1260 && _width > 1140 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 430
			});
		}
		else if( _width <= 1330 && _width > 1260 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 310
			});
		}
		else if( _width <= 1450 && _width > 1330 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 340
			});
		}
		else if( _width <= 1540 && _width > 1450 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 370
			});
		}
		else if( _width <= 1620 && _width > 1540 ){
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 400
			});
		}
		else 
		{
			_ingcultures = $('.ingSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 430
			});
		}
	};

	ingCultures();

	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		
		ingCultures();
	});

});
