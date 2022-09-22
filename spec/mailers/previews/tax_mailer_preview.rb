# Preview all emails at <http://localhost:3000/rails/mailers/tax_mailer>
class TaxMailerPreview < ActionMailer::Preview
  def tax_mailer
    TaxMailer.with(user: User.all.sample, tax: Tax.all.sample).tax_mailer
  end
end