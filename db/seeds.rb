# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Manufacturerのシードデータ
manufacturers = ['トヨタ', 'ホンダ', '日産', 'マツダ', 'スズキ', 'ダイハツ', 'スバル']

manufacturers.each do |name|
  Manufacturer.find_or_create_by!(name: name)
end

puts "#{Manufacturer.count}件のメーカーを登録しました"