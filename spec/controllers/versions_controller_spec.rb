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

end
