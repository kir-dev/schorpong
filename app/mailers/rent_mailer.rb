class RentMailer < ApplicationMailer
  def create_email
    @rent = params[:rent]
    mail(to:'sepsi.laszlo99@gmail.com', subject: 'Schörpong mail')
  end
end
