$(function () {
    var checkedId = $('form.rating_ballot > input:checked').attr('id');
    $('form.rating_ballot > label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
});

$(document).ready(function() {
    // Makes stars glow on hover.
    $('form.rating_ballot > label').hover(
        function() {    // mouseover
            $(this).prevAll().andSelf().addClass('glow');
        },function() {  // mouseout
            $(this).siblings().andSelf().removeClass('glow');
    });

    // Makes stars stay glowing after click.
    $('form.rating_ballot > label').click(function() {
        $(this).siblings().removeClass("bright");
        $(this).prevAll().andSelf().addClass("bright");
    });

    // Submits the form (saves data) after user makes a change.
    $('form.rating_ballot1').change(function() {
        $('form.rating_ballot1').submit();
    });
		$('form.rating_ballot2').change(function() {
        $('form.rating_ballot2').submit();
    });
		$('form.rating_ballot3').change(function() {
        $('form.rating_ballot3').submit();
    });
		$('form.rating_ballot4').change(function() {
        $('form.rating_ballot4').submit();
    });
		
});