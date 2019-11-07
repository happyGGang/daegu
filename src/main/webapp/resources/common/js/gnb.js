function gnbInit(){
	var y=$('#header div.Gnb').height();
	var t=0;
	var z=y+1;
	$.each($('#header div.Gnb ul.SubMenu'),function(i,e){
		if(t < $(e).height()){
			t = ($(e).height())+20;
		}
	});
	var ti=t+y;

	$("#header div.Gnb").css("height", y+"px");
	$("#header div.Gnb").css("left", "0px");
	$("#header div.mask").css("height", ti+"px");

	jQuery(".Gnb li").bind("mouseenter focusin", function(){
		//$(".Gnb").addClass("on");
	});
	jQuery("#header ul.gnb-menu>li>a")
	.bind("mouseenter focusin", function(){
		if(jQuery("#header div.Gnb").height() < z){
			jQuery("#header div.Gnb").stop().animate({
				height : ti
			}, 200);
			jQuery("#header div.Gnb ul.SubMenu").stop().animate({
				height : t
			}, 200);
		}
		if(!jQuery(this).parent().hasClass("on")){
			jQuery("#header ul.gnb-menu>li.on").removeClass("on");
			jQuery(this).parent().addClass("on");
		}
	});
	jQuery("#header ul.gnb-menu>li.on").removeClass("on");
	jQuery(this).parent().addClass("on");
	jQuery("#header div.Gnb ul.SubMenu>li>a")
	.bind("mouseenter focusin", function(){
		if(!jQuery(this).parent().parent().parent().hasClass("on")) {
			jQuery("#header div.Gnb").css("height", (ti + "px"));
			jQuery("#header ul.gnb-menu>li.on").removeClass("on");
			jQuery(this).parent().parent().parent().addClass("on");
		}
	});
	jQuery("#header div.Gnb").bind("mouseleave", function(){
		jQuery("#header div.Gnb").stop().animate({
			height : y
		}, 150);
		jQuery("#header div.Gnb, #header ul.gnb-menu>li.on").removeClass("on");
	});
	jQuery("#header div.Gnb ul li.Last").bind("focusout", function(){
		jQuery("#header div.Gnb").stop().animate({
			height : y
		}, 150);
		jQuery("#header ul.gnb-menu>li.on").removeClass("on");
	});
}

$(document).ready(function(){
	gnbInit();
});