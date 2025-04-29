$(document).ready(function(){
	pageMain.init();
});


var pageMain = (function(){
	var init, bindEvent;

	init = function() {
		bindEvent();
		movieSlider();
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

		$(document).on('click', '.tabMenuSS a.t-tabs', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabSS');
			var moreUrl = $(this).data('link');

			$(this).closest('.tabMenuSS').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.cont').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);
		});
	};

	movieSlider = function(){
		if($('.movieContent ul li').length >0) {
			$('.movieContent ul').bxSlider({
				auto: true,
				pager:false,
				autoControls:true,
				autoControlsCombine:true
			});
		}
	};

	return {
		init: init
	}
})();

$(function(){

	// 팝업존
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

	var _width = $(window).width();
	var bannerLength60 = $('div.banner-wrap.type60 ul.banner-roll').length;
	var bannerSlider60;
	var bannerWrap = $('div.banner-wrap');

	var bannerZone = function(){
		try {
			if( bannerSlider60 ) bannerSlider60.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( _width <= 500 )
		{
			if (bannerLength60 > 0) {
				bannerSlider60 = $('div.banner-wrap.type60 ul.banner-roll').bxSlider({
					slideWidth:170,
					speed:500,
					moveSlides:1,
					maxSlides:1,
					slideMargin:0,
					auto:true,
					autoHover:true,
					pager:false,
					controls:false
				});
			}
		}
		else if( _width <= 768 && _width > 500 )
		{
			if (bannerLength60 > 0) {
				bannerSlider60 = $('div.banner-wrap.type60 ul.banner-roll').bxSlider({
					slideWidth:170,
					speed:500,
					moveSlides:1,
					maxSlides:3,
					slideMargin:10,
					auto:true,
					autoHover:true,
					pager:false,
					controls:false
				});
			}
		}
		else if( _width <= 1024 && _width > 768 )
		{
			if (bannerLength60 > 0) {
				bannerSlider60 = $('div.banner-wrap.type60 ul.banner-roll').bxSlider({
					slideWidth:170,
					speed:500,
					moveSlides:1,
					maxSlides:5,
					slideMargin:10,
					auto:true,
					autoHover:true,
					pager:false,
					controls:false
				});
			}
		}
		else if( _width <= 1260 && _width > 1024 )
		{
			if (bannerLength60 > 0) {
				bannerSlider60 = $('div.banner-wrap.type60 ul.banner-roll').bxSlider({
					slideWidth:170,
					speed:500,
					moveSlides:1,
					maxSlides:7,
					slideMargin:10,
					auto:true,
					autoHover:true,
					pager:false,
					controls:false
				});
			}
		}
		else {
			if (bannerLength60 > 0) {
				bannerSlider60 = $('div.banner-wrap.type60 ul.banner-roll').bxSlider({
					slideWidth:170,
					speed:500,
					moveSlides:1,
					maxSlides:8,
					slideMargin:20,
					auto:true,
					autoHover:true,
					pager:false,
					controls:false
				});
			}
		}
	};

	bannerZone();

	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		
		bannerZone();
	});
/*
	$('div.banner-wrap a.prev').on('click',function(){
		if(bannerSlider60 != null ){
			bannerSlider60.goToPrevSlide();
		}
		return false;
	});

	$('div.banner-wrap a.next').on('click',function(){
		if(bannerSlider60 != null ){
			bannerSlider60.goToNextSlide();
		}
		return false;
	});
*/
});
