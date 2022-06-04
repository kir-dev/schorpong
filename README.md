Schörpong
=========

# Install

Run the following lines as your normal user:
```bash
sudo apt install rbenv
git clone https://github.com/kir-dev/schorpong
cd schorpong
rbenv install 3.0.3
gem install bundler
bundle install
sudo su postgres
psql -c 'create user "schorpong" with superuser password '\''schorpong'\'';'
exit
rails db:migrate
rails db:seed
```

# Configuration

All environment variables have a default value, so the app can be started without a .env file.
The default database setup expects you to run a PostgreSQL server on `localhost:5432`, and have a user named `postgres`, with `postgres` as password.
You can create it this with the following command:
```shell
sudo -u postgres createuser -Ps postgres
```
To override the default copy the `.env.example` to create the `.env` file.

```shell
cp .env.example .env
```

If you want to setup login with AutSCH, register your app and provide the `APP_ID ` and `APP_SECRET`variables in the `.env` file.

The redirect path for the AuthSCH entry should be `	http://localhost:3000/auth/oauth/callback/`
# Deployment

To be written...
