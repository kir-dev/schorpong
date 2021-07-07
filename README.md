Schörpong
=========

# Install

Run the following lines as your normal user:
```bash
sudo apt install rbenv
git clone https://github.com/kir-dev/schorpong
cd schorpong
rbenv install 2.6.3
gem install bundler
bundle install
sudo su postgres
psql -c 'create user "schorpong" with superuser password '\''schorpong'\'';'
exit
rails db:migrate
rails db:seed
```

# Configuration

If you want to use different database user, you can change the parameters in `config/database.yml`.

For the authentication use the `.env` file and set the `APP_ID ` and `APP_SECRET`variables.

# Deployment

To be written...
