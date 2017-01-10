new Vue({
  el: '#projects',
  data: {
    projects: [],
    project: {
      name: '',
      bucket_name: ''
    },
    errors: []
  },
  created: function() {
    const that = this;
    axios.get('/projects.json')
    .then(function(res) {
      that.projects = res.data;
    });
  },
  methods: {
    create: function() {
      console.log('create');
      const that = this;
      axios.post('/projects', {
        project: that.project
      })
      .then(function(res) {
        that.projects.push(res.data);
        that.clean();
      })
      .catch((err) => that.errors = err.response.data.errors);
    },

    clean: function() {
      const that = this;
      that.project.name = '';
      that.project.bucket_name = '';
      that.errors = [];
    }
  }
});

new Vue({
  el: '#project',
  data: {
    name: '',
    bucket_name: '',
    environments: []
  },
  created: function(){
    axios.get('/projects/3.json')
    .then(function(res) {
      that.projects = res.data;
    });
  }
});
