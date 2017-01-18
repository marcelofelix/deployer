const projectService = {
  list: function list() {
    return axios.get('/projects.json');
  },
  create: function create(project) {
    return axios.post('/projects', { project: project });
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
  }

  get: function(id) {
    return axios.get('/environments/' + id);
  }
};
