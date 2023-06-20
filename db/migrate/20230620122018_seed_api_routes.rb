# frozen_string_literal: true

class SeedApiRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :api_routes do |t|
      t.string :path
      t.string :route

      t.timestamps
    end
  end
end
