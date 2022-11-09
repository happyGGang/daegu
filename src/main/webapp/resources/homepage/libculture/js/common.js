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
	var _areacultures;


	var Cultures = function(){
		try {
			if( _ingcultures ) _ingcultures.destroySlider();
			if( _areacultures ) _areacultures.destroySlider();
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 180,
				slideMargin: 0
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 180,
				slideMargin: 0
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 200,
				slideMargin: 10
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 220,
				slideMargin: 10
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 240,
				slideMargin: 20
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 240,
				slideMargin: 40
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 240,
				slideMargin: 60
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 240,
				slideMargin: 60
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 240,
				slideMargin: 60
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 240,
				slideMargin: 80
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

			_areacultures = $('.areaCultureSlideList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 5,
				slideWidth: 240,
				slideMargin: 100
			});
		}
	};

	Cultures();

	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		
		Cultures();
	});

});
