class TaxMailer < ApplicationMailer
  def tax_mailer
    @user = params[:user]
    @due_tax = params[:tax]
    mail(to: @user.email, subject: "Upcoming tax payment of $#{@due_tax.amount} in 14 days")
  end
end