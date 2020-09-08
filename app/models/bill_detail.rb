class BillDetail < ApplicationRecord
  belongs_to :bill
  belongs_to :billable
end
