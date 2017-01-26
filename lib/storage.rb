require 'file_manager'
require 'securerandom'

# Represents a temporary file e should be used to store file from bucket
# before update then to another bucket
class Storage
  attr_reader :directory, :keys

  def initialize(manager: FileManager)
    @directory = "#{Rails.root}/tmp/files/#{SecureRandom.uuid}/"
    @manager = manager
    @keys = []
  end

  def create(key)
    unless key.empty? || key.end_with?('/')
      keys << key
      manager.create_file_at(directory, key) do |f|
        yield f if block_given?
      end
    end
  end

  def open(key)
    raise "Key #{key} not found" unless keys.include? key
    manager.open(directory, key)
  end

  def replace(file, key, value)
    @keys.each do |k|
      manager.replace(directory, k, key, value) if k.end_with? file
    end
  end

  def remove
    manager.remove(@directory)
  end

  private

  attr_reader :manager
end
