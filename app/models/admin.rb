class Admin < User
  has_many :purchase_orders, dependent: :nullify
end
