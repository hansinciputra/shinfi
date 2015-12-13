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
//= require fancybox 
//= require jquery_ujs
//= require turbolinks
//= require jquery-fileupload/basic
//= require_tree .

//the .ajaxComplete will call the fancybox function after ajax call has been called
$(document).ajaxComplete(function(){
	$("a.fancybox").fancybox({'type' : 'iframe'});
});
$(document).ready(function(){
	$("a.fancybox").fancybox({'type' : 'iframe'});
});

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

//javascript for adding multiple product picture

