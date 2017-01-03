class Version < ApplicationRecord
  validates :name, presence: true
  belongs_to :project

  def deploy_to(env)
    env.version = name
  end

end
