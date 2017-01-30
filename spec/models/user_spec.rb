require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Test create user with github info' do

    auth = {
      'provider' => 'github',
      'uid' => 'aslkdjfa;sdfk',
      'info' => {
        'name' => 'Marcelo',
        'image' => 'image.jpg'
      }

    }
    User.create_with_omniauth(auth)
    expect(User.count).to eq 1
    user = User.first
    expect(user.provider).to eq 'github'
    expect(user.uid).to eq 'aslkdjfa;sdfk'
    expect(user.name).to eq 'Marcelo'
    expect(user.logo).to eq 'image.jpg'
  end
end
