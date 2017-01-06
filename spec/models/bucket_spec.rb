require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it 'test that list dont use prefix if it is nil' do
    s3 = instance_double('Aws::S3::Client')
    expect(s3).to receive(:list_objects)
      .with(bucket: 'teste')
      .and_return double(contents: [])
    Bucket.new('teste', s3: s3).list
  end

  it 'test that list use prefix if it is not nil' do
    s3 = instance_double('Aws::S3::Client')
    expect(s3).to receive(:list_objects)
      .with(bucket: 'teste', prefix: 'x')
      .and_return double(contents: [])
    Bucket.new('teste', prefix: 'x', s3: s3).list
  end

  it 'test that download_all list files and download each' do
    bucket_name, prefix, file_name = 'bucket', 'app/', 'app/file1'
    file = double(file_name)

    bucket = Bucket.new(bucket_name)
    expect(bucket).to receive(:list).and_return [prefix, file_name]
    expect(bucket).to receive(:download).with prefix
    expect(bucket).to receive(:download).with file_name

    bucket.download_all
  end

  it 'test that prefix is removed from key before store' do
    bucket_name, prefix, key = 'bucket', 'app/', 'app/file'
    file = double('File')

    storage = instance_double('Storage')
    expect(storage).to receive(:create).with('file').and_yield file

    s3 = instance_double('Aws::S3::Client')
    expect(s3).to receive(:get_object).with(
      { bucket: bucket_name, key: key }, target: file
    )


    bucket = Bucket.new(bucket_name, prefix: prefix, storage: storage, s3: s3)
    bucket.download(key)
  end

  it 'test that without previx copy all files' do
    bucket_name, key = 'bucket', 'app/file'
    file = double('File')

    storage = instance_double('Storage')
    expect(storage).to receive(:create).with('app/file')

    bucket = Bucket.new(bucket_name, storage: storage)
    bucket.download(key)
  end
end
