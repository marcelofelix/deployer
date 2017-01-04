require 'fileutils'
require 'pathname'

class Bucket
  def initialize(name, s3: Aws::S3::Client.new(region: 'us-east-1'))
    @name = name
    @s3 = s3
  end

  def copy(prefix)
    list(prefix: prefix).each do |o|
      file = "/tmp/#{o.key}"
      path = Pathname.new(file)
      FileUtils.mkdir_p path.dirname unless File.exists? path.dirname
      unless o.key.end_with?('/')
        File.open(file, 'wb') do |f|
          s3.get_object( {bucket: name, key: o.key }, target: f)
        end
      end
    end
  end

  def list(opts = {})
    options = { bucket: name }.merge(opts)
    s3.list_objects(options).contents
  end

  private

  attr_reader :s3, :name
end

