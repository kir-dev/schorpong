$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() >= 150) {
            $('.title').fadeOut("slow");
        }
        else {
            $('.title').fadeIn("slow");
        }
        if ($(this).scrollTop() >= 260) {
            $('.logo_background').fadeIn("slow");
            if ($(this).scrollTop() >= 275) {
                $('.ball').addClass('small');
                $('.logo_background').addClass('small');
                $('.cups').addClass('small');
                $('.cups_back').addClass('small');
                $('.ball').css('width', 20);
                $('.ball').css('height', 20);
                $('.ball').css('background-size', 20);
                $('.ball').css('bottom', 8);
            }
        }
        else {
            $('.ball').removeClass('small');
            $('.logo_background').removeClass('small');
            $('.cups').removeClass('small');
            $('.cups_back').removeClass('small');
            $('.logo_background').fadeOut("slow");
            var pos = (400 + (-1 * ($(this).scrollTop() / 8 - 10) * ($(this).scrollTop() / 8 - 10) + 150));

            $('.ball').css('bottom', pos);
            $('.ball').css('width', 50 + $(this).scrollTop() / 4);
            $('.ball').css('height', 50 + $(this).scrollTop() / 4);
            var blur = -$(this).scrollTop() / 100 + 3;
            $('.ball').css('filter', 'blur(' + blur + 'px)');
            $('.ball').css('background-size', 50 + $(this).scrollTop() / 4);
        }
    });
});
