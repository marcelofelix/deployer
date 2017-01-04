require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it 'list buckets' do
    s3 = double('S3 Client')
    bucket = Bucket.new('teste', s3: s3)
    expect(s3).to receive(:list_objects).and_return double(
      contents: []
    )
    puts bucket.list
  end

  it 'list objects' do
    s3 = double('S3')
    expect(s3).to receive(:list_objects)
      .with(bucket: 'teste')
      .and_return double(contents: [])
    bucket = Bucket.new('teste', s3: s3)
    bucket.list
  end

  it 'list objects with delimiter' do
    s3 = double('S3')
    expect(s3).to receive(:list_objects)
      .with(bucket: 'teste', delimiter: '/')
      .and_return double(contents: [])
    bucket = Bucket.new('teste', s3: s3)
    bucket.list(delimiter: '/')
  end

  it 'copy files' do
    bucket = Bucket.new('build.owners-site.com.br')
    bucket.copy('app')
  end
end
