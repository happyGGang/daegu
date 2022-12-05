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

function CurationList07()
{
	const length = $('.mainSection07 .slickWrap > div').length
	$('.mainSection07 .slickWrap').slick({
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
		$('.mainSection07 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection07 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection07 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection07 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection07 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection07 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection07 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList08()
{
	const length = $('.mainSection08 .slickWrap > div').length
	$('.mainSection08 .slickWrap').slick({
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
		$('.mainSection08 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection08 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection08 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection08 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection08 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection08 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection08 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList09()
{
	const length = $('.mainSection09 .slickWrap > div').length
	$('.mainSection09 .slickWrap').slick({
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
		$('.mainSection09 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection09 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection09 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection09 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection09 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection09 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection09 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList10()
{
	const length = $('.mainSection10 .slickWrap > div').length
	$('.mainSection10 .slickWrap').slick({
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
		$('.mainSection10 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection10 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection10 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection10 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection10 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection10 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection10 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList11()
{
	const length = $('.mainSection11 .slickWrap > div').length
	$('.mainSection11 .slickWrap').slick({
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
		$('.mainSection11 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection11 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection11 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection11 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection11 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection11 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection11 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList12()
{
	const length = $('.mainSection12 .slickWrap > div').length
	$('.mainSection12 .slickWrap').slick({
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
		$('.mainSection12 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection12 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection12 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection12 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection12 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection12 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection12 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}

function CurationList13()
{
	const length = $('.mainSection13 .slickWrap > div').length
	$('.mainSection13 .slickWrap').slick({
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
		$('.mainSection13 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
	  });

	$('.mainSection13 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection13 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection13 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection13 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection13 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection13 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
}