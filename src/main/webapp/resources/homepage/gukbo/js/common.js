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
			$('.more-notice').attr('href', moreUrl);
		});

		// TAB
		$(document).on('click', '.tabMenuSS a.ct-tabs', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabSS');
			var moreUrl = $(this).data('link');

			$(this).closest('.tabMenuSS').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$('.tabContent-box .con').hide();
			$('.tabContent-box').find('[data-tab="'+target+'"]').show();
			$('.more-book').attr('href', moreUrl);
		});

	};

	return {
		init: init
	}
})();

$(function(){
	// 전광판(중앙도서관)
	$('.panelZone ul').bxSlider({
		mode:'vertical',
		speed: 500,
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

	$('.bookList ul').bxSlider({
		auto: true,
		autoHover: true,
		speed: 500,
		pager: false,
		moveSlides:1,
		maxSlides: 3,
		slideWidth: 200
	});

	$(document).delegate('.item','mouseover',function(){
		$(this).find(".figure-bg-section").show();
	});

	$(document).delegate('.item','mouseleave',function(){
		$(this).find(".figure-bg-section").hide();
	});

	$('select#library-link').on('change', function(e) {
		var url = $("select#library-link option:selected").val();
		$('a#library-link-btn').attr('href',url);
		$('a#library-link-btn').attr('target','_blank');
	});

	$('select#organization-link').on('change', function(e) {
		var url = $("select#organization-link option:selected").val();
		$('a#organization-link-btn').attr('href',url);
		$('a#organization-link-btn').attr('target','_blank');
	});

	var _width = $(window).width();
	var __width = $(window).width();
	var _popupzones;
	var PopupZone = function(){
		try {
			if( _popupzones ) _popupzones.destroySlider();
		} catch (e) {
			// TODO: handle exception
		}

		if( _width <= 350 ){
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
				slideWidth: 200
			});
		}
     else if( _width <= 525 && _width >  350 ){
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
				slideWidth: 350,
				slideMargin: 5
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
				maxSlides: 1,
				slideWidth: 500,
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
				maxSlides: 1,
				slideWidth:500,
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
				maxSlides: 1,
				slideWidth: 500,
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
				maxSlides: 1,
				slideWidth: 500,
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
				maxSlides: 1,
				slideWidth: 720,
				slideMargin: 25
			});
		}
	};

	PopupZone();

	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		
		PopupZone();
	});
	

});


