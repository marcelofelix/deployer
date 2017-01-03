require 'rails_helper'

RSpec.describe EnvironmentsController, type: :controller do
  it 'create' do
    project = create(:project)
    post 'create', params: {
      project_id: project.id,
      environment: {
        name: 'Production',
        version: '233',
        bucket_name: 'production.bucket'
      }
    }
    expect(Environment.count).to eq 1
  end
end
