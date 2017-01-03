require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'new project' do
    Project.create(name: 'Teste', bucket: 'teste')
    expect(Project.count).to eq 1
  end

  it 'required fields' do
    project = Project.create
    expect(project.invalid?).to eq true
    expect(project.errors).to include(:name)
    expect(project.errors).to include(:bucket)
  end

  it 'duplicate name' do
    Project.create(name: 'Teste', bucket: 'Teste')
    Project.create(name: 'Teste', bucket: 'Teste1')
    expect(Project.count).to eq 1
  end

  it 'duplicate bucket' do
    Project.create(name: 'Teste', bucket: 'Teste')
    Project.create(name: 'Teste1', bucket: 'Teste')
    expect(Project.count).to eq 1
  end

  it 'sync versions' do
    bucket = double('Bucket')
    expect(bucket).to receive(:list).and_return [
      double(name: '123')
    ]

    project = create(:project, bucket: 'owners-assets.com.br')
    project.sync_version(build_bucket: bucket)
    expect(project.versions.size).to eq 1
  end
end
