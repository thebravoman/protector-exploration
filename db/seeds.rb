# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(role: "admin")
user = User.create(role: "user")

Article.create(title: "Draft article by admin", text: "the text", hidden: true, user: admin)
Article.create(title: "Draft article by user", text: "the text", hidden: true, user: user)

Article.create(title: "Public article by admin", text: "the text", hidden: false, user: admin)
Article.create(title: "Public article by user", text: "the text", hidden: false, user: user)
