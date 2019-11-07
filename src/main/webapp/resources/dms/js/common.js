$(document).ready(function(){
	$('div.sc_tab h3 a').on('click',function(e){
		e.preventDefault();
	    $('div.sc_tab li, div.sc_tab h3 a').removeClass('active');
	    $(this).addClass('active');
	    var activeTab = $(this).attr('href');
	    $(activeTab).addClass('active');
	});
	$('div.Gnb ul.gnb-menu li.List, div.Gnb div.mask').unbind('mouseover focusin');
	$('div.Gnb ul.gnb-menu li.List, div.Gnb div.mask').unbind('mouseover focusout')
	
	$('div.Gnb ul.gnb-menu li.List').on('mouseover focusin', function(){
		$('div.Gnb ul.gnb-menu li.List').removeClass('active');
		$(this).addClass('active');
	});

	$('div.Gnb ul.gnb-menu li.List ul').on('mouseout focusout', function(){
		$('div.Gnb ul.gnb-menu li.List').removeClass('active');
	});
});