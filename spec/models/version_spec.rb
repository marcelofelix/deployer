require 'rails_helper'

RSpec.describe Version, type: :model do
  it 'deploy new version' do
    env = create(:environment)
    version = create(:version, project: env.project)
    version.deploy_to env
    expect(env.version).to eq version.name
  end
end
