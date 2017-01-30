# frozen_string_literal: true
require 'file_manager'
require 'securerandom'

# Represents a temporary file e should be used to store file from bucket
# before update then to another bucket
class Storage
  attr_reader :keys

  def initialize(manager: FileManager.new)
    @manager = manager
    @keys = []
  end

  def create(key)
    return if key.empty? || key.end_with?('/')
    keys << key
    manager.create_file_at(key) do |f|
      yield f if block_given?
    end
  end

  def open(key)
    raise "Key #{key} not found" unless keys.include? key
    manager.open(key)
  end

  def replace(file, key, value)
    @keys.each do |k|
      manager.replace(k, key, value) if k.end_with? file
    end
  end

  def remove
    manager.remove
  end

  private

  attr_reader :manager
end
