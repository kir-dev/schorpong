desc "MIGRATE IMAGES FROM CARRIERWAVE TO ACTIVESTRORAGE"
task move_images: :environment do
  puts "Migtating "

  count = User.count
  User.all.each do |u|
    move_image(u, "User", count)
  end

  count = Team.count
  Team.all.each do |t|
    move_image(t, "Team", count)
  end

  count = Article.count
  Article.all.each do |a|
    move_image(a, "Article", count)
  end

  count = Event.count
  Event.all.each do |e|
    move_image(e, "Event", count)
  end
  puts "Done!"
end

desc "UPDATE ATTACHMENTS NAMES TO IMAGE"
task update_attachments: :environment do
  ActiveStorage::Attachment.update_all("name = 'image'")
  puts "Done!"
end

def move_image(object, name, count)
  print "#{name}: #{object.id} / #{count}"
  if (object.image?)
    print " #"
    object.new_image.attach(io: open("./public" + object.image.url),
                            filename: "image")
  end
  puts " "
end
