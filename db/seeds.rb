# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'admin',
            email: 'admin@gmail.com',
            password: '09090909',
            password_confirmation: '09090909',
            admin: 'true')

User.create(name: "sample" ,
            email: "sample@gmail.com",
            password: "09090909",
            password_confirmation: "09090909",
            admin: "false"
            )

User.create(id: 1,
            name: "defalut" ,
            email: "defalut@gmail.com",
            password: "09090909",
            password_confirmation: "09090909",
            admin: "true"
            )

Label.create(name: "ruby",
             user_id: 1
            )
Label.create(name: "rails",
             user_id: 1
            )
Label.create(name: "javascript",
             user_id: 1
            )
