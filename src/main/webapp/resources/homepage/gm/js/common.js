$(document).ready(function(){
	$('div.like_book2 h3 a').on('click',function(e){
		e.preventDefault();
	    $('div.like_book2 li, div.like_book2 h3 a').removeClass('active');
	    $(this).addClass('active');
	    var activeTab = $(this).attr('href');
	    $(activeTab).addClass('active');
	});
});