const projectService = {
  versions: function(id) {
    return axios.get('/projects/' + id + '/versions');
  }
};

const envService = {

  remove: function(project, id, token) {
    let url = '/projects/';
    url += project + '/environments/' + id;
    url += '?authenticity_token=' + token;
    return axios.delete(url);
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
