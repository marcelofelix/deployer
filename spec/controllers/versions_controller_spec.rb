require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  it 'create' do
    project = create(:project)
    post 'create', params: {
      project_id: project.id,
      name: '322'
    }
    expect(Version.count).to eq 1
  end

  it 'deploy' do
    environment = create(:environment)
    version = create(:version, project: environment.project)
    version
    post 'deploy', id: version.id, params: {
      environment_id: environment.id,
      id: version.id
    }
    environment.reload
    expect(environment.version).to eq version.name

  end

end
