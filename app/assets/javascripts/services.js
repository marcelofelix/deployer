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

  get: function(id) {
    return axios.get('/environments/' + id);
  }
};
