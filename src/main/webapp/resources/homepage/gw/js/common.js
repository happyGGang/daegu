$(document).ready(function(){
	$('select#library-location-select').on('change', function(e) {
		var url = $("select#library-location-select option:selected").val();
		$('a.recommendSite11').attr('href',url);
		$('a.recommendSite11').attr('target','_blank');
	});
});