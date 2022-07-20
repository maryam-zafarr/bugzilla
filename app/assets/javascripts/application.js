// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap
$(document).ready(function() {

  $('#bug_type').change(function(){

    var bug_type = $(this).val();

    $("#status").html("");

    // Loop over the json and populate the status options:
    if (bug_type == 'Feature') {
      $("#status").append( "<option value='New'>New</option>" );
      $("#status").append( "<option value='Started'>Started</option>" );
      $("#status").append( "<option value='Completed'>Completed</option>" );
    }
    else {
      $("#status").append( "<option value='New'>New</option>" );
      $("#status").append( "<option value='Started'>Started</option>" );
      $("#status").append( "<option value='Resolved'>Resolved</option>" );
    }
  });

});
