// thng2.js
$(document).ready(function() {   

  $(".resizable").resizable();
  $("input.url_field").resizable();

  // $('div#switcher').themeswitcher();
    $("button#new_theme_button").click(function() {
	var myval2= $("select#select_theme").val();
        $("head link#jqtheme").attr("href","/jquery_ui172/css/"+myval2+"/jquery-ui-1.7.2.custom.css");
    });

  $("div#accordion").accordion({
      autoHeight: false,
      collapsible: true
    // I like plain click better than open-by-mouseover
    //                event: "mouseover"
  });

  $("#tabs").tabs();


  // check if photo url is good
  $("a#chkphotos").click(function() {
    var src1=$("input#thng_img1").attr("value");
    var src2=$("input#thng_img2").attr("value");
    var src3=$("input#thng_img3").attr("value");
    var src4=$("input#thng_img4").attr("value");
    $("div#thng_img_out").html("<br />");
    $("div#thng_img_out").
      append("<img src='" + src1 + "' /><hr />").
      append("<img src='" + src2 + "' /><hr />").
      append("<img src='" + src3 + "' /><hr />").
      append("<img src='" + src4 + "' /><hr />");
   });

  // check if video HTML is good
  $("a#chkvideo").click(function() {
    var srcv1=$("input#thng_video1").attr("value");
    var srcv2=$("input#thng_video2").attr("value");
    var srcv3=$("input#thng_video3").attr("value");
    var srcv4=$("input#thng_video4").attr("value");
    $("div#thng_video_out").html("<br />");
    $("div#thng_video_out").
      append("<hr />"+srcv1).
      append("<hr />"+srcv2).
      append("<hr />"+srcv3).
      append("<hr />"+srcv4+"<hr />");
   });

  // check if url is good
  $("a#chkurls").click(function() {
    var href1=$("input#thng_url1").attr("value");
    var href2=$("input#thng_url2").attr("value");
    var href3=$("input#thng_url3").attr("value");
    var href4=$("input#thng_url4").attr("value");
    $("div#thng_url_out").html("<br />");
    $("div#thng_url_out").
      append("<a href='" + href1 + "' target='u'>"+ href1 +"</a><br />").
      append("<a href='" + href2 + "' target='u'>"+ href2 +"</a><br />").
      append("<a href='" + href3 + "' target='u'>"+ href3 +"</a><br />").
      append("<a href='" + href4 + "' target='u'>"+ href4 +"</a><br />");
   });

});
