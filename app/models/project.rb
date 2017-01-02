class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :bucket, presence: true, uniqueness: true
  has_many :environments
  has_many :versions

  def sync_version(build_bucket: Bucket.new(bucket))
    build_bucket.list.each do |b|
      unless versions.collect { |v| v.name == b.name }.first
        versions << Version.create(project: self, name: b.name)
      end
    end
  end
end
