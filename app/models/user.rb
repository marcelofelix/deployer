# frozen_string_literal: true
#
# Represents the user
class User < ApplicationRecord
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.logo = auth['info']['image']
    end
  end
end
