require 'rails_helper'

RSpec.describe EnvironmentsController, type: :controller do
  before do
    allow(controller).to receive(:current_user)
      .and_return create(:user, name: 'Marcelo')
  end

  it 'create' do
    project = create(:project)
    post 'create', params: {
      project_id: project.id,
      environment: {
        name: 'Production',
        version: '233',
        bucket_name: 'production.bucket',
        region: 'x'
      }
    }
    expect(Environment.count).to eq 1
  end
end
