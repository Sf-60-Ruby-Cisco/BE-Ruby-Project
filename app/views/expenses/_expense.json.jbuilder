json.extract! expense, :id, :description, :amount_cents, :date, :created_at, :updated_at
json.url expense_url(expense, format: :json)
