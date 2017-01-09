require 'file_manager'
require 'securerandom'

S3Object = Struct.new('S3Object', :key, :path)

# Represents a temporary file e should be used to store file from bucket
# before update then to another bucket
class Storage
  attr_reader :directory

  def initialize(manager: FileManager)
    @directory = "/tmp/#{SecureRandom.uuid}/"
    @manager = manager
    @files = []
  end

  def create(file)
    unless file.empty? || file.end_with?('/')
      @files << S3Object.new(file, path_of(file))
      manager.write_file(path_of(file)) do |f|
        yield f if block_given?
      end
    end
  end

  def keys
    @files.map { |e| e[:key] }
  end

  def paths
    @files.map { |e| e[:path] }
  end

  attr_reader :files

  def path_of(file)
    "#{directory}#{file}"
  end

  def replace(file, key, value)
    files.each do |f|
      manager.replace(f.path, key, value) if f.key.match file
    end
  end

  def remove
    manager.remove(@directory)
  end

  private

  attr_reader :manager
end
