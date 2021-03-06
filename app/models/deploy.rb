# frozen_string_literal: true
require 'storage'

# Represents the process to deploys a version
# to an environment
class Deploy
  def initialize(env, version, opts = {})
    @env = env
    @version = version
    @storage = opts.fetch(:storage, Storage.new)
    @uploaded_files = []
    @metadata = {}
  end

  def download(bucket = version_bucket)
    bucket.download(storage)
  end

  def current_version(bucket = env_bucket)
    @current_version ||= bucket.list
  end

  def delete_last_version(bucket = env_bucket)
    @current_version&.each do |f|
      bucket.remove(f) unless @uploaded_files.include? f
    end
  end

  def replace
    env.replaces.each do |r|
      storage.replace(r.file, r.key, r.value)
    end
  end

  def upload(bucket = env_bucket)
    @uploaded_files = bucket.upload(storage)
  end

  def update_env
    env.version = version
    env.save
  end

  def execute
    current_version
    download
    replace
    upload
    delete_last_version
    update_env
  end

  private

  def env_bucket
    @env_bucket ||= Bucket.new(env.bucket_name,
                               region: env.region,
                               metadata: @metadata)
  end

  def version_bucket
    @version_bucket ||= Bucket.new(env.project_bucket,
                                   region: env.project.region,
                                   prefix: "#{version}/",
                                   metadata: @metadata)
  end

  attr_reader :env, :version, :storage
end
