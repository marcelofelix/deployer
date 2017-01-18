$(function() {

  if ($('.projects_show').length) {
    let env;
    $('#btnNewEnv').click(newEnv);
    $('#btnSaveEnv').click(saveEnv);
    $('#btnSaveRep').click(saveReplace);
    $('.replace-modal').click(showReplaces);
    $('.version-modal').click(showVersions);
    $('.remove-env').click(removeEnv);

    // Environments

    function newEnv() {
      $('#envModal').modal('show');
    }

    function saveEnv() {
      if (valid(envName(), envBucket())) {
        envService.create(project(), {
          name: envName().val(),
          bucket_name: envBucket().val()
        })
          .then(function() {
            location.reload();
          });
      }
    }

    function removeEnv() {
      const env = $(this);
      envService.delete(env.data('id'))
        .then(function() {
          env.closest('tr').remove();
        });
    }

    // Replaces

    function removeReplaces() {
      $('.replace-item').remove();
      cleanReplaceForm();
    }

    function cleanReplaceForm() {
      file().val('');
      key().val('');
      value().val('');
    }

    function showReplaces() {
      env = $(this).data('id');
      removeReplaces();
      envService.get(env)
        .then(function(res) {
          res.data.replaces.forEach(function(r) {
            $('#replaceTable').append(replaceItem(r));
          });
          $('#replaceModal').modal('show');
          $('.btn-remove-rep').click(removeReplace);
        });
    }

    function removeReplace() {
      const replace = $(this);
      envService.removeReplace(replace.data('id'))
      .then(function() {
        replace.closest('tr').remove();
      });
    }

    function saveReplace() {
      if (valid(file(), key(), value())) {
        envService.addReplace(env, file().val(), key().val(), value().val())
          .then(function(res) {
            $('#replaceTable').append(replaceItem(res.data));
            cleanReplaceForm();
          });
      }
    }

    function replaceItem(ctx) {
      return HandlebarsTemplates['environments/replace_item'](ctx);
    }

    // Versions

    function showVersions() {
      env = $(this).data('id');
      $('#versionList > li').remove();
      projectService.versions(project())
        .then(function(res) {
          res.data.forEach(function(v) {
            $('#versionList').append(versionItem(v));
          });
          $('#versionModal').modal('show');
          $('.deploy-version').click(deploy);
        });
    }

    function deploy() {
      const version = $(this).data('version');
      envService.deploy(env, version)
        .then(function() {
          console.log('ok');
        });
    }

    function versionItem(name) {
      return HandlebarsTemplates['versions/list_item']({
        name: name
      });
    }

    // Validation

    function valid() {
      return _.every(_.map(arguments, function(a) {
        return validate(a);
      }));
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
  }

});
