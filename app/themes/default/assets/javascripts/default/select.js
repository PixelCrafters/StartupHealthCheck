$(document).ready(function() {
  $('.multiselect').multiselect({
    buttonClass: 'btn btn-link',
    nonSelectedText: 'Filter by organization type',
    includeSelectAllOption: true,
    includeSelectAllDivider: true,
    filterPlaceholder: 'Search Types',
    dropLeft: true
  });
});
