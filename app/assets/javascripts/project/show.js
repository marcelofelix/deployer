$(function() {
  if ($('.projects_show').length) {
    $('.btn-remove-env').click(function() {
      if (confirm('Do you want to remove this environment?')) {
        const el = $(this);
        envService.remove(el.data('project'), el.data('id'))
          .then(function() {
            location.reload();
          });
      }
    });
  }
});
