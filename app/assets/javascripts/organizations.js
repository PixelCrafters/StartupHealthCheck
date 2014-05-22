$(document).ready(function() {
  $('#hiring').change(function() {
    $('form#toggle-organization-hiring').submit();
    location.reload();
  });
});
