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

    $('#status').html("");

    // Loop over the json and populate the status options:
    if (bug_type == 'Feature') {
      $('#status').append( "<option value='New'>New</option>" );
      $('#status').append( "<option value='Started'>Started</option>" );
      $('#status').append( "<option value='Completed'>Completed</option>" );
    }
    else {
      $('#status').append( "<option value='New'>New</option>" );
      $('#status').append( "<option value='Started'>Started</option>" );
      $('#status').append( "<option value='Resolved'>Resolved</option>" );
    }
  });

});
