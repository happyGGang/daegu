$(document).ready(function(){
	$('div.sc_tab h3 a').on('click',function(e){
		e.preventDefault();
	    $('div.sc_tab li, div.sc_tab h3 a').removeClass('active');
	    $(this).addClass('active');
	    var activeTab = $(this).attr('href');
	    $(activeTab).addClass('active');
	});
});