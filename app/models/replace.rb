# frozen_string_literal: true
# Represents a replace that can be done at file
class Replace < ApplicationRecord
  belongs_to :environment
  validates :file, presence: true
  validates :key, presence: true
  validates :value, presence: true
end
