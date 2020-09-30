namespace :sequence_id_in_prescription do
  task prescription: :environment do
    Hospital.all.each do |parent|
      cntr = 1
      parent.prescriptions.reorder("id").all.each do |nested|
        nested.sequence_num = cntr
        cntr += 1
        nested.save
      end
    end
  end
end
