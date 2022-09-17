# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'bcrypt'
require 'date'

pages = [{ title: 'Kölcsönzés leírás', name: 'rents' },
         { title: 'Rólunk', name: 'about' },
         { title: 'Szabályok', name: 'rules' },
         { title: 'Jelentkezés', name: 'teams' }]

pages.each { |page| Page.create!(page.merge content: 'Lorem ipsum dolor set') }

Article.create(
  title: 'Teszt article',
  intro: 'Lorme ipsum dolor sit amet',
  content: 'Lorem ipsum dolor sit amet valami valami hosszabb dolog'
)

team1 = Team.create(name: 'Teszt csapat1', score: 0)
team2 = Team.create(name: 'Teszt csapat2', score: 0)
teams = [{ team: team1, comment: 'Hello' }, { team: team2, comment: '' }]

users = [{ name: 'Teszt Elek', admin: true, teamid: 1, owner: true, active: true },
         { name: 'Elektrom Ágnes', admin: false, teamid: 1, owner: false, active: true },
         { name: 'Para Zita', admin: false, teamid: 2, owner: true, active: true },
         { name: 'Trab Antal', admin: true, teamid: 2, owner: true, active: false }]
users.each { |user|
  mail = user[:name].split[0].downcase + '@example.org'
  iteruser = User.create(name: user[:name], mail: mail , password: BCrypt::Password.create('123456'), admin: user[:admin])
  Membership.create(user_id: iteruser.id, team_id: teams[user[:teamid] - 1][:team].id, owner: user[:owner], active: user[:active])
}

event1 = Event.create(
  name: 'Teszt event',
  intro: 'This is an intro',
  content: 'Lorem ipsum dolor sit amet',
  application_deadline: DateTime.now + 5.days,
  event_date: DateTime.now + 6.days
)

teams.each { |t| Entry.create(team_id: t[:team].id, event_id: event1.id, showed_up: false, comment: t[:comment]) }

items = [{ name: 'Pohár', number: 3 },
         { name: 'Labda', number: 5 }]
items.each { |item| Item.create(item) }

rents = [{ item_id: 1, user_id: 1, begin: DateTime.new(2022,6,23,4,5,6), end: DateTime.new(2022,6,30,4,5,6)},
         { item_id: 2, user_id: 2, begin: DateTime.new(2022,6,24,4,5,6), end: DateTime.new(2022,6,29,4,5,6)}]
rents.each { |rent| Rent.create(rent) }
