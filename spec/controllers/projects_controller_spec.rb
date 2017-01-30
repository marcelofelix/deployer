require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  before do
    allow(controller).to receive(:current_user)
      .and_return create(:user, name: 'Marcelo')
  end

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
