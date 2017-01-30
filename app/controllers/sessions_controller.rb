class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    company = auth.dig('extra', 'raw_info', 'company')
    if company == 'VivaReal'
      user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to root_url, notice:  'Usuário não faz parte do VivaReal'
    end
  end

  def destroy
    session[:user_id] = nil
  end
end
