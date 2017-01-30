require 'rails_helper'

RSpec.describe DeployController, type: :controller do
  before do
    allow(controller).to receive(:current_user)
      .and_return create(:user, name: 'Marcelo')
  end

  it 'Test deploy a new version' do
    env = create(:environment)
    deploy = instance_double(Deploy)
    expect(deploy).to receive(:execute)
    expect(Deploy).to receive(:new).and_return deploy

    post :deploy, params: {
      version: 'x',
      env: env.id
    }
  end

  it 'Test that index load environment' do
    env_id = '1'
    expect(Environment).to receive(:find).with(env_id)
    get :index, params: { env: env_id }
  end
end
