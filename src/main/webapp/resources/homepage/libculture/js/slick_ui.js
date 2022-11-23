$(function(){
	CurationList01();
});

function CurationList01()
{
	const length = $('.mainSection01 .slickWrap > div').length
	$('.mainSection01 .slickWrap').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 2,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection01 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection01 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection01 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection01 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection01 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection01 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection01 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList02()
{
	const length = $('.mainSection02 .slickWrap > div').length
	$('.mainSection02 .slickWrap').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 1,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection02 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection02 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection02 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection02 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection02 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection02 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection02 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList03()
{
	const length = $('.mainSection03 .slickWrap > div').length
	$('.mainSection03 .slickWrap').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 1,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection03 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection03 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection03 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection03 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection03 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection03 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection03 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList04()
{
	const length = $('.mainSection04 .slickWrap > div').length
	$('.mainSection04 .slickWrap').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 1,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection04 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection04 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection04 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection04 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection04 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection04 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection04 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList05()
{
	const length = $('.mainSection05 .slickWrap > div').length
	$('.mainSection05 .slickWrap').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 1,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection05 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection05 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection05 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection05 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection05 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection05 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection05 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList06()
{
	const length = $('.mainSection06 .slickWrap > div').length
	$('.mainSection06 .slickWrap').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 1,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection06 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection06 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection06 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection06 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection06 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection06 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection06 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}