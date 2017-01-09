require 'storage'
require 'pry'

# Represents the process to deploys a version
# to an environment
class Deploy
  def initialize(env, version, opts = {})
    @env = env
    @version = version.end_with?('/') ? version : "#{version}/"
    @storage = opts.fetch(:storage, Storage.new)
  end

  def download(bucket = version_bucket)
    bucket.list.each do |k|
      storage.create k do |f|
        bucket.download(k, f)
      end
    end
  end

  def replace
    env.replaces.each do |r|
      storage.replace(r.file, r.key, r.value)
    end
  end

  def upload(bucket = env_bucket)
    env.version = version
    env.save
    storage.files.each do |f|
      bucket.upload(f.key, File.open(f.path))
    end
  end

  private

  def env_bucket
    @env_bucket ||= Bucket.new(env.bucket_name)
  end

  def version_bucket
    @version_bucket ||= Bucket.new(env.project_bucket, prefix: version)
  end

  attr_reader :env, :version, :storage
end
