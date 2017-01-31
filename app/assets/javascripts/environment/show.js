$(function() {
  if ($('.environments_show').length) {
    $('.remove-replace').click(function() {
      const el = $(this);
      const id = el.data('id');
      axios.delete('/replaces/' + id + '?authenticity_token=' + token())
        .then(function() {
          el.closest('tr').remove();
        });
    });

    $('#btnAddReplace').click(function() {
      const el = $(this);
      const project = el.data('project');
      const env = el.data('env');
      axios.post('/replaces?authenticity_token=' + token() , {
        project_id: project,
        id: env,
        replace: {
          file: $('#file').val(),
          key: $('#key').val(),
          value: $('#value').val()
        }
      }).then(function() { location.reload(); });
    });

    function token() {
      return $('meta[name=csrf-token]').attr('content');
    }
  }
});
