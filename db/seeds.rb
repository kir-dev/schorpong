# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Page.create(title: 'Rólunk', name: 'about', content: 'Lorem ipsum dolor set')
Page.create(title: 'Szabályok', name: 'rules', content: 'Lorem ipsum dolor set')
Page.create(title: 'Jelentkezés', name: 'teams', content: 'Lorem ipsum dolor set')

Article.create(
  title: 'Teszt article',
  intro: 'Lorme ipsum dolor sit amet',
  content: 'Lorem ipsum dolor sit amet valami valami hosszabb dolog'
)

user1 = User.create(name: 'Teszt Ellek', mail: 'mail@example.org', admin: true)
user2 = User.create(name: 'Elektrom Ágnes', mail: 'elektrom@example.org', admin: false)
user3 = User.create(name: 'Para Zita', mail: 'para@example.org', admin: false)
user4 = User.create(name: 'Trab Antal', mail: 'trab@example.org', admin: true)

team1 = Team.create(name: 'Teszt csapat1', score: 0)
team2 = Team.create(name: 'Teszt csapat2', score: 0)

Membership.create(user_id: user1.id, team_id: team1.id, owner: true, active: true)
Membership.create(user_id: user2.id, team_id: team1.id, owner: false, active: true)
Membership.create(user_id: user3.id, team_id: team2.id, owner: true, active: true)
Membership.create(user_id: user4.id, team_id: team2.id, owner: true, active: false)

event1 = Event.create(
  name: 'Teszt event',
  intro: 'This is an intro',
  content: 'Lorem ipsum dolor sit amet',
  application_deadline: DateTime.now + 5.days,
  event_date: DateTime.now + 6.days
)

Entry.create(team_id: team1.id, event_id: event1.id, showed_up: false)
Entry.create(team_id: team2.id, event_id: event1.id, showed_up: false, comment: 'Hello')
