require 'fileutils'

# Encapsulates file operations
class FileManager
  def self.create_dir(path)
    FileUtils.mkdir_p path
  end

  def self.write_file(file)
    create_dir Pathname.new(file).dirname
    File.open(file, 'wb') do |f|
      yield f
    end
  end

  def self.replace(file, key, value)
    text = File.read(file)
    replaced = text.gsub(key, value)
    File.open(file, 'w') { |f| f.puts replaced }
  end

  def self.remove(path)
    FileUtils.rm_rf path
  end
end
