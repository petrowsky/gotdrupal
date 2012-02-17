// $Id: rss_enclosure.js 5 2009-02-13 08:20:01Z matt $
/**
 * RSS Enclosure javascript.
 */
if (Drupal.jsEnabled) {
  $(document).ready(function() {
    var popup = $("#rss-enclosure-url > option:selected").html();
    var type = /\(.*\)$/.exec(popup);
    var show = type != '(filefield)' && type != null;
    // $('#edit-rss-enclosure-url-base-wrapper').text(show);
    if (show) {
      $('.rss-enclosure-hide').show();
    };
    $('#rss-enclosure-url').change(function() {
    //   // var x = $(this).val();
      var selected = $("option:selected").html();
      var type = /\(.*\)$/.exec(selected);
      // console.log(type);
      if (type != '(filefield)' && type != null){
        $('.rss-enclosure-hide').show();
      }else{
        $('.rss-enclosure-hide').hide();
      };
    });
  });
}