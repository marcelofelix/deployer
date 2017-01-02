class Bucket
  def initialize(name, client: Aws::S3::Client.new)
    @name = name
    @client = client
  end

  def list
    @objects ||= client.list_objects(
      bucket: name
    ).contents.map do |o|
      Struct::Build.new(o.key)
    end
  end

  private

  attr_reader :client, :name
end

Struct.new('Build', :name)
