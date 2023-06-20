# frozen_string_literal: true

class Route < ApplicationRecord
  validates_presence_of :path
  validates_presence_of :route
end
