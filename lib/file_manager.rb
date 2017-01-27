require 'fileutils'

# Encapsulates file operations
class FileManager

  def initialize
    @base = "#{Rails.root}/tmp/files/#{SecureRandom.uuid}/"
  end

  def create_dir(path)
    FileUtils.mkdir_p path
  end

  def create_file_at(file)
    create_dir Pathname.new(path_to(file)).dirname
    File.open(path_to(file), 'wb') do |f|
      yield f
    end
  end

  def replace(file, key, value)
    text = File.read path_to file
    replaced = text.gsub(key, value)
    File.open(path_to(file), 'w') { |f| f.puts replaced }
  end

  def remove
    FileUtils.rm_rf base
  end

  def open(file)
    File.open(path_to(file))
  end

  def path_to(file)
    "#{base}#{file}"
  end

  private

  attr_reader :base
end
