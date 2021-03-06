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
//= require jquery-ui
//= require cocoon
//= require autocomplete-rails
//= require jqcloud
//= require bootstrap-sprockets
//= require jquery.datetimepicker
//= require turbolinks
//= require detect_timezone
//= require jquery.detect_timezone
//= require_tree .

$(document).on("page:load ready", function(){
    $("input.datepicker").datepicker();
});

$(document).on("page:load ready", function() {
  $('input.datetimepicker').datetimepicker({format: "Y-m-d H:i", formatDate: 'm/d/Y', formatTime:'g:i a'});
});
