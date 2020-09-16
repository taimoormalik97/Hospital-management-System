class BillDetail < ApplicationRecord
  belongs_to :hospital
  belongs_to :bill
  belongs_to :billable, polymorphic: true
  default_scope { where(hospital_id: Hospital.current_id) }
end
