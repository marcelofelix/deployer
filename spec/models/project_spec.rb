require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'new project' do
    Project.create(name: 'Teste', bucket_name: 'teste', region: 'x')
    expect(Project.count).to eq 1
  end

  it 'required fields' do
    project = Project.create
    expect(project.invalid?).to eq true
    expect(project.errors).to include(:name)
    expect(project.errors).to include(:bucket_name)
  end

  it 'duplicate name' do
    build(:project, name: 'Teste').save
    build(:project, name: 'Teste').save
    expect(Project.count).to eq 1
  end

  it 'duplicate bucket_name' do
    build(:project, bucket_name: 'Teste').save
    build(:project, bucket_name: 'Teste').save
    expect(Project.count).to eq 1
  end

  it 'test list projet version' do
    bucket = instance_double('Bucket')
    expect(bucket).to receive(:list).and_return [
      '123/images/img1',
      '123/images/img2',
      '231/images/img1',
      'file'
    ]

    project = create(:project)
    expect(project.list_versions(bucket)).to eq %w(123 231)
  end
end
