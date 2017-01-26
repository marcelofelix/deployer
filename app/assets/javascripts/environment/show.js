$(function() {
  if ($('.environments_show').length) {
    $('.remove-replace').click(function() {
      const el = $(this);
      const id = el.data('id');
      axios.delete('/replaces/' + id)
        .then(function() {
          el.closest('tr').remove();
        });
    });

    $('#btnAddReplace').click(function() {
      const el = $(this);
      const project = el.data('project');
      const env = el.data('env');
      axios.post('/replaces/', {
        project_id: project,
        id: env,
        replace: {
          file: $('#file').val(),
          key: $('#key').val(),
          value: $('#value').val()
        }
      }).then(function() { location.reload(); });
    });
  }
});
