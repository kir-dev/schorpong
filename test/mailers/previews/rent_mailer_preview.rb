# Preview all emails at http://localhost:3000/rails/mailers/rent_mailer
class RentMailerPreview < ActionMailer::Preview
  def create_email
    @rent = Rent.last
    RentMailer.with(rent: @rent).create_email
  end
end
