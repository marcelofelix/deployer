require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'new project' do
    Project.create(name: 'Teste', bucket_name: 'teste')
    expect(Project.count).to eq 1
  end

  it 'required fields' do
    project = Project.create
    expect(project.invalid?).to eq true
    expect(project.errors).to include(:name)
    expect(project.errors).to include(:bucket_name)
  end

  it 'duplicate name' do
    Project.create(name: 'Teste', bucket_name: 'Teste')
    Project.create(name: 'Teste', bucket_name: 'Teste1')
    expect(Project.count).to eq 1
  end

  it 'duplicate bucket_name' do
    Project.create(name: 'Teste', bucket_name: 'Teste')
    Project.create(name: 'Teste1', bucket_name: 'Teste')
    expect(Project.count).to eq 1
  end

  it 'show project version' do
    bucket = instance_double('Bucket')
    expect(bucket).to receive(:list).and_return [
      double(key: '1'), double(key: '2')
    ]

    project = create(:project)
    expect(project.list_versions(bucket)).to include('1', '2')
  end
end
