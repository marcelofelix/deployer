require 'storage'

class Bucket
  attr_reader :name, :region, :prefix

  def initialize(name, opts = {})
    @name = name
    @prefix = opts[:prefix]
    @region = opts.fetch(:region, 'us-east-1')
    @s3 = opts.fetch(:s3, Aws::S3::Client.new(region: region))
    @storage = opts.fetch(:storage, Storage.new)
  end

  def download_all
    list.each do |key|
      download(key)
    end
  end

  def download(key)
    file = key.sub("#{ prefix }", '')
    storage.create(file) do |f|
      s3.get_object( {bucket: name, key: key }, target: f)
    end
  end

  def upload(file)
    obj = s3.bucket(name).object(file)
    obj.upload_file(file)
  end

  def list
    options = { bucket: name, prefix: prefix }.delete_if { |k, v| v.nil? }
    @objects ||= s3.list_objects(options).contents.map(&:key)
  end

  private

  attr_reader :s3, :storage
end

