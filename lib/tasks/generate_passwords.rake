desc 'GENERATE PASSWORDS FOR AUTSCH USERS'
task generate_passwords: :environment do
  users = User.all
  all_users_num = users.size
  puts 'Generating passwords for users:'
  users.each.with_index(1) do |user, index|
    print "#{index}/#{all_users_num}"
    if user.password_digest.nil?
      user.create_random_password
      print '#'
    end
    puts ''
  end
end
