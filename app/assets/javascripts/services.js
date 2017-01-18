const projectService = {
  create: function(project) {
    return axios.post('/projects', { project: project });
  },

  versions: function(id) {
    return axios.get('/projects/' + id + '/versions');
  }
};

const envService = {
  create: function(projectId, env) {
    return axios.post('/environments', {
      environment: env,
      project_id: projectId
    });
  },

  addReplace: function(env, file, key, value) {
    return axios.post('/environments/' + env + '/replace', {
      id: env,
      replace: {
        file: file,
        key: key,
        value: value
      }
    });
  },

  removeReplace: function(id) {
    return axios.delete('/environments/replace/' + id);
  },

  delete: function(id) {
    return axios.delete('/environments/' + id);
  },

  get: function(id) {
    return axios.get('/environments/' + id);
  },

  deploy: function(env, version) {
    return axios.post('/environments/' + env + '/deploy', {
      version: version
    });
  }
};
