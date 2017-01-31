# frozen_string_literal: true
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
    @content_types = opts.fetch(:metadata, {})
  end

  def download(storage)
    list.each do |k|
      storage.create k do |f|
        resp = s3.get_object({ bucket: name, key: add_prefix(k) }, target: f)
        @content_types[k] = resp.content_type
      end
    end
  end

  def upload(storage)
    keys = storage.keys
    keys.each do |k|
      s3.put_object(upload_param(k, storage.open(k)))
    end
    keys
  end

  def list
    options = { bucket: name, prefix: prefix }.delete_if { |_k, v| v.nil? }
    @objects ||= s3.list_objects(options).contents.map do |o|
      del_prefix o.key
    end.delete_if(&:empty?)
  end

  def remove(key)
    s3.delete_object(bucket: name, key: key)
  end

  private

  def upload_param(key, file)
    {
      acl: 'public-read',
      bucket: name,
      body: file,
      key: add_prefix(key),
      content_type: @content_types[key]
    }.compact
  end

  def del_prefix(value)
    value.sub(prefix.to_s, '')
  end

  def add_prefix(value)
    "#{prefix}#{value}"
  end

  attr_reader :s3
end
