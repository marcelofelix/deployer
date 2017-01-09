require 'rails_helper'

RSpec.describe Deploy, type: :model do
  let(:storage) { instance_double('Storage') }
  let(:bucket) { instance_double('Bucket') }
  let(:env) { create(:environment) }

  it 'test download version' do
    file = double('File')

    expect(bucket).to receive(:list).and_return ['app/', 'app/file.js']
    expect(bucket).to receive(:download).with('app/', file)
    expect(bucket).to receive(:download).with('app/file.js', file)

    expect(storage).to receive(:create).with('app/').and_yield file
    expect(storage).to receive(:create).with('app/file.js').and_yield file

    deploy = Deploy.new(env, '1', storage: storage)
    deploy.download(bucket)
  end

  it 'test replace files' do
    replace = create(:replace, environment: env)
    expect(storage).to receive(:replace).with(replace.file, replace.key, replace.value)
    deploy = Deploy.new(env, '1', storage: storage)
    deploy.replace
  end

  it 'test upload file' do
    expect(storage).to receive(:files).and_return [
      double(key: 'file1', path: '/tmp/file1'),
      double(key: 'file2', path: '/tmp/file2')
    ]

    file = double('file')
    expect(File).to receive(:open).with('/tmp/file1').and_return file
    expect(File).to receive(:open).with('/tmp/file2').and_return file

    expect(bucket).to receive(:upload).with('file1', file)
    expect(bucket).to receive(:upload).with('file2', file)

    deploy = Deploy.new(env, '1', storage: storage)
    deploy.upload(bucket)
  end
end
