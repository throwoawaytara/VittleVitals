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

$(function() {
  var pathName = window.location.pathname;
  var regex = /\/users\/\d\/([A-z]+).*/;
  var idUrlName = pathName.replace(regex, "_\$1");

    $("#" + idUrlName).parent().addClass('active');

  addButtonClassName = "left glyphicon glyphicon-plus-sign";

  $(".add-recipe-button").on("click", function(event) {
    event.preventDefault();

    $(event.target).removeClass("glyphicon-plus-sign");
    $(event.target).addClass("glyphicon-ok");
    addButtonClassName = this.children[0].className;
  });

  $(".add-favorite-recipe-button").on("click", function(event) {
    event.preventDefault();

    $(this).first("span").addClass("glyphicon-ok")

    if (addButtonClassName === "left glyphicon glyphicon-plus-sign") {
      console.log(this);
    }
  });
});

