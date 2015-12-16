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
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require fancybox 
//= require turbolinks
//= require_tree .


/*the command below will let all fancybox class be part of html <body> tag, 
we need this because turbolink gem we install earlier will make the page load faster 
at the expense of not reloading the header, thus by calling the code below we ensure that the 
fancybox keep on getting called
*/

//the .ajaxComplete will call the fancybox function after ajax call has been called
image_fancy = function(){
	jQuery("a.fancybox").fancybox({
		scrolling: 'no',
		autoScale: true,
		'width' : 350,
		'height': 850,
		'type' : 'iframe'
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

