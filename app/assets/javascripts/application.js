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
//= require social.js
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

jQuery(function(){
$(".cart_icon_container").click(function(){
	$("#cart_thumb_content").toggle();
	$("#cart_thumb_content_po").hide();
});
$(".cart_icon_container_po").click(function(){
	$("#cart_thumb_content_po").toggle();
	$("#cart_thumb_content").hide();
});
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

jQuery(function(){
$("#fb_message_hide").click(function(){
	$("#fb_message").css('height','370px');
});
});

jQuery(function(){
 $('form').on('click','.remove_fields',function(event){
 	//set the value of input type that is hidden to 1 -> means destroy is trigerred
 	$(this).prev('input[type=hidden]').val('1');
 	$(this).closest('#price_determinant_container').hide();
 	event.preventDefault();
 })
 $('form').on('click','.add_fields',function(event){
 	//set the value of input type that is hidden to 1 -> means destroy is trigerred
 	time = new Date().getTime()
 	regexp = new RegExp($(this).data('id'),"g")
 	$(this).before($(this).data('fields').replace(regexp, time))
 	event.preventDefault();
 })
});
//jquery for checkbox on shop helper
	jQuery(function(){
		$('.checkbox_shop').on('click',function(){
				$('#fabric_shop').submit();
				$('#craft_shop').submit();
		});
		$('.reload').on('click',function(){
				url = window.location.pathname.split('?')[0];
				
				window.location = url;
		});
	});
