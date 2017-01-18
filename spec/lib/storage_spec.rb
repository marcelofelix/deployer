require 'rails_helper'
require 'storage'

RSpec.describe Storage do
  let(:manager) { FileManager }
  let(:storage) { Storage.new(manager: manager) }
  after { storage.remove }

  it 'test that dont create empty folder' do

    key = 'app/images/image1.jpg'
    expect(manager).to receive(:create_file_at)
      .with(storage.directory, key)

    storage.create('app/')
    storage.create('app/images/')
    storage.create(key)
  end

  it 'test that files created are stored in keys' do
    allow(manager).to receive(:create_file_at)

    storage.create('file1')
    storage.create('file2')
    storage.create('file3')
    expect(storage.keys).to include('file1', 'file2', 'file3')
  end

  it 'test replace file content' do
    file = 'main.js'
    key = 'URL'
    value = 'http://teste'

    allow(manager).to receive(:create_file_at)
    expect(manager).to receive(:replace)
      .with(storage.directory, file, key, value)

    storage.create(file)
    storage.replace(file, key, value)
    storage.remove
  end

  it 'test that just created files can be opened' do
    key = 'main.js'
    allow(manager).to receive(:create_file_at)
    expect(manager).to receive(:open)
      .with(storage.directory, key)

    storage.create(key)
    storage.open key
    expect { storage.open 'some file' }.to raise_error 'Key some file not found'

  end


end
