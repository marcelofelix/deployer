$(function() {

  if ($('.projects_new').length) {
    $('#btnAddEvn').click(addEnv);
    $('#btnSaveProject').click(saveProject);
  }

  function saveProject() {
    if (!_.every([validate(projectName()), validate(projectBucket())])) {
      projectServices.create({name: projectName().val(), bucket_name: projectBucket().value() })
        .then(function(res) {
          console.log('teste');
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

  function addEnv() {
    if (!_.every([validate(envName()), validate(envBucket())])) {
      const env = createEnv(envName().val(), envBucket().val());
      env.data('env_name', envName().val());
      env.data('env_buckete-name', envBucket().val());
      env.addClass('list-group-item env-item');
      $('#env-list').append(env);
      envName().val('');
      envBucket().val('');
    }
  }

  function createEnv(name, bucket) {
    return $(`
      <li class="list-group-item">
          <div class="container">
            <div class="row">
              <div class="col-xs-5"><label>Name: </label> ${name}</div>
              <div class="col-xs-7"><label>Bucket: </label> ${bucket}</div>
            </div>
          </div>
        </li>
    `);
  }

  function projectName() {
    return $('#name');
  }

  function projectBucket() {
    return $('#bucket');
  }

  function envName() {
    return $('#env_name');
  }

  function envBucket() {
    return $('#env_bucket');
  }
});
