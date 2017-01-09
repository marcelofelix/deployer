require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it 'index' do
    get :index
    expect(response).to be_succes
  end

  it 'create' do
    post :create, params: { project: { name: 'Teste', bucket_name: 'teste' } }
    expect(Project.count).to eq 1
  end

  it 'show project by id' do
    project = create(:project)
    get 'show', params: { id: project.id }
    expect(response).to be_success
    expect(response.body).to eq project.to_json
  end
end
