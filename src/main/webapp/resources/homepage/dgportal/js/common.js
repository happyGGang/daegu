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

	// 팝업존(중앙도서관)
	if ($('.popZone ul').length > 0) {
		$('.popZone ul').bxSlider({
			mode:'fade',
			pager: true,
			pagerType: 'short',
			auto: true,
			autoControls: true,
			autoControlsCombine: true
		});
	}

//	$('.event-box > ul').bxSlider({
//		mode:'vertical',
//		pager:false
//	});
//
//	$('.holiday-box > ul').bxSlider({
//		mode:'vertical',
//		pager:false
//	});

	var _width = $(window).width();
	var _cultures;

	var Cultures = function(){
		try {
			if( _cultures ) _cultures.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( _width < 555 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 1,
				slideWidth: 305,
				slideMargin: 20
			});
		}
		else if( _width <= 769 && _width > 555 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 300,
				slideMargin: 5
			});
		}
		else if( _width <= 941 && _width > 768 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 2,
				slideWidth: 300,
				slideMargin: 15
			});
		}
		else if( _width <= 1024 && _width > 940 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 3,
				slideWidth: 300,
				slideMargin: 15
			});
		}
		else if( _width <= 1260 && _width > 1025 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 300,
				slideMargin: 15
			});
		}
		else if( _width < 1600 && _width > 1261 ){
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 305,
				slideMargin: 30
			});
		}
		else {
			_cultures = $('.cultureList ul').bxSlider({
				auto: false,
				pager: false,
				moveSlides:1,
				maxSlides: 4,
				slideWidth: 305,
				slideMargin: 30
			});
		}
	};

	Cultures();
/*
	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		Cultures();
	});
*/
	$('.story_list .wrap').on('mouseover click' ,function(){
		$('.story_list .wrap').removeClass('on');
		$(this).addClass('on');  	
	});

});
