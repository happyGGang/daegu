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
			auto: true,
			pager:true,
			controls:false,
			autoControls:false
		});
	}

	// 전광판(중앙도서관)
	$('.panelZone ul').bxSlider({
		mode:'vertical',
		pager: false,
		controls: false,
		pagerType: 'short',
		auto: true,
		autoControls: true,
		autoControlsCombine: true
	});

	$('.movieContent ul').bxSlider({
		auto: true,
		pager:true,
		controls:false,
		autoControls:false
	});

	var _width = $(window).width();
	var _newBooklist;

		var newBooks = function(){
			try {
				if( _newBooklist ) _newBooklist.destroySlider();
			} catch (e) {
				// TODO: handle exception
			}

			if( _width <= 200 ){
				_newBooklist = $('.book-box.mobile-view ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 1,
					slideWidth: 100,
					slideMargin: 0
				});
			}
			else if( _width <= 450 && _width > 200 ){
				_newBooklist = $('.book-box.mobile-view ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 2,
					slideWidth: 100,
					slideMargin: 20
				});
			}
			else if( _width <= 600 && _width > 450 ){
				_newBooklist = $('.book-box.mobile-view ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 3,
					slideWidth: 120,
					slideMargin: 20
				});
			}
			else if( _width <= 768 && _width > 600 ){
				_newBooklist = $('.book-box.mobile-view ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 4,
					slideWidth: 120,
					slideMargin: 20
				});
			}
			else if( _width <= 1024 && _width > 768 ){
				_newBooklist = $('.book-box.mobile-view ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 5,
					slideWidth: 120,
					slideMargin: 10
				});
			}
			else {
				_newBooklist = $('.book-box.mobile-view ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 4,
					slideWidth: 170,
					slideMargin: 15
				});
			}
		};

		newBooks();
		$(window).on('resize', function(){
			_width = $(window).width();
			newBooks();
		});

});
