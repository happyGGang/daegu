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
	var _popupzones;
	var PopupZone = function(){
		try {
			if( _popupzones ) _popupzones.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( _width <= 525 ){
			_popupzones = $('.popZone ul').bxSlider({
				auto: true,
				autoHover: true,
				speed: 500,
				pager: true,
				pagerType: 'short',
				auto: true,
				autoControls: true,
				autoControlsCombine: true,
				moveSlides: 1,
				maxSlides: 1,
				slideWidth: 260
			});
		}
		else if( _width <= 768 && _width > 525 ){
			_popupzones = $('.popZone ul').bxSlider({
				auto: true,
				autoHover: true,
				speed: 500,
				pager: true,
				pagerType: 'short',
				auto: true,
				autoControls: true,
				autoControlsCombine: true,
				moveSlides: 1,
				maxSlides: 2,
				slideWidth: 260,
				slideMargin: 5
			});
		}
		else if( _width <= 1024 && _width > 768 ){
			_popupzones = $('.popZone ul').bxSlider({
				auto: true,
				autoHover: true,
				speed: 500,
				pager: true,
				pagerType: 'short',
				auto: true,
				autoControls: true,
				autoControlsCombine: true,
				moveSlides: 1,
				maxSlides: 2,
				slideWidth: 280,
				slideMargin: 5
			});
		}
		else if( _width <= 1260 && _width > 1024 ){
			_popupzones = $('.popZone ul').bxSlider({
				auto: true,
				autoHover: true,
				speed: 500,
				pager: true,
				pagerType: 'short',
				auto: true,
				autoControls: true,
				autoControlsCombine: true,
				moveSlides: 1,
				maxSlides: 2,
				slideWidth: 280,
				slideMargin: 5
			});
		}
		else if( _width <= 1530 && _width > 1260 ){
			_popupzones = $('.popZone ul').bxSlider({
				auto: true,
				autoHover: true,
				speed: 500,
				pager: true,
				pagerType: 'short',
				auto: true,
				autoControls: true,
				autoControlsCombine: true,
				moveSlides: 1,
				maxSlides: 2,
				slideWidth: 300,
				slideMargin: 25
			});
		}
		else {
			_popupzones = $('.popZone ul').bxSlider({
				auto: true,
				autoHover: true,
				speed: 500,
				pager: true,
				pagerType: 'short',
				auto: true,
				autoControls: true,
				autoControlsCombine: true,
				moveSlides: 1,
				maxSlides: 2,
				slideWidth: 370,
				slideMargin: 25
			});
		}
	};

	PopupZone();

	var _cultures;
	var Cultures = function(){
		try {
			if( _cultures ) _cultures.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( _width <= 425 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 300
			});
		}
		else if( _width <= 768 && _width > 425 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 300
			});
		}
		else if( _width <= 1024 && _width > 768 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 300
			});
		}
		else if( _width <= 1260 && _width > 1024 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 300
			});
		}
		else if( _width <= 1530 && _width > 1260 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 340
			});
		}
		else {
			_cultures = $('.cultureList ul').bxSlider({
				auto: true,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 400
			});
		}
	};

	Cultures();

	var Curation = function(){
		try {
			if( _curation ) _curation.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( __width <= 425 ){
			_curation = $('.curationList ul').bxSlider({
				auto: true,
				pager:false,
				controls:true,
				autoControls:true,
				autoControlsCombine:true,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 305,
				slideMargin: 20
			});
		}
		else if( __width <= 768 && __width > 425 ){
			_curation = $('.curationList ul').bxSlider({
				auto: true,
				pager:false,
				controls:true,
				autoControls:true,
				autoControlsCombine:true,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 305,
				slideMargin: 20
			});
		}
		else if( __width <= 1024 && __width > 768 ){
			_curation = $('.curationList ul').bxSlider({
				auto: true,
				pager:false,
				controls:true,
				autoControls:true,
				autoControlsCombine:true,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 305,
				slideMargin: 35
			});
		}
		else if( __width <= 1260 && __width > 1024 ){
			_curation = $('.curationList ul').bxSlider({
				auto: true,
				pager:false,
				controls:true,
				autoControls:true,
				autoControlsCombine:true,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 305,
				slideMargin: 35
			});
		}
		else if( __width <= 1530 && __width > 1260 ){
			_curation = $('.curationList ul').bxSlider({
				auto: true,
				pager:false,
				controls:true,
				autoControls:true,
				autoControlsCombine:true,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 305,
				slideMargin: 35
			});
		}
		else {
			_curation = $('.curationList ul').bxSlider({
				auto: true,
				pager:false,
				controls:true,
				autoControls:true,
				autoControlsCombine:true,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 335,
				slideMargin: 50
			});
		}

	};
	Curation();

	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		
		PopupZone();
		Cultures();
		Curation();
	});

	$('.movieContent ul').bxSlider({
		auto: true,
		pager:true,
		controls:false,
		autoControls:false
	});
});
