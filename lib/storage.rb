require 'file_manager'
require 'securerandom'

class Storage
  attr_reader :directory

  def initialize(manager: FileManager)
    @directory = "/tmp/#{SecureRandom.uuid}/"
    @manager = manager
    @files = []
  end

  def create(file)
    unless file.nil? || file.empty? || file.end_with?('/')
      manager.write_file(path_of(file)) do |f|
        @files << { key: file, path: path_of(file) }
        yield f
      end
    end
  end

  def keys
    @files.map { |e| e[:key] }
  end

  def paths
    @files.map { |e| e[:path] }
  end

  def files
    @files
  end

  def path_of(file)
    "#{directory}#{file}"
  end
  private

  attr_reader :manager

end
