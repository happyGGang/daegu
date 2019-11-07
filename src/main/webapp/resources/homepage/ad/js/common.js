$(document).ready(function(){
	$('div.layer-photo .small a').on('click',function(e){
		e.preventDefault();
	    $('div.layer-photo li, div.layer-photo .small a').removeClass('active');
	    $(this).addClass('active');
	    var activeTab = $(this).attr('href');
	    $(activeTab).addClass('active');
	});
});