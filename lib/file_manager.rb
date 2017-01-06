require 'fileutils'

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
end
