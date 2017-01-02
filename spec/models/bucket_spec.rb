require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it 'list buckets' do
    client = double('S3 Client')
    bucket = Bucket.new('teste', client: client)
    expect(client).to receive(:list_objects).and_return double(
      contents: []
    )
    puts bucket.list
  end
end
