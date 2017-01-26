require 'rails_helper'

RSpec.describe Deploy, type: :model do
  let(:storage) { instance_double('Storage') }
  let(:env_bucket) { instance_double('Bucket') }
  let(:version_bucket) { instance_double('Bucket') }
  let(:env) { create(:environment) }

  it 'Should download files from version bucket' do
    expect(version_bucket).to receive(:download).with(storage)
    deploy = Deploy.new(env, '1', storage: storage)
    deploy.download(version_bucket)
  end

  it 'should list files from env bucket e cache it' do
    files = ['app/', 'app/file.js']
    expect(env_bucket).to receive(:list).and_return files
    deploy = Deploy.new(env, '1', storage: storage)
    expect(deploy.current_version(env_bucket)).to eq files
  end

  it 'should remove last version from env bucket' do
    expect(env_bucket).to receive(:list).and_return ['file1.js', 'file2.js']
    expect(env_bucket).to receive(:remove).with('file1.js')
    expect(env_bucket).to receive(:remove).with('file2.js')

    deploy = Deploy.new(env, '1', storage: storage)
    deploy.current_version(env_bucket)
    deploy.delete_last_version(env_bucket)
  end

  it 'should not remove files that has been uploaded' do
    expect(env_bucket).to receive(:list).and_return ['index.html', 'file2.js']
    expect(env_bucket).to receive(:upload).and_return ['index.html']
    expect(env_bucket).to receive(:remove).with('file2.js')

    deploy = Deploy.new(env, '1', storage: storage)
    deploy.current_version(env_bucket)
    deploy.upload(env_bucket)
    deploy.delete_last_version(env_bucket)
  end

  it 'test replace files' do
    replace = create(:replace, environment: env)
    expect(storage).to receive(:replace).with(replace.file, replace.key, replace.value)
    deploy = Deploy.new(env, '1', storage: storage)
    deploy.replace
  end

  it 'should upload files in storage to bucket' do
    expect(env_bucket).to receive(:upload).with(storage)

    deploy = Deploy.new(env, '1', storage: storage)
    deploy.upload(env_bucket)
  end

  it 'Should update env with the new version' do
    env.version = 'x'
    deploy = Deploy.new(env, '1', storage: storage)
    deploy.update_env
    expect(env.version).to eq '1'
  end

  it 'Should execute deploy' do
    deploy = Deploy.new(env, '1', storage: storage)
    expect(deploy).to receive(:current_version)
    expect(deploy).to receive(:download)
    expect(deploy).to receive(:replace)
    expect(deploy).to receive(:upload)
    expect(deploy).to receive(:delete_last_version)
    expect(deploy).to receive(:update_env)
    deploy.execute
  end
end
