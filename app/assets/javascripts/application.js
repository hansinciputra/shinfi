// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require owl.carousel
//= require fancybox 
//= require turbolinks
//= require jquery-te-1.4.0.min.js
//= require_tree .

image_fancy = function(){
	jQuery("a.fancybox").fancybox({
		scrolling: 'no',
		autoScale: true,
		'width' : 350,
		'height': 850,
		padding: 0,
		'type' : 'image'
	});
};
$(document).on('page:load ready', image_fancy);

//this need to be changed to coffee script and stored locally
ready = function(){
	$("#search-prod").on("keyup",function(){
		var inputed = $(this).val();
		$("#prodNameTest a").each(function(){
			var text = $(this).text();
			if(text.indexOf(inputed)!= -1)
			{
				$(this).parent().parent().parent().show();
			}
			else
			{
				$(this).parent().parent().parent().hide();
			}
		});
	});
}
$(document).ready(ready);
$(document).on('page:load', ready);

jQuery(function(){
		$(".iframe").fancybox({
			type: 'iframe'
		});
		return false;
	});

$("#cart_thumb_caller").click(function(){
	$("#cart_thumb_content").fadeToggle();
});


function sticky_relocate(){
	var window_top = $(window).scrollTop();
	var div_top = $('#head_menu_anchor').offset().top;

	if(window_top > div_top){
		$('#head_menu').addClass('stick')
		$('#member_menu').show()
	}
	else
	{
		$('#head_menu').removeClass('stick')
		$('#member_menu').hide()
	}
}
$(function(){
	$(window).scroll(sticky_relocate);
	sticky_relocate();
});
