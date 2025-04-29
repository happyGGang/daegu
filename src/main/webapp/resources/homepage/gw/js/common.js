$(document).ready(function(){
	$('select#library-location-select').on('change', function(e) {
		var url = $("select#library-location-select option:selected").val();
		$('a.recommendSite11').attr('href',url);
		$('a.recommendSite11').attr('target','_blank');
	});

	// �앹뾽議�
	if ($('div.popupzonenew ul').length > 0) {
		$('div.popupzonenew ul').bxSlider({
			mode:'fade',
			auto: true,
			autoHover: true,
			speed: 500,
			pager: true,
			pagerType: 'short',
			auto: true,
			autoControls: true,
			autoControlsCombine: true
		});
	}
});