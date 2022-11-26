
$(function(){
	//LNB
	$(".quick_wrap").mouseleave(function() {
		$(".snb_sns").removeClass("show");
		$(".share_box .a_btn").removeClass('on');
	});										

	$(".share_box .snb_sns").mouseleave(function() {					
		$(".snb_sns").removeClass("show");	
		$(".share_box .a_btn").removeClass('on');
	});						

	$(".share_box .a_btn").click(function(){	
		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$(".snb_sns").removeClass("show");								

		}else{
			$(this).addClass('on');						
			$(".snb_sns").addClass("show");					
		}	
	});			
	
	$(".snb_link li, L2_Items").hover(function(){												
		$(this).addClass("on").siblings().removeClass("on");
		$(this).find(".L2_Items").slideDown("slow");					
	}, function() {					
		$(this).removeClass("on");  
		$(this).find(".L2_Items").slideUp("slow");
	});					
	$(".snb_link > li > a").click(function(){
		$(this).parent().addClass('on').siblings().removeClass('on');
		$(".etc_area li").find('.snb_sns').removeClass('show');
	});
	$(".snb_link > li > ul > li:last-child(), .snb_sns li:last-child()").focusout(function(){
		$(this).parents('li').removeClass('on');
		$('.snb_sns').removeClass('show');
	});						

	



	//다른 탭 이동.
	var hash = window.location.hash;								
	hash = hash.replace('#', '');

	// $('.path a').each(function(){
	// 	if(!hash){
	// 		$(".list_tabs .path a").eq(0).addClass('on');
			
	// 	}else{
	// 		var test = $(this).attr('id');										
	// 		test = hash;
	// 		$('#'+test).addClass('on').siblings().removeClass('on');											
	// 	}
		
	// });
	$('.tab_cont').each(function(){
		if(!hash){
			$(".tab_container > div").eq(0).addClass("on");												
		}else{
			var data_tab = $(this).attr('data-tab');	
			test2 = hash;
			if(data_tab == test2){
				$(this).addClass('on').siblings().removeClass('on');;
			}	
		}
		
	});		



	var TabIndex;
	$(".list_tabs .path a").click(function(){
		TabIndex = $(this).index();
		$(this).addClass("on").siblings().removeClass("on");
		$("ul.tab > li:first-child a").addClass('selected');
		$(".tab_container > div").eq(TabIndex).addClass("on").siblings().removeClass("on");

		
		$('.slider_for').slick('setPosition');
		$('.slider_nav').slick('setPosition');
		$('.slider_for').not('.slick-initialized').slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			arrows: false,			
			dots: false,
			fade: true,
			slide: 'div',
			asNavFor: '.slider_nav'
		});
		$('.slider_nav').not('.slick-initialized').slick({
			slidesToShow: 8,
			slidesToScroll: 8,
			asNavFor: '.slider_for',
			dots: false,
			slide: 'div',
			arrows: false,
			focusOnSelect: true,
			responsive: [	
				{
				breakpoint: 1400,
					settings: {
						slidesToShow: 7,
						slidesToScroll: 7						
					},									
				},							
				{
				breakpoint: 1280,
					settings: {
						slidesToShow: 6,
						slidesToScroll: 6						
					},									
				},
				{
				breakpoint: 1024,
					settings: {
						slidesToShow: 5,
						slidesToScroll: 5						
					},									
				},
				{
				breakpoint: 767,
					settings: {
						slidesToShow: 4,
						slidesToScroll: 4						
					},									
				},
				{
				breakpoint: 580,
					settings: {
						slidesToShow: 3,
						slidesToScroll: 3						
					},									
				},
				{
				breakpoint: 414,
					settings: {
						slidesToShow: 2,
						slidesToScroll: 2						
					},									
				},
			]																	
		});

		$('.tab_cont').each(function(i){
			$('ul.panel > li:first-child').addClass('selected');
			$("ul.tab > li a").click(function (i) {
				
				$(this).each(function(){
					var num = $("ul.tab > li a").index(this);
					console.log(num);
					$(".tabContent").removeClass('selected');
					$(".tabContent").eq(num).addClass('selected');
					$("ul.tab > li a").removeClass('selected');
					$(this).addClass('selected');
				});
				
				$('.slider_for').slick('setPosition');
				$('.slider_nav').slick('setPosition');	
			});
		});

	});
		//5뎁스 탭    
		$('.tab_container .tab_cont.on').each(function(i){
			$('ul.panel > li:first-child').addClass('selected');
			$("ul.tab > li a").click(function (i) {
				
				$(this).each(function(){
					var num = $("ul.tab > li a").index(this);
					// console.log(num);
					$(".tabContent").removeClass('selected');
					$(".tabContent").eq(num).addClass('selected');
					$("ul.tab > li a").removeClass('selected');
					$(this).addClass('selected');
				});
				
				$('.slider_for').slick('setPosition');
				$('.slider_nav').slick('setPosition');	
			});
		});
		



	//다른 탭
	// $('button').click(function(){
	// 	var $this = $(this);
	// 	var index = $this.index();
		
	// 	$this.addClass('active');
	// 	$this.siblings('button.active').removeClass('active');
		
	// 	var $outer = $this.closest('.outer');
	// 	var $current = $outer.find(' > .tabs > .tab.active');
	// 	var $post = $outer.find(' > .tabs > .tab').eq(index);
		
	// 	$current.removeClass('active');
	// 	$post.addClass('active');
	// 	// 위의 코드는 탭메뉴 코드입니다.
		
	// 	$('.slider').slick('setPosition');
		
	// });

	

	/* 달력 선택 */	
	$(".cal_table tbody tr a").click(function(){
		if(!$(this).hasClass('on')){ //on 없다면
			$(".cal_table tbody tr a").removeClass("on");
			$(this).addClass("on");
		}else{ //on 있다면
			$(this).removeClass("on");
		}
	});

	
		/* qr_cord */
	$(".qr_cord").click(function(){								
		if($(".qrBox").hasClass("on")){
			$(".qrBox").removeClass("on");
		}else{									
			$(".qrBox").addClass("on");
		}
	});

	$(".qrBoxClose").click(function(){
		$(this).parent('div').parent('li').find('a').attr('keyValue', 'true');
		$(".qrBox").removeClass("on");
	});



	//tab 클릭시 id 값으로 이동.

	$(".link_nav li").click(function(){
		var ilist = $(this).index(); 
		var head_ht = $("#main_nav").outerHeight();

		$("html, body").stop(true).animate({scrollTop:($(".terms_cont>li:eq("+ilist+")").offset().top - head_ht)});
	}); 

	//12.10 
	$(".o_chart a").click(function(){		
		var o_chart_ht = $("#main_nav").outerHeight();
		$("html, body").stop(true).animate({scrollTop:($("#con").offset().top - o_chart_ht) });	
	}); 

	//파일 업로드
	var $fileBox = null; 
	$(function() { init(); }) 

	function init() { 
		$fileBox = $('.input_file'); 
		fileLoad(); 
	} 
	function fileLoad() { 
		$.each($fileBox, function(idx){ 
			var $this = $fileBox.eq(idx), 
				$btnUpload = $this.find('[type="file"]'),  
				$label = $this.find('.file_label');  
			$btnUpload.on('change', function() {  
				var $target = $(this),  
					fileName = $target.val(),  
					$fileText = $target.siblings('.file_name');  
				$fileText.text(fileName); 
			})  
			$btnUpload.on('focusin focusout', function(e) {  
				e.type == 'focusin' ?  
				$label.addClass('file-focus') : $label.removeClass('file-focus');  
			})  
		}) 
	}	 

		//alink img 접근성
		$('.slick-slider > a, .event_img > a, .skech_cont a, .khmall_cont a, .img_area > a, .content_list li > a').focus(function(){
			$(this).find('img').css('padding','1px');
		});
		$('.slick-slider > a , .event_img > a, .skech_cont a, .khmall_cont a, .img_area > a, .content_list li > a').blur(function(){
			$(this).find('img').css('padding','0');
		});	


	$('.v_btn a').off().click(function(){
		$(this).parent().next('.sourceCodeTab').toggle();
		return false;
	});
});



