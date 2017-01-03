class Bucket
  def initialize(name, client: Aws::S3::Bucket.new(name, region: 'us-east-1'))
    @name = name
    @client = client
  end

  def list
    @objects ||= client.list_objects(
      bucket: name,
      delimiter: '/'
    ).contents.map do |o|
      Struct::Build.new(o.key)
    end
  end

  private

  attr_reader :client, :name
end

Struct.new('Build', :name)
