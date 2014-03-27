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
//= require jquery_ujs
//= require_tree .
$(document).ready(function() {

  $("#remove-recipe").on("submit", function(e) {
    e.preventDefault()
    
    var url = $(this).attr("action");
    var data = $(this).serialize();
    $.post(url, data, function(serverResponse, status, request){
      // $removeForm.replaceWith($addForm);
    });
    $(this).find(".glyphicon").toggleClass("glyphicon-plus-sign").toggleClass("glyphicon-ok")
    $("#remove-recipe").parent().replaceWith($("#add-recipe").parent());
  })

  $("#add-recipe").on("submit", function(e) {

    e.preventDefault()
    var url = $(this).attr("action");
    var data = $(this).serialize();
    $.post(url, data, function(serverResponse, status, request){
      $(this).find(".glyphicon").toggleClass("glyphicon-plus-sign").addClass("glyphicon-ok")
      $("#remove-recipe").parent().replaceWith($("#add-recipe").parent());
    });
    // $(this).off("submit")
  })
})


$(function() {
  var pathName = window.location.pathname;
  var regex = /\/users\/\d\/([A-z]+).*/;
  var idUrlName = pathName.replace(regex, "_\$1");

    $("#" + idUrlName).parent().addClass('active');

});

