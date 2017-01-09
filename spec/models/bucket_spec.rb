require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it 'test list objects' do
    client = instance_double('Aws::S3::Client')
    expect(client).to receive(:list_objects).and_return double(
      contents: [
        double(key: 'app/'),
        double(key: 'app/file')
      ]
    )

    bucket = Bucket.new('bucket_name', s3: client)
    expect(bucket.list).to eq ['app/', 'app/file']
  end

  it 'test list objects with prefix' do
    client = instance_double('Aws::S3::Client')
    expect(client).to receive(:list_objects).and_return double(
      contents: [
        double(key: 'app/'),
        double(key: 'app/file')
      ]
    )

    bucket = Bucket.new('bucket_name', s3: client, prefix: 'app/')
    expect(bucket.list).to eq ['file']
  end

  it 'test download object' do
    client = instance_double('Aws::S3::Client')
    file = double('File')

    expect(client).to receive(:get_object).with(
      { bucket: 'bucket_name', key: 'key' }, target: file
    )

    bucket = Bucket.new('bucket_name', s3: client)
    bucket.download('key', file)
  end

  it 'test download object with prefix' do
    client = instance_double('Aws::S3::Client')
    file = double('File')

    expect(client).to receive(:get_object).with(
      { bucket: 'bucket_name', key: 'teste/key' }, target: file
    )

    bucket = Bucket.new('bucket_name', s3: client, prefix: 'teste/')
    bucket.download('key', file)
  end

  it 'test upload file' do
    client = instance_double('Aws::S3::Client')
    file = double('File')

    expect(client).to receive(:put_object).with(
      acl: 'public-read',
      bucket: 'bucket_name',
      body: file,
      key: 'key'
    )

    bucket = Bucket.new('bucket_name', s3: client)
    bucket.upload('key', file)
  end

  it 'test upload file with prefix' do
    client = instance_double('Aws::S3::Client')
    file = double('File')

    expect(client).to receive(:put_object).with(
      acl: 'public-read',
      bucket: 'bucket_name',
      body: file,
      key: 'app/key'
    )

    bucket = Bucket.new('bucket_name', s3: client, prefix: 'app/')
    bucket.upload('key', file)
  end
end
