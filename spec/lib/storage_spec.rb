require 'rails_helper'
require 'storage'

RSpec.describe Storage do
  let(:manager) { FileManager }

  it 'test that dont create empty folder' do
    storage = Storage.new(manager: manager)

    expect(manager).to receive(:write_file).with(storage.path_of('app/images/image1.jpg'))

    storage.create('app/')
    storage.create('app/images/')
    storage.create('app/images/image1.jpg')
  end

  it 'list files added' do
    storage = Storage.new(manager: manager)
    allow(manager).to receive(:write_file)

    storage.create('file1')
    storage.create('file2')
    storage.create('file3')
    expect(storage.keys).to include('file1', 'file2', 'file3')
  end

  it 'list files path' do
    storage = Storage.new(manager: manager)
    key = 'file'
    path = storage.path_of(key)

    allow(manager).to receive(:write_file)

    storage.create(key)
    expect(storage.keys).to include(key)
    expect(storage.paths).to include(path)
  end
end
