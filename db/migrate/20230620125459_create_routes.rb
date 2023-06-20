# frozen_string_literal: true

class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.string :path
      t.string :route

      t.timestamps
    end
  end
end
