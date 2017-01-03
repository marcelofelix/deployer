class S3
  def self.buckets
    client.list_buckets
  end

  def self.folders(name)
    client.list_objects(
      bucket: name
    ).contents.map do |o|
      Struct::Build.new(o.key)
    end
  end

  def self.client
    @@client ||= Aws::S3::Client.new(region: 'us-east-1')
  end
end

Struct.new('Build', :name)
