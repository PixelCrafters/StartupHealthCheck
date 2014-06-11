var ready;

ready = function() {
  $('.multiselect-types').multiselect({
    buttonClass: 'btn btn-link',
    nonSelectedText: 'Filter by organization type',
    includeSelectAllOption: true,
    includeSelectAllDivider: true,
    filterPlaceholder: 'Search Types',
    dropLeft: true
  });

  $('.multiselect-tags').multiselect({
    buttonClass: 'btn btn-link',
    nonSelectedText: 'Filter by tag',
    includeSelectAllOption: true,
    includeSelectAllDivider: true,
    filterPlaceholder: 'Search Types',
    dropLeft: true
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
