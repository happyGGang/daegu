$(document).ready(function(){
	//사진으로 보는 도서관
	if ($('ul.lt_photo').length > 0) {
		$('ul.lt_photo').bxSlider({
			mode:'fade',
			auto:false,
			controls:true,
			autoHover:true
		});
	}
});