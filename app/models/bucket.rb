require 'storage'

# Represents a bucket at S3 and
# have basic operations
class Bucket
  attr_reader :name, :region, :prefix

  def initialize(name, opts = {})
    @name = name
    @prefix = opts[:prefix]
    @region = opts.fetch(:region, 'us-east-1')
    @s3 = opts.fetch(:s3, Aws::S3::Client.new(region: region))
  end

  def download(key, file)
    s3.get_object({ bucket: name, key: add_prefix(key) }, target: file)
  end

  def upload(key, file)
    s3.put_object(
      acl: 'public-read',
      bucket: name,
      body: file,
      key: add_prefix(key)
    )
  end

  def list
    options = { bucket: name, prefix: prefix }.delete_if { |_k, v| v.nil? }
    @objects ||= s3.list_objects(options).contents.map do |o|
      del_prefix o.key
    end.delete_if(&:empty?)
  end

  def delete(key)
    s3.delete_object(bucket: name, key: key)
  end

  def files
    storage.files
  end

  private

  def del_prefix(value)
    value.sub(prefix.to_s, '')
  end

  def add_prefix(value)
    "#{prefix}#{value}"
  end

  attr_reader :s3
end
