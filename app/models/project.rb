class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :bucket_name, presence: true, uniqueness: true
  has_many :environments
  has_many :versions

  def list_versions(bucket = Bucket.new(bucket_name))
    @versions ||= bucket.list.map(&:key)
  end
end
