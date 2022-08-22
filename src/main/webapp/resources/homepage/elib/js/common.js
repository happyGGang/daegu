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
		$(document).on('click', '.tabMenuS a', function(){

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
	
	$(document).on('click', '.tab .tabMenuS a', function(){
		if (!$(this).hasClass('more-more')) {
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabS');
			var moreUrl = $(this).data('url');
			
			$box.find('.active').removeClass('active');
			$(this).parent().addClass('active');
			
			$box.find('.cont').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);
		}
	});

	$(document).on('click', '.tabV .tabMenuV a', function(){
		if (!$(this).hasClass('more')) {
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabV');
			var moreUrl = $(this).data('link');
			
			$box.find('.active').removeClass('active');
			$(this).parent().addClass('active');
			
			$box.find('.cont').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more').attr('href', moreUrl);
		}
	});

	// TAB
	$(document).on('click', '.tabMenuT a', function(){

		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tabT');
		var moreUrl = $(this).data('link');

		$(this).closest('.tabMenuT').find('li').removeClass('on');
		$(this).parent('li').addClass('on');

		$box.find('.con').hide();
		$box.find('[data-tab="'+target+'"]').show();

		if(target == 'tab1')
		{
			$('.mainSearchForm01').show();
			$('.mainSearchForm02').hide();
			$('.mainSearchForm03').hide();
		}
		else if(target == 'tab2')
		{
			$('.mainSearchForm01').hide();
			$('.mainSearchForm02').show();
			$('.mainSearchForm03').hide();
		}
		else if(target == 'tab3')
		{
			$('.mainSearchForm01').hide();
			$('.mainSearchForm02').hide();
			$('.mainSearchForm03').show();
		}
		else
		{
			$('.mainSearchForm01').show();
			$('.mainSearchForm02').hide();
			$('.mainSearchForm03').hide();
		}

	});
});

