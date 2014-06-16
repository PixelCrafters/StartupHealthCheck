$(document).on('change', '#email_digest', function() {
  $('form#toggle-email-digest-subscription').submit();
  location.reload();
});
