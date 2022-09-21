class TaxMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    due_taxes = Tax.due_taxes
    due_taxes.each do |tax|
      TaxMailer.with(user: tax.car.user, tax: tax).tax_mailer.deliver_now
    end
  end
end
