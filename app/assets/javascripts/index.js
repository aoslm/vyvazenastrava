/**
 * Created with JetBrains RubyMine.
 * User: petertruchan
 * Date: 29.4.2013
 * Time: 20:57
 * To change this template use File | Settings | File Templates.
 */
$(function () {
    $('.filtre').hide();
    $('#categoryshow').hide();

    $('#categoryshow').click(function () {
        $('.filtre').hide();
        $('.categoryselect').show();
        $('#categoryshow').hide();
        $('#filter').show();


    });

    $('#filter').click(function () {
        $('.categoryselect').hide();
        $('.filtre').show();
        $('#filter').hide();
        $('#categoryshow').show();
    });


});


