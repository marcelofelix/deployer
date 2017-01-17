$(function() {

  if ($('.projects_show').length) {
    $('#btnNewEnv').click(newEnv);
    $('#btnSaveEnv').click(saveEnv);
    $('.replace-modal').click(function() {
      const id = $(this).data('env');
      showReplace(id);
    });
  }

  function newEnv() {
    $('#envModal').modal('show');
  }

  function showReplace(envId) {
    envService.get(envId)
      .then(function(res) {
        _.forEach(res.data.replaces, function(r) {
          const replace = HandlebarsTemplates['environments/replace_item']({
            file: r.file,
            key: r.key,
            value: r.value
          });
          $('#replaceTable').append(replace);
        });
        $('#replaceModal').modal('show');
      });
  }

  function saveEnv() {
    if (_.every([validate(envName()), validate(envBucket())])) {
      envService.create(project(), {
        name: envName().val(),
        bucket_name: envBucket().val()
      })
        .then(function() {
          location.reload();
        });
    }
  }

  function validate(el) {
    if (!el.val()) {
      el.parent().addClass('has-error');
      return false;
    } else {
      el.parent().removeClass('has-error');
    }
    return true;
  }

  function envName() {
    return $('#envName');
  }

  function envBucket() {
    return $('#envBucket');
  }

  function project() {
    return $('#project').data('id');
  }
});
