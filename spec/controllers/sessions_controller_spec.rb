require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it 'Test that signout remove user id from session' do
    session[:user_id] = 'x'
    get :destroy
    expect(session[:user_id]).to be_nil
  end

  it 'Test that signin with user already exists create a session' do
    user = create(:user, name: 'Marcelo')
    expect(User).to receive(:find_by_provider_and_uid).and_return user

    request.env['omniauth.auth'] = {
      'extra' => { 'raw_info' => { 'company' => 'VivaReal' }},
    }
    post :create, params: { 'provider' => 'github' }
    expect(session[:user_id]).to eq user.id
  end

  it 'Test that signup create a user and a session' do
    user = create(:user, name: 'Marcelo')
    expect(User).to receive(:find_by_provider_and_uid).and_return nil
    expect(User).to receive(:create_with_omniauth).and_return user

    request.env['omniauth.auth'] = {
      'extra' => { 'raw_info' => { 'company' => 'VivaReal' }},
    }
    post :create, params: { 'provider' => 'github' }
    expect(session[:user_id]).to eq user.id
  end

  it 'Test that signup with user without valid company dont create session' do
    request.env['omniauth.auth'] = {
      'extra' => { 'raw_info' => { 'company' => 'X' }},
    }
    post :create, params: { 'provider' => 'github' }
  end
end
