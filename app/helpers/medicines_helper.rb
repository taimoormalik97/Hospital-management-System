module MedicinesHelper
  def medicine_quantity(medicine)
  	medicine.bill_details.find_by(billable_type: "Medicine", billable_id: medicine.id).quantity
  end
end
