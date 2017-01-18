const projectService = {
  versions: function(id) {
    return axios.get('/projects/' + id + '/versions');
  }
};

const envService = {

  remove: function(project, id) {
    return axios.delete('/projects/' + project + '/environments/' + id);
  },

  removeReplace: function(id) {
    return axios.delete('/environments/replace/' + id);
  },

  deploy: function(env, version) {
    return axios.post('/environments/' + env + '/deploy', {
      version: version
    });
  }
};
