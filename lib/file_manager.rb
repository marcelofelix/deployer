require 'fileutils'

# Encapsulates file operations
class FileManager
  def self.create_dir(path)
    FileUtils.mkdir_p path
  end

  def self.create_file_at(directory, file)
    absolute_path = "#{directory}#{file}"
    create_dir Pathname.new(absolute_path).dirname
    File.open(absolute_path, 'wb') do |f|
      yield f
    end
  end

  def self.replace(directory, file, key, value)
    text = File.read("#{directory}#{file}")
    replaced = text.gsub(key, value)
    File.open(file, 'w') { |f| f.puts replaced }
  end

  def self.remove(path)
    FileUtils.rm_rf path
  end

  def self.open(directory, file)
    File.open("#{directory}#{file}")
  end
end
