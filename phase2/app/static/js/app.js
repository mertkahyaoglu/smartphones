$(document).ready(function() {
	$('.bxslider').bxSlider({
	  pagerCustom: '#thumbs',
	  controls: false
	});

	$('.bxslider').animate({opacity: 1}, 500);
});