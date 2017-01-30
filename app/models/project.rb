# frozen_string_literal: true
# Represents a project
class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :bucket_name, presence: true, uniqueness: true
  has_many :environments
  has_many :versions

  def list_versions(bucket = Bucket.new(bucket_name))
    @versions ||= bucket.list.map { |k| k.split '/' }
                        .delete_if { |k| k.size < 2 }
                        .map(&:first).uniq
  end
end
