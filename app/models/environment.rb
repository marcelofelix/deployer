# Represents the environment of an application
class Environment < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :bucket_name, presence: true, uniqueness: true
  validates :region, presence: true
  belongs_to :project
  has_many :replaces, dependent: :destroy

  def project_bucket
    project.bucket_name
  end

  def project_name
    project.name
  end

  def project_versions
    project.list_versions
  end
end
