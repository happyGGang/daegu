$(function(){
	$('.userListchk').on('click', function(){
		var chk = $(this).is(':checked');
		if(chk)
		{
			$(this).parent().prev().find('img.checking').show();
		}
		else
		{
			$(this).parent().prev().find('img.checking').hide();
		}
	});
	
	$('.green-img').on('click', function(){
		var chked = $(this).parent().next().find('input.userListchk').is(':checked');

		if(!chked)
		{
			$(this).parent().next().find('input.userListchk').prop('checked',true);
			$(this).prev('img.checking').show();
		}
		else
		{
			$(this).parent().next().find('input.userListchk').prop('checked',false);
			$(this).prev('img.checking').hide();
		}
	});
});
