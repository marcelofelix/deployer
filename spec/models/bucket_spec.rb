require 'rails_helper'

RSpec.describe Bucket, type: :model do
  let(:client) { client = instance_double('Aws::S3::Client') }
  it 'should list objects' do
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
    expect(client).to receive(:list_objects).and_return double(
      contents: [
        double(key: 'app/'),
        double(key: 'app/file')
      ]
    )

    bucket = Bucket.new('bucket_name', s3: client, prefix: 'app/')
    expect(bucket.list).to eq ['file']
  end

  it 'Should download file and save into storage' do
    file = double('File')
    storage = instance_double('Storage')
    expect(storage).to receive(:create).with('file.js').and_yield file

    expect(client).to receive(:get_object).with(
      { bucket: 'bucket_name', key: 'file.js' }, target: file
    ).and_return double(content_type: 'file')

    bucket = Bucket.new('bucket_name', s3: client)
    allow(bucket).to receive(:list).and_return ['file.js']
    bucket.download(storage)
  end

  it 'test download object with prefix' do
    file = double('File')
    storage = instance_double('Storage')
    expect(storage).to receive(:create).with('file.js').and_yield file

    expect(client).to receive(:get_object).with(
      { bucket: 'bucket_name', key: 'teste/file.js' }, target: file
    ).and_return double(content_type: 'file')

    bucket = Bucket.new('bucket_name', s3: client, prefix: 'teste/')
    allow(bucket).to receive(:list).and_return ['file.js']
    bucket.download(storage)
  end

  it 'Should upload files from storage' do
    file = double('File')
    storage = instance_double('Storage')
    expect(storage).to receive(:keys).and_return ['file.js']
    expect(storage).to receive(:open).with('file.js').and_return file

    expect(client).to receive(:put_object).with(
      acl: 'public-read',
      bucket: 'bucket_name',
      body: file,
      key: 'file.js'
    )

    bucket = Bucket.new('bucket_name', s3: client)
    bucket.upload(storage)
  end

  it 'test upload file with prefix' do
    file = double('File')
    storage = instance_double('Storage')
    expect(storage).to receive(:keys).and_return ['file.js']
    expect(storage).to receive(:open).with('file.js').and_return file

    expect(client).to receive(:put_object).with(
      acl: 'public-read',
      bucket: 'bucket_name',
      body: file,
      key: 'app/file.js'
    )

    bucket = Bucket.new('bucket_name', s3: client, prefix: 'app/')
    bucket.upload(storage)
  end

  it 'test remove key' do
    bucket_name = 'some bucket'
    key = 'some key'

    expect(client).to receive(:delete_object)
      .with(bucket: bucket_name, key: key)

    bucket = Bucket.new(bucket_name, s3: client)
    bucket.remove(key)
  end
end
