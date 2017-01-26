require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it 'index' do
    get :index
    expect(response).to be_succes
  end

  it 'create' do
    params = {
      project: {
        name: 'Teste',
        bucket_name: 'teste',
        region: 'x'
      }
    }
    post :create, params: params
    expect(Project.count).to eq 1
  end
end
