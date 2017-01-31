# frozen_string_literal: true
#
# Session controller
class SessionsController < ApplicationController
  def create
    if belongs_to 'VivaReal'
      user = find_user || create_user
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to root_url, notice: 'Usuário não faz parte do VivaReal'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: token)
  end

  def belongs_to(org)
    client.orgs.map{ |o| o[:login] }.include? org
  end

  def token
    auth.dig('credentials', 'token')
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  def find_user
    User.find_by_provider_and_uid(provider, uid)
  end

  def create_user
    User.create_with_omniauth(auth)
  end

  def provider
    auth['provider']
  end

  def uid
    auth['uid']
  end
end
