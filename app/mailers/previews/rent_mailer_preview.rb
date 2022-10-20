class RentMailerPreview < ActionMailer::Preview
  def create_email
    @rent = params[:rent]
    mail(to: User.first.mail, subject: 'Schörpong mail')
  end
end
