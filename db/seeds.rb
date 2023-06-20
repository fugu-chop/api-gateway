# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
routes_location = "#{Rails.root}/config/gateway_routes.yml".freeze
routes_hash = YAML.safe_load(File.open(routes_location))
routes_hash.each do |path, route|
  Route.create(path: path, route: route)
end
