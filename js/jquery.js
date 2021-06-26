var offset = 150;
var header = $('header');

$('header nav ul li a').click(function() {
	$('.menu-button').trigger("click");
});

$(document).scroll(function() {
	position = $(this).scrollTop();

  if (position < offset)
  	header.css('background-color', 'transparent');
  else
    header.css('background-color', 'rgba(0,0,0,0.6)');

});

$('a[href*="#"]:not([href="#"])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') || location.hostname == this.hostname){

        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
           if (target.length) {
             $('body, html').animate({
               scrollTop: target.offset().top
            }, 400);

            return false;
        }
    }
});

$('.toggle-btn').click(function() {
	$('.toggle-bar').toggleClass("toggle-close");
	$('header nav ul').toggleClass("active");
});

// $(document).ready(function() {
// 	$(window).load(function() {
// 	        function hidePreloader() {
// 	            var preloader = $('.spinner-wrapper');
// 	            preloader.fadeOut(400);
// 	        }
// 	    hidePreloader();
// 	});
// });

function printMousePos(event) {
    var intX = event.clientX;
    var intY = event.clientY;
    $("#clicker").addClass("clicked");
    $("#clicker").css('top', intY);
    $("#clicker").css('left', intX);

    setTimeout(function () { $("#clicker").removeClass("clicked") }, 500);
}
document.addEventListener("click", printMousePos);
