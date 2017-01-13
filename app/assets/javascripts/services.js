const projectService = {
  list: function list() {
    return axios.get('/projects.json');
  },
  create: function create(project) {
    return axios.post('/projects', { project: project });
  }
}
