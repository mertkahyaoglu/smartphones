$(document).ready(function() {
	$('.bxslider').bxSlider({
	  pagerCustom: '#thumbs',
	  controls: false
	});

	$('.bxslider').animate({opacity: 1}, 500);

	$( "#datepicker" ).datepicker();
	$( "#datepicker" ).datepicker("option", "dateFormat", "yy-mm-dd");  
});
