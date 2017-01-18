# Represents the environment of an application
class Environment < ApplicationRecord
  belongs_to :project
  has_many :replaces, dependent: :destroy

  def project_bucket
    project.bucket_name
  end
end
