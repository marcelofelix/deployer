require 'rails_helper'
require 'storage'

RSpec.describe Storage do
  let(:manager) { FileManager.new }
  after { manager.remove }

  it 'test create directory' do
    path = 'some path'
    expect(FileUtils).to receive(:mkdir_p).with(path)
    manager.create_dir(path)
  end

  it 'test create file at directory' do
    file = double
    path = double
    expect(path).to receive(:dirname)
    expect(FileUtils).to receive(:mkdir_p)
    expect(Pathname).to receive(:new).and_return path
    expect(File).to receive(:open).and_yield file
    file = 'some file'
    called = false
    manager.create_file_at(file) { called = true }
    expect(called).to eq true
  end
end
