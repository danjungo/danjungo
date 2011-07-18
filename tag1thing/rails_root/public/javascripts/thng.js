// thng.js
$(document).ready(function() {   
  // do stuff when DOM is ready
  $("div#thng_tag34").hide();
  $("div#thng_img").hide();
  $("div#thng_video").hide();
  $("div#thng_url").hide();
  $("div#thng_dsc").hide();
  $("div#thng_why").hide();

//  $("div#thng_dsc").show();
//  $("div#thng_why").show();
//  $("div#divthng_tag3").show();
//  $("div#divthng_tag4").show();
//  $("div#thng_url").show();

  // events below

  // check if video HTML is good
  $("a#chkvideo").click(function() {
    var srcv1=$("input#thng_video1").attr("value");
    var srcv2=$("input#thng_video2").attr("value");
    var srcv3=$("input#thng_video3").attr("value");
    var srcv4=$("input#thng_video4").attr("value");
    $("div#thng_video1out").html("<br />");
    $("div#thng_video1out").
      append("<hr />"+srcv1).
      append("<hr />"+srcv2).
      append("<hr />"+srcv3).
      append("<hr />"+srcv4+"<hr />");
   });

// Most syntax above this line will get removed

  // After click of add_tags-anchor, display more tag-fields
  $("a#add_tags34").click(function() {
    $("a#add_tags34").slideUp("slow");
    $("div#thng_tag34").slideDown("slow");
   });

  // After click of add_img-anchor, display more fields
  $("a#add_img").click(function() {
    $("a#add_img").slideUp("slow");
    $("div#thng_img").slideDown("slow");
   });
  
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

  // After click of add_video-anchor, display more fields
  $("a#add_video").click(function() {
    $("a#add_video").slideUp("slow");
    $("div#thng_video").slideDown("slow");
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

  // After click of add_url-anchor, display more fields
  $("a#add_url").click(function() {
    $("a#add_url").slideUp("slow");
    $("div#thng_url").slideDown("slow");
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


  // After click of add_dsc-anchor, display more fields
  $("a#add_dsc").click(function() {
    $("a#add_dsc").slideUp("slow");
    $("div#thng_dsc").slideDown("slow");
   });


  // Collapse the form
  $("a#collapse_form").click(function() {
    $("a#add_tag34").slideDown("slow");
    $("div#thng_tag34").slideUp("slow");
    $("a#add_img").slideDown("slow");
    $("div#thng_img").slideUp("slow");
    $("a#add_video").slideDown("slow");
    $("div#thng_video").slideUp("slow");
    $("a#add_url").slideDown("slow");
    $("div#thng_url").slideUp("slow");
    $("a#add_dsc").slideDown("slow");
    $("div#thng_dsc").slideUp("slow");
   });

  // Expand the form
  $("a#expand_form").click(function() {
    $("a#add_dsc").slideUp("slow");
    $("a#add_img").slideUp("slow");
    $("a#add_tag34").slideUp("slow");
    $("a#add_url").slideUp("slow");
    $("a#add_video").slideUp("slow");
    $("div#thng_dsc").slideDown("slow");
    $("div#thng_img").slideDown("slow");
    $("div#thng_tag34").slideDown("slow");
    $("div#thng_url").slideDown("slow");
    $("div#thng_video").slideDown("slow");
   });

  // Accordion
//  $("#accordion").accordion({ header: "h3" });

});

