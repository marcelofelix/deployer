$(function() {

  if ($('.projects_show').length) {
    $('#btnNewEnv').click(newEnv);
    $('#btnSaveEnv').click(saveEnv);
    $('#btnSaveRep').click(saveReplace);
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
          const replace = replaceItem({
            id: r.id,
            file: r.file,
            key: r.key,
            value: r.value
          });
          $('#replaceTable').append(replace);
        });
        $('#replaceModal').modal('show');
      });
  }

  function saveReplace() {
    const fields =  [validate(file()), validate(key()), validate(value())];
    if (_.every(fields)) {
      envService
      const replace = replaceItem({
        file: file().val(),
        key: key().val(),
        value: value().val()
      });
      $('#replaceTable').append(replace);
    }
  }

  function replaceItem(ctx) {
    return HandlebarsTemplates['environments/replace_item'](ctx);
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

  function file() {
    return $('#repFile');
  }

  function key() {
    return $('#repKey');
  }

  function value() {
    return $('#repValue');
  }
});
